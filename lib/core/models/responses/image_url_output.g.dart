// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_url_output.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageUrlOutput _$ImageUrlOutputFromJson(Map<String, dynamic> json) =>
    ImageUrlOutput(
      url: json['Url'] as String?,
      width: json['Width'] as int?,
      height: json['Height'] as int?,
      type: $enumDecodeNullable(_$ImageTypeEnumMap, json['Type']),
    );

Map<String, dynamic> _$ImageUrlOutputToJson(ImageUrlOutput instance) =>
    <String, dynamic>{
      'Url': instance.url,
      'Width': instance.width,
      'Height': instance.height,
      'Type': _$ImageTypeEnumMap[instance.type],
    };

const _$ImageTypeEnumMap = {
  ImageType.defaultImage: 0,
  ImageType.s: 1,
  ImageType.m: 2,
  ImageType.l: 3,
  ImageType.sWebP: 4,
  ImageType.mWebP: 5,
  ImageType.lWebP: 6,
};
