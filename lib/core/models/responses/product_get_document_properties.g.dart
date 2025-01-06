// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_get_document_properties.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductGetDocumentProperties _$ProductGetDocumentPropertiesFromJson(
        Map<String, dynamic> json) =>
    ProductGetDocumentProperties(
      json['Id'] as int?,
      json['Value'] as String?,
      json['Type'] as String?,
    );

Map<String, dynamic> _$ProductGetDocumentPropertiesToJson(
        ProductGetDocumentProperties instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Value': instance.value,
      'Type': instance.type,
    };
