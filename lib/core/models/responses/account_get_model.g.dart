// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_get_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountGetModel _$AccountGetModelFromJson(Map<String, dynamic> json) =>
    AccountGetModel(
      avatarUrls: (json['AvatarUrls'] as List<dynamic>)
          .map((e) => ImageUrlOutput.fromJson(e as Map<String, dynamic>))
          .toList(),
      properties: (json['Properties'] as List<dynamic>)
          .map(
              (e) => AccountPropertiesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccountGetModelToJson(AccountGetModel instance) =>
    <String, dynamic>{
      'AvatarUrls': instance.avatarUrls,
      'Properties': instance.properties,
    };
