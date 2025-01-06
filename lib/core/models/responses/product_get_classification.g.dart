// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_get_classification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductGetClassification _$ProductGetClassificationFromJson(
        Map<String, dynamic> json) =>
    ProductGetClassification(
      json['Id'] as int?,
      json['Name'] as String?,
      json['Label'] as String?,
      json['SortOrder'] as int?,
      json['Type'] as String?,
    );

Map<String, dynamic> _$ProductGetClassificationToJson(
        ProductGetClassification instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Label': instance.label,
      'SortOrder': instance.sortOrder,
      'Type': instance.type,
    };
