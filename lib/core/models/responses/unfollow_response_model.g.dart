// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unfollow_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnfollowResponseModel _$UnfollowResponseModelFromJson(
        Map<String, dynamic> json) =>
    UnfollowResponseModel(
      isUnfollowed: json['IsUnfollowed'] as bool,
      id: json['Id'] as int,
    );

Map<String, dynamic> _$UnfollowResponseModelToJson(
        UnfollowResponseModel instance) =>
    <String, dynamic>{
      'IsUnfollowed': instance.isUnfollowed,
      'Id': instance.id,
    };
