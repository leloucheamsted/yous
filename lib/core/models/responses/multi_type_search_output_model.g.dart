// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_type_search_output_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MutliTypeSearchOutPutModel _$MutliTypeSearchOutPutModelFromJson(
        Map<String, dynamic> json) =>
    MutliTypeSearchOutPutModel(
      products: (json['Products'] as List<dynamic>?)
          ?.map((e) =>
              ProductSearchItemOutputModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      authors: (json['Authors'] as List<dynamic>?)
          ?.map((e) =>
              PeopleSearchOutputItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      collections: (json['Collections'] as List<dynamic>?)
          ?.map((e) => CollectionSearchOutputItemModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MutliTypeSearchOutPutModelToJson(
        MutliTypeSearchOutPutModel instance) =>
    <String, dynamic>{
      'Products': instance.products,
      'Collections': instance.collections,
      'Authors': instance.authors,
    };
