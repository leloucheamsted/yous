// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_selection_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MySelectionProductModel _$MySelectionProductModelFromJson(
        Map<String, dynamic> json) =>
    MySelectionProductModel(
      product: json['Product'] == null
          ? null
          : ProductModel.fromJson(json['Product'] as Map<String, dynamic>),
      dateAdded: json['DateAdded'] == null
          ? null
          : DateTime.parse(json['DateAdded'] as String),
    );

Map<String, dynamic> _$MySelectionProductModelToJson(
        MySelectionProductModel instance) =>
    <String, dynamic>{
      'DateAdded': instance.dateAdded?.toIso8601String(),
      'Product': instance.product,
    };
