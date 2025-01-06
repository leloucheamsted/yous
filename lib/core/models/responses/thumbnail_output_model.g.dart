// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbnail_output_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThumbnailOutputModel _$ThumbnailOutputModelFromJson(
        Map<String, dynamic> json) =>
    ThumbnailOutputModel(
      thumbnailUrlS: json['ThumbnailUrlS'] as String?,
      thumbnailUrlM: json['ThumbnailUrlM'] as String?,
      thumbnailUrlL: json['ThumbnailUrlL'] as String?,
      thumbnailUrlSWebP: json['thumbnailUrlS_WebP'] as String?,
      thumbnailUrlMWebP: json['thumbnailUrlM_WebP'] as String?,
      thumbnailUrlLWebP: json['thumbnailUrlL_WebP'] as String?,
      isAdultContent: json['IsAdultContent'] as bool?,
    );

Map<String, dynamic> _$ThumbnailOutputModelToJson(
        ThumbnailOutputModel instance) =>
    <String, dynamic>{
      'ThumbnailUrlS': instance.thumbnailUrlS,
      'ThumbnailUrlM': instance.thumbnailUrlM,
      'ThumbnailUrlL': instance.thumbnailUrlL,
      'thumbnailUrlS_WebP': instance.thumbnailUrlSWebP,
      'thumbnailUrlM_WebP': instance.thumbnailUrlMWebP,
      'thumbnailUrlL_WebP': instance.thumbnailUrlLWebP,
      'IsAdultContent': instance.isAdultContent,
    };
