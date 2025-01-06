import 'dart:async';

import 'package:youscribe/core/entities/bookmark_entity.dart';

abstract class BookMarkRemoteDataSource {
  Future<void> deleteBookmarkAsync(int model);
  FutureOr<List<BookmarkEntity>> getBookmarkAsync();
  Future<BookmarkEntity> upsertBookmarkAsync(BookmarkEntity model);
}
