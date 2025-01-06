// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_push_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImagePushContentModel _$ImagePushContentModelFromJson(
        Map<String, dynamic> json) =>
    ImagePushContentModel(
      imageUrl: json['ImageUrl'] as String?,
      title: json['Title'] as String?,
      selectionPageName: json['SelectionPageName'] as String?,
    );

Map<String, dynamic> _$ImagePushContentModelToJson(
        ImagePushContentModel instance) =>
    <String, dynamic>{
      'ImageUrl': instance.imageUrl,
      'Title': instance.title,
      'SelectionPageName': instance.selectionPageName,
    };
