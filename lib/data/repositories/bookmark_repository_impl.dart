import 'dart:async';

import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/bookmark_entity.dart';
import 'package:youscribe/core/repositories/bookmark_repository.dart';
import 'package:youscribe/data/data_sources/bookmark_data_sources/bookmark_local_data_source.dart';
import 'package:youscribe/data/data_sources/bookmark_data_sources/bookmark_remote_data_source.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  final BookmarksLocalDataSource _bookmarksLocalDataSource = locator();
  final BookMarkRemoteDataSource _bookMarkRemoteDataSource = locator();
  @override
  Future<bool> deleteBookmark(BookmarkEntity bookmark) {
    // TODO: implement deleteBookmark
    throw UnimplementedError();
  }

  @override
  Future<void> deleteBookmarkByIdOnSync(int bookmarkId) {
    // TODO: implement deleteBookmarkByIdOnSync
    throw UnimplementedError();
  }

  @override
  Future<void> deleteBookmarkForProduct(
      int bookmarkId, int productId, int pageNumber, double progress) {
    // TODO: implement deleteBookmarkForProduct
    throw UnimplementedError();
  }

  @override
  Future<void> deleteBookmarkOnSync(BookmarkEntity bookmark) {
    return _bookmarksLocalDataSource.deleteBookmarkOnSync(bookmark);
  }

  @override
  Future<void> deleteEveryBookMarks() {
    return _bookmarksLocalDataSource.deleteEveryBookMarks();
  }

  @override
  Future<bool> hasAnyBookmark() {
    return _bookmarksLocalDataSource.hasAnyBookmark();
  }

  @override
  Future<BookmarkEntity?> isBookmarkInLocal(int bookmarkId) {
    return _bookmarksLocalDataSource.isBookmarkInLocal(bookmarkId);
  }

  @override
  Future<BookmarkEntity?> getAutoBookmark(int productId) {
    return _bookmarksLocalDataSource.retrieveAutoBookmark(productId);
  }

  @override
  Future<BookmarkEntity?> retrieveBookmark(int productId) {
    return _bookmarksLocalDataSource.retrieveBookmark(productId);
  }

  @override
  Future<List<BookmarkEntity>?> retrieveBookmarks(int productId) {
    return _bookmarksLocalDataSource.retrieveBookmarks(productId);
  }

  @override
  Future<List<BookmarkEntity>?> retrieveBookmarksNotInList(
      List<int> bookmarkIds) {
    return _bookmarksLocalDataSource.retrieveBookmarksNotInList(bookmarkIds);
  }

  @override
  Future<List<BookmarkEntity>?> retrieveValidBookmarks(int productId) {
    return _bookmarksLocalDataSource.retrieveValidBookmarks(productId);
  }

  @override
  Future<void> saveBookmarks(List<BookmarkEntity> bookmarks) {
    return _bookmarksLocalDataSource.saveBookmarks(bookmarks);
  }

  @override
  Future<bool> updateBookmark(BookmarkEntity bookmark) {
    return _bookmarksLocalDataSource.updateBookmark(bookmark);
  }

  @override
  Future<void> updateBookmarkSyncAttributes(
      int productId, BookmarkEntity bookmark) {
    return _bookmarksLocalDataSource.updateBookmarkSyncAttributes(
        productId, bookmark);
  }

  @override
  Future<void> upsertBookmark(int productId, BookmarkEntity bookmark) {
    return _bookmarksLocalDataSource.upsertBookmark(productId, bookmark);
  }

  @override
  Future<void> upsertBookmarkForSync(int productId, BookmarkEntity bookmark) {
    return _bookmarksLocalDataSource.upsertBookmarkForSync(productId, bookmark);
  }

  @override
  Future<void> upsertBookmarks(List<BookmarkEntity> bookmarks) {
    return _bookmarksLocalDataSource.upsertBookmarks(bookmarks);
  }

  @override
  Future<void> deleteBookmarkAsync(int model) {
    return _bookMarkRemoteDataSource.deleteBookmarkAsync(model);
  }

  @override
  FutureOr<List<BookmarkEntity>> getBookmarkAsync() {
    return _bookMarkRemoteDataSource.getBookmarkAsync();
  }

  @override
  Future<BookmarkEntity> upsertBookmarkAsync(BookmarkEntity model) {
    return _bookMarkRemoteDataSource.upsertBookmarkAsync(model);
  }
}
