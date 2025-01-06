// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_per_theme_search_output_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsPerThemeSearchOutputModel _$ProductsPerThemeSearchOutputModelFromJson(
        Map<String, dynamic> json) =>
    ProductsPerThemeSearchOutputModel(
      json['ThemeId'] as int?,
      json['ClassificationId'] as int?,
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

Map<String, dynamic> _$ProductsPerThemeSearchOutputModelToJson(
        ProductsPerThemeSearchOutputModel instance) =>
    <String, dynamic>{
      'Products': instance.products,
      'Themes': instance.themes,
      'Categories': instance.categories,
      'Languages': instance.languages,
      'Classifications': instance.classifications,
      'TotalResults': instance.totalResults,
      'ThemeId': instance.themeId,
      'ClassificationId': instance.classificationId,
    };
