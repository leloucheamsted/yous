// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_facebook_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MobileFacebookAccount _$MobileFacebookAccountFromJson(
        Map<String, dynamic> json) =>
    MobileFacebookAccount(
      isSubscriber: json['IsSubscriber'] as bool?,
      cobranding: json['Cobranding'] as String?,
      isNewUser: json['IsNewUser'] as bool?,
      properties: (json['Properties'] as List<dynamic>?)
          ?.map((e) => AccountGetProperties.fromJson(e as Map<String, dynamic>))
          .toList(),
      avatarUrls: (json['AvatarUrls'] as List<dynamic>?)
          ?.map((e) => ImageUrlOutput.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MobileFacebookAccountToJson(
        MobileFacebookAccount instance) =>
    <String, dynamic>{
      'IsSubscriber': instance.isSubscriber,
      'Cobranding': instance.cobranding,
      'IsNewUser': instance.isNewUser,
      'AvatarUrls': instance.avatarUrls,
      'Properties': instance.properties,
    };
