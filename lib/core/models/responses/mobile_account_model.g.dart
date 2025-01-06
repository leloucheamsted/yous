// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MobileAccountModel _$MobileAccountModelFromJson(Map<String, dynamic> json) =>
    MobileAccountModel(
      userName: json['UserName'] as String?,
      id: json['Id'] as int?,
      email: json['Email'] as String?,
      imageUrl: json['ImageUrl'] as String?,
      token: json['YsAuthToken'] as String?,
      trackingId: json['TrackingId'] as String?,
      isSubscriber: json['IsSubscriber'] as bool?,
      cobranding: json['Cobranding'] as String?,
      additionnalRightRequired: json['AdditionnalRightRequired'] as bool?,
      additionnalRightExpiration: json['AdditionnalRightExpiration'] == null
          ? null
          : DateTime.parse(json['AdditionnalRightExpiration'] as String),
      avatarUrls: (json['AvatarUrls'] as List<dynamic>?)
          ?.map((e) => ImageUrlOutput.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MobileAccountModelToJson(MobileAccountModel instance) =>
    <String, dynamic>{
      'UserName': instance.userName,
      'Id': instance.id,
      'Email': instance.email,
      'ImageUrl': instance.imageUrl,
      'YsAuthToken': instance.token,
      'TrackingId': instance.trackingId,
      'IsSubscriber': instance.isSubscriber,
      'Cobranding': instance.cobranding,
      'AdditionnalRightRequired': instance.additionnalRightRequired,
      'AdditionnalRightExpiration':
          instance.additionnalRightExpiration?.toIso8601String(),
      'AvatarUrls': instance.avatarUrls,
    };
