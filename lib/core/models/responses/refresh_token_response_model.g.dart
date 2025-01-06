// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenResponseModel _$RefreshTokenResponseModelFromJson(
        Map<String, dynamic> json) =>
    RefreshTokenResponseModel(
      tokenExpiry: json['TokenExpiry'] as int?,
      accessToken: json['AccessToken'] as String?,
      ysToken: json['YsToken'] as String?,
    );

Map<String, dynamic> _$RefreshTokenResponseModelToJson(
        RefreshTokenResponseModel instance) =>
    <String, dynamic>{
      'TokenExpiry': instance.tokenExpiry,
      'AccessToken': instance.accessToken,
      'YsToken': instance.ysToken,
    };
