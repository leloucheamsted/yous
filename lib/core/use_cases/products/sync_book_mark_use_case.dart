import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/bookmark_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/models/responses/bookmark_model.dart';
import 'package:youscribe/core/repositories/bookmark_repository.dart';
import 'package:youscribe/utilities/view_utilities.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class SyncBookMarkUsecase extends AsyncUseCase<void, bool>
    with Debuggable, Loggable {
  final ConnectivityService connectivityService = locator();
  final BookmarkRepository bookmarkRepository = locator();

  @override
  String get debugName => 'SyncBookMarkUsecase';

  @override
  FutureOrResult<bool> execute(void params) async {
    try {
      if (await connectivityService.isInternetAvailable) {
        final everyOnlineBookmark = await bookmarkRepository.getBookmarkAsync();
        final hasLocalBookmark = await bookmarkRepository.hasAnyBookmark();

        if (!hasLocalBookmark && everyOnlineBookmark.isEmpty) {
          logInfo("No bookmark in API and no bookmark in local storage.");
          return const Ok(false);
        }

        if (!hasLocalBookmark && everyOnlineBookmark.isNotEmpty) {
          logInfo(
              "No bookmark in local storage, but bookmarks found in API.");

          await bookmarkRepository.saveBookmarks(everyOnlineBookmark);
        } else {
          logInfo(
              // ignore: lines_longer_than_80_chars
              'Bookmarks found in both API and local storage. Syncing going on.');

          BookmarkEntity? intersectingBookmark;
          List<BookmarkEntity>? bookmarksNotFoundInLocalButFoundOnline = [];
          final List<BookmarkEntity> bookmarksToUpsertForSync = [];
          for (final onlineBookmark in everyOnlineBookmark) {
            intersectingBookmark = await bookmarkRepository
                .isBookmarkInLocal(onlineBookmark.bookmarkId);
            if (intersectingBookmark.isNotNull) {
              onlineBookmark.localId = intersectingBookmark!.localId;
              if (onlineBookmark.dateUpdate!.toLocal().totalSeconds >
                  intersectingBookmark.dateUpdate!.totalSeconds) {
                onlineBookmark
                  ..dateSynchronized = DateTime.now()
                  ..synchronized = true;
                if (onlineBookmark.type == AccountBookmarkType.auto) {
                  await bookmarkRepository.upsertBookmarkForSync(
                      onlineBookmark.productId, onlineBookmark);
                } else {
                  bookmarksToUpsertForSync.add(onlineBookmark);
                }
              } else {
                try {
                  if (intersectingBookmark.deleted) {
                    logInfo("Deleting online intersecting bookmark");
                    await bookmarkRepository
                        .deleteBookmarkOnSync(intersectingBookmark);
                  } else if (onlineBookmark.dateUpdate!.toLocal().totalSeconds >
                      intersectingBookmark.dateUpdate!.totalSeconds) {
                    logInfo(
                        // ignore: lines_longer_than_80_chars
                        "updating online intersecting bookmark: ${intersectingBookmark.bookmarkId}");
                    intersectingBookmark.dateSynchronized = DateTime.now();
                    final bmk = await upsertBookmark(intersectingBookmark);
                    if (bmk != null) {
                      continue;
                    }

                    await bookmarkRepository.updateBookmarkSyncAttributes(
                        intersectingBookmark.productId, intersectingBookmark);
                  }
                } catch (e) {
                  logError("Error while upserting bookmark in API",
                      error: Exception(e));
                }
              }
            } else {
              if (onlineBookmark.type == AccountBookmarkType.auto) {
                final localAutoBm = await bookmarkRepository
                    .retrieveBookmark(onlineBookmark.productId);
                if (localAutoBm.isNotNull) {
                  if (localAutoBm!.bookmarkId.isNull) {
                    localAutoBm.bookmarkId = onlineBookmark.bookmarkId;
                  }
                  onlineBookmark.localId = localAutoBm.localId;
                  if (localAutoBm.dateUpdate!.totalSeconds >
                      onlineBookmark.dateUpdate!.toLocal().totalSeconds) {
                    try {
                      localAutoBm.dateSynchronized = DateTime.now();
                      copyBookmark(localAutoBm, onlineBookmark);
                      await bookmarkRepository
                          .upsertBookmarkAsync(onlineBookmark);
                      await bookmarkRepository.updateBookmarkSyncAttributes(
                          localAutoBm.productId, localAutoBm);
                    } catch (e) {
                      logError("Error while upserting bookmark online.",
                          error: Exception(e));
                    }
                  } else {
                    onlineBookmark.localId = localAutoBm.localId;
                    await bookmarkRepository.upsertBookmarkForSync(
                        onlineBookmark.productId, onlineBookmark);
                  }
                  continue;
                }
              }
              onlineBookmark
                ..synchronized = true
                ..dateSynchronized = DateTime.now();
              bookmarksNotFoundInLocalButFoundOnline.add(onlineBookmark);
            }
          }
          logInfo(
              // ignore: lines_longer_than_80_chars
              "Bookmarks not found in local but found online count: ${bookmarksNotFoundInLocalButFoundOnline.length}");
          await bookmarkRepository
              .saveBookmarks(bookmarksNotFoundInLocalButFoundOnline);
          await bookmarkRepository.upsertBookmarks(bookmarksToUpsertForSync);
          intersectingBookmark = null;
          bookmarksNotFoundInLocalButFoundOnline = null;
          final bookmarksNotFoundOnlineButFoundInLocal =
              await bookmarkRepository.retrieveBookmarksNotInList(
                  everyOnlineBookmark
                      .map((element) => element.bookmarkId)
                      .toList());

          if (bookmarksNotFoundOnlineButFoundInLocal.isNotNull &&
              bookmarksNotFoundOnlineButFoundInLocal!.isNotEmpty) {
            logInfo(
                // ignore: lines_longer_than_80_chars
                "Bookmarks not online but in local: ${bookmarksNotFoundOnlineButFoundInLocal.length}");
            for (final bookmark in bookmarksNotFoundOnlineButFoundInLocal) {
              if (bookmark.bookmarkId.isNull && !bookmark.deleted) {
                try {
                  bookmark.dateSynchronized = DateTime.now();
                  final bmk = await upsertBookmark(bookmark);

                  if (bmk != null) {
                    await bookmarkRepository.updateBookmarkSyncAttributes(
                        bmk.productId, bmk);
                  }
                } catch (e) {
                  logError("Error while updating bookmark online.",
                      error: Exception(e));
                }
              } else {
                await bookmarkRepository
                    .deleteBookmarkAsync(bookmark.bookmarkId);
              }
            }
          }
        }
      }
      return const Ok(true);
    } catch (e) {
      logError("Error occured while syncing bookmarks.",
          error: Exception(e));
      rethrow;
    }
  }

  void copyBookmark(BookmarkEntity src, BookmarkEntity dest) {
    dest
      ..bookmarkId = src.bookmarkId
      ..contentCFI = src.contentCFI
      ..dateSynchronized = DateTime.now() // Equivalent to DateTime.Now in C#
      ..dateUpdate = src.dateUpdate
      ..idRef = src.idRef
      ..note = src.note
      ..pageNumber = src.pageNumber
      ..productId = src.productId
      ..progress = src.progress
      ..userId = src.userId
      ..type = src.type;
  }

  Future<BookmarkEntity?> upsertBookmark(BookmarkEntity bookmark) async {
    try {
      final bmk = await bookmarkRepository.upsertBookmarkAsync(bookmark);
      return bmk;
    } on APIRequestException catch (e) {
      if (e.statusCode == 409) {
        // Duplicate bookmark error
        logInfo('Delete conflicting bookmark.');
        await bookmarkRepository.deleteBookmark(bookmark);
      }
      return null;
    }
  }
}
