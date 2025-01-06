// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LibraryProductModel _$LibraryProductModelFromJson(Map<String, dynamic> json) =>
    LibraryProductModel(
      isPublic: json['IsPublic'] as bool?,
      creationDate: json['CreationDate'] == null
          ? null
          : DateTime.parse(json['CreationDate'] as String),
      product: json['Product'] == null
          ? null
          : YSProductGetModel.fromJson(json['Product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LibraryProductModelToJson(
        LibraryProductModel instance) =>
    <String, dynamic>{
      'IsPublic': instance.isPublic,
      'CreationDate': instance.creationDate?.toIso8601String(),
      'Product': instance.product,
    };
