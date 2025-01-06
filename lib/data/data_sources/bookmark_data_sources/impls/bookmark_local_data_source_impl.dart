import 'package:isar/isar.dart';
import 'package:youscribe/core/entities/bookmark_entity.dart';
import 'package:youscribe/core/models/responses/bookmark_model.dart';
import 'package:youscribe/data/data_sources/base_local_data_source.dart';
import 'package:youscribe/data/data_sources/bookmark_data_sources/bookmark_local_data_source.dart';

class BookmarksLocalDataSourceImpl extends BaseLocalDataSource<BookmarkEntity>
    implements BookmarksLocalDataSource {
  BookmarksLocalDataSourceImpl(super.isar);

  @override
  Future<bool> deleteBookmark(BookmarkEntity bookmark) {
    if (bookmark.localId == null) {
      return Future.value(false);
    }

    return isar.writeTxn(() {
      return currentCollection.delete(bookmark.localId!);
    });
  }

  @override
  Future<void> deleteBookmarkByIdOnSync(int bookmarkId) {
    return isar.writeTxn(() async {
      await currentCollection
          .filter()
          .bookmarkIdEqualTo(bookmarkId)
          .deleteAll();
    });
  }

  @override
  Future<void> deleteBookmarkForProduct(
      int bookmarkId, int productId, int pageNumber, double progress) {
    return isar.writeTxn(() async {
      var b = await currentCollection
          .filter()
          .bookmarkIdEqualTo(bookmarkId)
          .productIdEqualTo(productId)
          .progressEqualTo(progress.toInt())
          .pageNumberEqualTo(pageNumber)
          .findFirst();

      if (b != null) {
        b = b.copyWith(dateUpdate: DateTime.now(), deleted: true);
        await currentCollection.put(b);
      }
    });
  }

  @override
  Future<void> deleteBookmarkOnSync(BookmarkEntity bookmark) {
    return isar.writeTxn(() async {
      await currentCollection.delete(bookmark.localId!);
    });
  }

  @override
  Future<void> deleteEveryBookMarks() {
    return isar.writeTxn(() {
      return currentCollection.clear();
    });
  }

  @override
  Future<bool> hasAnyBookmark() async {
    return await currentCollection.count() > 0;
  }

  @override
  Future<BookmarkEntity?> isBookmarkInLocal(int? bookmarkId) {
    return currentCollection
        .filter()
        .bookmarkIdEqualTo(bookmarkId!)
        .findFirst();
  }

  @override
  Future<BookmarkEntity?> retrieveAutoBookmark(int productId) {
    return currentCollection
        .filter()
        .productIdEqualTo(productId)
        .typeEqualTo(AccountBookmarkType.auto)
        .findFirst();
  }

  @override
  Future<BookmarkEntity?> retrieveBookmark(int productId) {
    return currentCollection.filter().productIdEqualTo(productId).findFirst();
  }

  @override
  Future<List<BookmarkEntity>> retrieveBookmarks(int productId) {
    return currentCollection.filter().productIdEqualTo(productId).findAll();
  }

  @override
  Future<List<BookmarkEntity>> retrieveBookmarksNotInList(
      List<int> bookmarkIds) {
    return currentCollection
        .filter()
        .anyOf(bookmarkIds, (q, element) => q.not().bookmarkIdEqualTo(element))
        .findAll();
  }

  @override
  Future<List<BookmarkEntity>> retrieveValidBookmarks(int productId) {
    return currentCollection
        .filter()
        .productIdEqualTo(productId)
        .deletedEqualTo(false)
        .findAll();
  }

  @override
  Future<void> saveBookmarks(List<BookmarkEntity> bookmarks) {
    return isar.writeTxn(() {
      return currentCollection.putAll(bookmarks);
    });
  }

  @override
  Future<bool> updateBookmark(BookmarkEntity bookmark) {
    return isar.writeTxn(() async {
      return await currentCollection.put(bookmark) > 1;
    });
  }

  @override
  Future<void> updateBookmarkSyncAttributes(
      int productId, BookmarkEntity bookmark) {
    return isar.writeTxn(() async {
      var b = await currentCollection
          .filter()
          .bookmarkIdEqualTo(bookmark.bookmarkId)
          .productIdEqualTo(productId)
          .findFirst();

      if (b != null) {
        //Note: the date updated and date synchronized are set in the outer
        //layer, so that
        //The bookmark sent to API has the same date as the local bookmark.
        b = b.copyWith(synchronized: true);
        await currentCollection.put(b);
      }
    });
  }

  @override
  Future<void> upsertBookmark(int productId, BookmarkEntity bookmark) {
    final newBookmark = bookmark.copyWith(
      dateSynchronized: DateTime.now(),
      dateUpdate: DateTime.now(),
      productId: productId,
    );

    return upsertBookmarkForSync(productId, newBookmark);
  }

  @override
  Future<void> upsertBookmarkForSync(int productId, BookmarkEntity bookmark) {
    return isar.writeTxn(() async {
      BookmarkEntity newBookmark = bookmark;

      if (bookmark.type == AccountBookmarkType.auto) {
        final b = await retrieveAutoBookmark(productId);

        if (b != null) {
          newBookmark = bookmark.copyWith(
            bookmarkId: b.bookmarkId,
            localId: b.localId,
          );
        }
      }

      await currentCollection.put(newBookmark);
    });
  }

  @override
  Future<void> upsertBookmarks(List<BookmarkEntity> bookmarks) {
    return isar.writeTxn(() async {
      await currentCollection.putAll(bookmarks);
    });
  }
}
