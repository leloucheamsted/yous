// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_suggestions_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSuggestionsResultModel _$ProductSuggestionsResultModelFromJson(
        Map<String, dynamic> json) =>
    ProductSuggestionsResultModel(
      products: (json['Products'] as List<dynamic>?)
          ?.map((e) =>
              ProductSearchItemOutputModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      collections: (json['Collections'] as List<dynamic>?)
          ?.map((e) => CollectionSearchOutputItemModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      authors: (json['Authors'] as List<dynamic>?)
          ?.map((e) =>
              PeopleSearchOutputItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductSuggestionsResultModelToJson(
        ProductSuggestionsResultModel instance) =>
    <String, dynamic>{
      'Products': instance.products,
      'Collections': instance.collections,
      'Authors': instance.authors,
    };
