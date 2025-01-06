// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_get_document_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductGetDocumentFormat _$ProductGetDocumentFormatFromJson(
        Map<String, dynamic> json) =>
    ProductGetDocumentFormat(
      id: json['Id'] as int?,
      mimeType: json['MimeType'] as String?,
      extension: json['Extension'] as String?,
      formatTypeId: json['FormatTypeId'] as int?,
      eAN13: json['EAN13'] as String?,
      size: json['Size'] as int?,
    );

Map<String, dynamic> _$ProductGetDocumentFormatToJson(
        ProductGetDocumentFormat instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'MimeType': instance.mimeType,
      'Extension': instance.extension,
      'FormatTypeId': instance.formatTypeId,
      'EAN13': instance.eAN13,
      'Size': instance.size,
    };
