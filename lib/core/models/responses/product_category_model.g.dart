// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCategoryModel _$ProductCategoryModelFromJson(
        Map<String, dynamic> json) =>
    ProductCategoryModel(
      name: json['Name'] as String?,
      label: json['Label'] as String?,
      isPublic: json['IsPublic'] as bool?,
      description: json['Description'] as String?,
      children: (json['Children'] as List<dynamic>?)
          ?.map((e) => ProductCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['Id'] as int?,
    );

Map<String, dynamic> _$ProductCategoryModelToJson(
        ProductCategoryModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Label': instance.label,
      'IsPublic': instance.isPublic,
      'Description': instance.description,
      'Children': instance.children,
    };
