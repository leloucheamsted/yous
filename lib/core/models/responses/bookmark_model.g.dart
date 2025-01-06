// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookmarkModel _$BookmarkModelFromJson(Map<String, dynamic> json) =>
    BookmarkModel(
      id: json['Id'] as int,
      productId: json['ProductId'] as int,
      idRef: json['IdRef'] as String?,
      note: json['Note'] as String?,
      contentCFI: json['ContentCFI'] as String?,
      date: DateTime.parse(json['Date'] as String),
      progress: (json['Progress'] as num).toDouble(),
      pageNumber: json['PageNumber'] as int,
      type: $enumDecodeNullable(_$AccountBookmarkTypeEnumMap, json['Type']) ??
          AccountBookmarkType.auto,
    );

Map<String, dynamic> _$BookmarkModelToJson(BookmarkModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'ProductId': instance.productId,
      'IdRef': instance.idRef,
      'Note': instance.note,
      'ContentCFI': instance.contentCFI,
      'Date': instance.date.toIso8601String(),
      'Progress': instance.progress,
      'PageNumber': instance.pageNumber,
      'Type': _$AccountBookmarkTypeEnumMap[instance.type]!,
    };

const _$AccountBookmarkTypeEnumMap = {
  AccountBookmarkType.auto: 0,
  AccountBookmarkType.user: 1,
};
