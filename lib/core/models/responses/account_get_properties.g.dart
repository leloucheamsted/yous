// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_get_properties.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountGetProperties _$AccountGetPropertiesFromJson(
        Map<String, dynamic> json) =>
    AccountGetProperties(
      json['Id'] as int?,
      json['Value'] as String?,
      json['Type'] as String?,
    );

Map<String, dynamic> _$AccountGetPropertiesToJson(
        AccountGetProperties instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Value': instance.value,
      'Type': instance.type,
    };
