// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatalogPageModel _$CatalogPageModelFromJson(Map<String, dynamic> json) =>
    CatalogPageModel(
      json['Text'] as String?,
      json['Title'] as String?,
    )
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
      ..totalResults = json['TotalResults'] as int?;

Map<String, dynamic> _$CatalogPageModelToJson(CatalogPageModel instance) =>
    <String, dynamic>{
      'Products': instance.products,
      'Themes': instance.themes,
      'Categories': instance.categories,
      'Languages': instance.languages,
      'Classifications': instance.classifications,
      'TotalResults': instance.totalResults,
      'Text': instance.description,
      'Title': instance.title,
    };
