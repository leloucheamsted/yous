// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_v3_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeV3ContentModel _$HomeV3ContentModelFromJson(Map<String, dynamic> json) =>
    HomeV3ContentModel(
      imagePushs: (json['ImagePushs'] as List<dynamic>?)
          ?.map(
              (e) => ImagePushContentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      shelfPushs: (json['ShelfPushs'] as List<dynamic>?)
          ?.map(
              (e) => ShelfPushContentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      editorialItems: (json['EditorialItems'] as List<dynamic>?)
          ?.map((e) => EditoV3Model.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeV3ContentModelToJson(HomeV3ContentModel instance) =>
    <String, dynamic>{
      'ImagePushs': instance.imagePushs,
      'ShelfPushs': instance.shelfPushs,
      'EditorialItems': instance.editorialItems,
    };
