import 'dart:async';

import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/bookmark_entity.dart';
import 'package:youscribe/core/models/responses/bookmark_model.dart';
import 'package:youscribe/data/data_sources/base_remote_data_source.dart';
import 'package:youscribe/data/data_sources/bookmark_data_sources/bookmark_remote_data_source.dart';

class BookMarkRemoteDataSourceImpl extends BaseRemoteDataSource
    implements BookMarkRemoteDataSource {
  BookMarkRemoteDataSourceImpl(
      {required super.dio, required super.appSettings});

  @override
  Future<void> deleteBookmarkAsync(int model) async {
    final url = "${appSettings.mobileAPIUrl}/v1/bookmarks/$model";
    await delete(url);
  }

  @override
  FutureOr<List<BookmarkEntity>> getBookmarkAsync() async {
    final url = "${appSettings.mobileAPIUrl}v1/bookmarks";
    final response = await get(url);
    final responseList = response.data as List<dynamic>;
    final bookmarks = responseList
        .map<BookmarkModel>(
            (e) => BookmarkModel.fromJson(e as Map<String, Object>))
        .toList();
    if (bookmarks.isNull || bookmarks.any((element) => element.isNull)) {
      return List<BookmarkEntity>() = [];
    }
    return bookmarks
        .map((bookmark) => BookmarkEntity(
            userId: 0,
            productId: bookmark.productId,
            bookmarkId: bookmark.id,
            idRef: bookmark.idRef!,
            contentCFI: bookmark.contentCFI!,
            note: bookmark.note!,
            dateUpdate: DateTime.now(),
            dateSynchronized: DateTime.now(),
            pageNumber: bookmark.pageNumber,
            progress: bookmark.progress.toInt(),
            type: bookmark.type))
        .toList();
  }

  @override
  Future<BookmarkEntity> upsertBookmarkAsync(BookmarkEntity model) async {
    final url = "${appSettings.mobileAPIUrl}/v1/bookmarks";
    final Map<String, Object> body = {
      'Id': model.bookmarkId,
      'contentCFI': model.contentCFI,
      'Date': model.dateUpdate ?? DateTime.now(),
      'IdRef': model.idRef,
      'Note': model.note,
      'ProductId': model.productId,
      'PageNumber': model.pageNumber,
      'Progress': model.progress,
      'Type': model.type //(AccountBookmarkType) ((int) model.Type)
    };
    final response = await post(url, body);

    final result =
        BookmarkModel.fromJson(response.data! as Map<String, Object>);
    return BookmarkEntity(
        rowId: result.id,
        userId: 0,
        productId: result.productId,
        bookmarkId: result.id,
        idRef: result.idRef!,
        contentCFI: result.contentCFI!,
        note: result.note!,
        dateUpdate: DateTime.now(),
        dateSynchronized: DateTime.now(),
        pageNumber: result.pageNumber,
        progress: result.progress.toInt(),
        type: result.type);
  }
}
