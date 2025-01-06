// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'light_account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LightAccountModel _$LightAccountModelFromJson(Map<String, dynamic> json) =>
    LightAccountModel(
      id: json['Id'] as int?,
      displayableUserName: json['DisplayableUserName'] as String?,
      biography: json['Biography'] as String?,
      isFollowed: json['IsFollowed'] as bool?,
      avatarUrls: (json['AvatarUrls'] as List<dynamic>?)
          ?.map((e) => ImageUrlOutput.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LightAccountModelToJson(LightAccountModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DisplayableUserName': instance.displayableUserName,
      'Biography': instance.biography,
      'IsFollowed': instance.isFollowed,
      'AvatarUrls': instance.avatarUrls,
    };
