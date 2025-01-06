// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_type_search_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiTypeSearchRequestModel _$MultiTypeSearchRequestModelFromJson(
        Map<String, dynamic> json) =>
    MultiTypeSearchRequestModel(
      filters: json['Filters'] == null
          ? null
          : ProductSearchParameters.fromJson(
              json['Filters'] as Map<String, dynamic>),
      requestedSearch: (json['RequestedSearch'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$MultisearchTypeEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$MultiTypeSearchRequestModelToJson(
        MultiTypeSearchRequestModel instance) =>
    <String, dynamic>{
      'Filters': instance.filters,
      'RequestedSearch': instance.requestedSearch
          ?.map((e) => _$MultisearchTypeEnumMap[e]!)
          .toList(),
    };

const _$MultisearchTypeEnumMap = {
  MultisearchType.products: 'products',
  MultisearchType.audiobooks: 'audiobooks',
  MultisearchType.bds: 'bds',
  MultisearchType.books: 'books',
  MultisearchType.press: 'press',
  MultisearchType.authors: 'authors',
  MultisearchType.collections: 'collections',
};
