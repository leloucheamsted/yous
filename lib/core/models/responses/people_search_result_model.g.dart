// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_search_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeopleSearchResultModel _$PeopleSearchResultModelFromJson(
        Map<String, dynamic> json) =>
    PeopleSearchResultModel()
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
      ..people = (json['Peoples'] as List<dynamic>?)
          ?.map((e) =>
              PeopleSearchOutputItemModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$PeopleSearchResultModelToJson(
        PeopleSearchResultModel instance) =>
    <String, dynamic>{
      'Products': instance.products,
      'Themes': instance.themes,
      'Categories': instance.categories,
      'Languages': instance.languages,
      'Classifications': instance.classifications,
      'TotalResults': instance.totalResults,
      'Peoples': instance.people,
    };
