// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_suggests_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSuggestsResult _$ProductSuggestsResultFromJson(
        Map<String, dynamic> json) =>
    ProductSuggestsResult(
      productId: json['ProductId'] as int?,
      suggests: (json['Suggests'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductSuggestsResultToJson(
        ProductSuggestsResult instance) =>
    <String, dynamic>{
      'ProductId': instance.productId,
      'Suggests': instance.suggests,
    };
