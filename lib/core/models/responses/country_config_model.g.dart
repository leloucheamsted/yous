// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryConfigModel _$CountryConfigModelFromJson(Map<String, dynamic> json) =>
    CountryConfigModel(
      defaultCobranding: json['DefaultCobranding'] as String?,
      facebookAllowed: json['FacebookAllowed'] as bool?,
      registerAllowed: json['RegisterAllowed'] as bool?,
      inAppPurchaseAllowed: json['InAppPurchaseAllowed'] as bool?,
      countryCode: json['CountryCode'] as String?,
      garEnabled: json['GarEnabled'] as bool?,
      garAuthRedirectUrl: json['GarAuthRedirectUrl'] as String?,
      garLogoutUrl: json['GarLogoutUrl'] as String?,
      registerPopup: json['RegisterPopup'] == null
          ? null
          : CountryConfigPopupModel.fromJson(
              json['RegisterPopup'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CountryConfigModelToJson(CountryConfigModel instance) =>
    <String, dynamic>{
      'DefaultCobranding': instance.defaultCobranding,
      'FacebookAllowed': instance.facebookAllowed,
      'RegisterAllowed': instance.registerAllowed,
      'InAppPurchaseAllowed': instance.inAppPurchaseAllowed,
      'CountryCode': instance.countryCode,
      'GarEnabled': instance.garEnabled,
      'GarAuthRedirectUrl': instance.garAuthRedirectUrl,
      'GarLogoutUrl': instance.garLogoutUrl,
      'RegisterPopup': instance.registerPopup,
    };
