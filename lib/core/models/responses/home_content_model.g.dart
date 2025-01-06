// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeContentModel _$HomeContentModelFromJson(Map<String, dynamic> json) =>
    HomeContentModel(
      imagePushs: (json['ImagePushs'] as List<dynamic>?)
          ?.map(
              (e) => ImagePushContentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      shelfPushs: (json['ShelfPushs'] as List<dynamic>?)
          ?.map(
              (e) => ShelfPushContentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      editorials: (json['Editorials'] as List<dynamic>?)
          ?.map((e) => EditorialModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeContentModelToJson(HomeContentModel instance) =>
    <String, dynamic>{
      'ImagePushs': instance.imagePushs,
      'ShelfPushs': instance.shelfPushs,
      'Editorials': instance.editorials,
    };
