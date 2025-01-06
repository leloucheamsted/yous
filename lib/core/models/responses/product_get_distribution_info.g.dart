// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_get_distribution_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductGetDistributionInfo _$ProductGetDistributionInfoFromJson(
        Map<String, dynamic> json) =>
    ProductGetDistributionInfo(
      allowComment: json['AllowComment'] as bool?,
      isAdultContent: json['IsAdultContent'] as bool?,
      previewNbPage: json['PreviewNbPage'] as int?,
      previewPercentPage: json['PreviewPercentPage'] as int?,
      previewPage: json['PreviewPage'] as String?,
      displayMode: json['DisplayMode'] as String?,
    );

Map<String, dynamic> _$ProductGetDistributionInfoToJson(
        ProductGetDistributionInfo instance) =>
    <String, dynamic>{
      'AllowComment': instance.allowComment,
      'IsAdultContent': instance.isAdultContent,
      'PreviewNbPage': instance.previewNbPage,
      'PreviewPercentPage': instance.previewPercentPage,
      'PreviewPage': instance.previewPage,
      'DisplayMode': instance.displayMode,
    };
