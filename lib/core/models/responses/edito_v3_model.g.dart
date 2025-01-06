// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edito_v3_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditoV3Model _$EditoV3ModelFromJson(Map<String, dynamic> json) => EditoV3Model(
      json['Id'] as String?,
      json['Title'] as String?,
      json['SubTitle'] as String?,
      json['BrandId'] as int?,
      json['ImageKey'] as String?,
      json['ImageKeyOriginalM'] as String?,
      json['ImageKeyOriginalS'] as String?,
      json['ImageKeyXL'] as String?,
      json['ImageKeyM'] as String?,
      json['ImageKeyS'] as String?,
      json['ImageKeyXL_WebP'] as String?,
      json['ImageKeyM_WebP'] as String?,
      json['ImageKeyS_WebP'] as String?,
      json['CtaText'] as String?,
      json['CtaUrl'] as String?,
    );

Map<String, dynamic> _$EditoV3ModelToJson(EditoV3Model instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Title': instance.title,
      'SubTitle': instance.subTitle,
      'BrandId': instance.brandId,
      'ImageKey': instance.imageKey,
      'ImageKeyOriginalM': instance.imageKeyOriginalM,
      'ImageKeyOriginalS': instance.imageKeyOriginalS,
      'ImageKeyXL': instance.imageKeyXL,
      'ImageKeyM': instance.imageKeyM,
      'ImageKeyS': instance.imageKeyS,
      'ImageKeyXL_WebP': instance.imageKeyXlWebP,
      'ImageKeyM_WebP': instance.imageKeyMWebP,
      'ImageKeyS_WebP': instance.imageKeySWebP,
      'CtaText': instance.ctaText,
      'CtaUrl': instance.ctaUrl,
    };
