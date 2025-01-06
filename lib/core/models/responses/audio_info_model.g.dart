// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioInfoModel _$AudioInfoModelFromJson(Map<String, dynamic> json) =>
    AudioInfoModel(
      productId: json['productId'] as int?,
      playlistModel: (json['playlistModel'] as List<dynamic>?)
          ?.map((e) => AudioChapterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalSize: (json['totalSize'] as num?)?.toDouble(),
      totalDuration: (json['totalDuration'] as num?)?.toDouble(),
      thumbnail: json['thumbnail'] as String?,
      author: json['author'] as String?,
      title: json['title'] as String?,
      isExtract: json['isExtract'] as bool?,
      narrator: json['narrator'] as String?,
      nbParts: json['nbParts'] as int?,
    );

Map<String, dynamic> _$AudioInfoModelToJson(AudioInfoModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'playlistModel': instance.playlistModel,
      'totalSize': instance.totalSize,
      'totalDuration': instance.totalDuration,
      'thumbnail': instance.thumbnail,
      'author': instance.author,
      'title': instance.title,
      'isExtract': instance.isExtract,
      'narrator': instance.narrator,
      'nbParts': instance.nbParts,
    };
