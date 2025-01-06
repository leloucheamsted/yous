// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_commentary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCommentaryModel _$ProductCommentaryModelFromJson(
        Map<String, dynamic> json) =>
    ProductCommentaryModel(
      comments: json['Comments'] as String,
      source: json['Source'] as String? ?? '',
      opinionSource:
          $enumDecodeNullable(_$OpinionSourceEnumMap, json['OpinionSource']) ??
              OpinionSource.ysTeam,
    );

Map<String, dynamic> _$ProductCommentaryModelToJson(
        ProductCommentaryModel instance) =>
    <String, dynamic>{
      'Comments': instance.comments,
      'Source': instance.source,
      'OpinionSource': _$OpinionSourceEnumMap[instance.opinionSource]!,
    };

const _$OpinionSourceEnumMap = {
  OpinionSource.none: 'None',
  OpinionSource.ysTeam: 'YSTeam',
  OpinionSource.author: 'Author',
  OpinionSource.ambassador: 'Ambassador',
};
