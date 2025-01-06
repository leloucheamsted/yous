// ignore_for_file: avoid_dynamic_calls

import 'dart:async';

import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
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
    final url = "${appSettings.mobileAPIUrl}/v1/bookmarks";
    final currentUser = await Auth.getCurrentUser();
    final response = await getWithType<List<dynamic>>(url);
    final responseList = response.data!;
    final bookmarks = responseList
        .map((e) => BookmarkModel.fromJson(e as Map<String, dynamic>))
        .toList();
    if (bookmarks.isNull || bookmarks.any((element) => element.isNull)) {
      return List<BookmarkEntity>() = [];
    }

    return bookmarks
        .map((e) => BookmarkEntity(
            userId: currentUser!.id!,
            productId: e.productId,
            pageNumber: e.pageNumber,
            progress: e.progress.toInt(),
            dateSynchronized: DateTime.now(),
            dateUpdate: e.date,
            note: e.note ?? '',
            contentCFI: e.contentCFI ?? '',
            idRef: e.idRef ?? ''))
        .toList();
  }

  @override
  Future<BookmarkEntity> upsertBookmarkAsync(BookmarkEntity model) async {
    final url = "${appSettings.mobileAPIUrl}/v1/bookmarks";
    final Map<String, dynamic> body = {
      'contentCFI': model.contentCFI,
      'Date': model.dateUpdate?.toIso8601String(),
      'IdRef': model.idRef,
      'Note': model.note,
      'ProductId': model.productId,
      'PageNumber': model.pageNumber,
      'Progress': model.progress,
      'Type': model.type.index 
    };
      final response = await post(url, body);

      final result = BookmarkModel.fromJson(response.data!);
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
