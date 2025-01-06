import 'dart:async';

import 'package:youscribe/core/entities/bookmark_entity.dart';

abstract class BookmarkRepository {
  Future<void> deleteBookmarkAsync(int model);
  FutureOr<List<BookmarkEntity>> getBookmarkAsync();
  Future<BookmarkEntity> upsertBookmarkAsync(BookmarkEntity model);
  Future<bool> updateBookmark(BookmarkEntity bookmark);
  Future<BookmarkEntity?> isBookmarkInLocal(int bookmarkId);
  Future<void> upsertBookmark(int productId, BookmarkEntity bookmark);
  Future<void> saveBookmarks(List<BookmarkEntity> bookmarks);
  Future<BookmarkEntity?> retrieveBookmark(int productId);
  Future<BookmarkEntity?> getAutoBookmark(int productId);
  Future<List<BookmarkEntity>?> retrieveValidBookmarks(int productId);
  Future<bool> hasAnyBookmark();
  Future<List<BookmarkEntity>?> retrieveBookmarksNotInList(
      List<int> bookmarkIds);
  Future<void> upsertBookmarks(List<BookmarkEntity> bookmarks);
  Future<void> deleteBookmarkForProduct(
      int bookmarkId, int productId, int pageNumber, double progress);
  Future<bool> deleteBookmark(BookmarkEntity bookmark);
  Future<void> deleteBookmarkByIdOnSync(int bookmarkId);
  Future<void> deleteBookmarkOnSync(BookmarkEntity bookmark);
  Future<List<BookmarkEntity>?> retrieveBookmarks(int productId);
  Future<void> upsertBookmarkForSync(int productId, BookmarkEntity bookmark);
  Future<void> updateBookmarkSyncAttributes(
      int productId, BookmarkEntity bookmark);
  Future<void> deleteEveryBookMarks();
}
