// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_get_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductGetDocument _$ProductGetDocumentFromJson(Map<String, dynamic> json) =>
    ProductGetDocument(
      json['Id'] as int?,
      (json['Properties'] as List<dynamic>?)
          ?.map((e) =>
              ProductGetDocumentProperties.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['DocumentProtectionTypeName'] as String?,
      (json['Formats'] as List<dynamic>?)
          ?.map((e) =>
              ProductGetDocumentFormat.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['NbPages'] as int?,
      json['PageWidthPoints'] as int?,
      json['PageHeightPoints'] as int?,
    );

Map<String, dynamic> _$ProductGetDocumentToJson(ProductGetDocument instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DocumentProtectionTypeName': instance.documentProtectionTypeName,
      'NbPages': instance.nbPages,
      'PageWidthPoints': instance.pageWidthPoints,
      'PageHeightPoints': instance.pageHeightPoints,
      'Properties': instance.properties,
      'Formats': instance.formats,
    };
