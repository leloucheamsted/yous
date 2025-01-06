// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_chapter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioChapterModel _$AudioChapterModelFromJson(Map<String, dynamic> json) =>
    AudioChapterModel(
      json['documentId'] as int?,
      json['title'] as String?,
      json['orderId'] as int?,
      (json['chapterDuration'] as num?)?.toDouble(),
    )
      ..productId = json['productId'] as int?
      ..chapterFileName = json['chapterFileName'] as String?
      ..mediaUrl = json['mediaUrl'] as String?
      ..mediaRealPath = json['mediaRealPath'] as String?
      ..chapterRealDuration = (json['chapterRealDuration'] as num?)?.toDouble()
      ..isExtract = json['isExtract'] as bool?;

Map<String, dynamic> _$AudioChapterModelToJson(AudioChapterModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'chapterDuration': instance.chapterDuration,
      'documentId': instance.documentId,
      'orderId': instance.orderId,
      'chapterFileName': instance.chapterFileName,
      'mediaUrl': instance.mediaUrl,
      'mediaRealPath': instance.mediaRealPath,
      'chapterRealDuration': instance.chapterRealDuration,
      'title': instance.title,
      'isExtract': instance.isExtract,
    };
