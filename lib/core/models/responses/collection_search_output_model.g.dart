// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_search_output_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionSearchOutputModel _$CollectionSearchOutputModelFromJson(
        Map<String, dynamic> json) =>
    CollectionSearchOutputModel()
      ..products = (json['Products'] as List<dynamic>?)
          ?.map((e) =>
              ProductSearchItemOutputModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..themes = (json['Themes'] as List<dynamic>?)
          ?.map((e) => ProductFacetModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..categories = (json['Categories'] as List<dynamic>?)
          ?.map((e) => ProductFacetModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..languages = (json['Languages'] as List<dynamic>?)
          ?.map((e) => LanguageModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..classifications = (json['Classifications'] as List<dynamic>?)
          ?.map((e) => ProductFacetModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..totalResults = json['TotalResults'] as int?
      ..collections = (json['Collections'] as List<dynamic>?)
          ?.map((e) => CollectionSearchOutputItemModel.fromJson(
              e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$CollectionSearchOutputModelToJson(
        CollectionSearchOutputModel instance) =>
    <String, dynamic>{
      'Products': instance.products,
      'Themes': instance.themes,
      'Categories': instance.categories,
      'Languages': instance.languages,
      'Classifications': instance.classifications,
      'TotalResults': instance.totalResults,
      'Collections': instance.collections,
    };
