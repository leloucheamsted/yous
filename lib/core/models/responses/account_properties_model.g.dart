// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_properties_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountPropertiesModel _$AccountPropertiesModelFromJson(
        Map<String, dynamic> json) =>
    AccountPropertiesModel(
      id: json['Id'] as int,
      value: json['Value'] as String,
      type: json['Type'] as String,
    );

Map<String, dynamic> _$AccountPropertiesModelToJson(
        AccountPropertiesModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Value': instance.value,
      'Type': instance.type,
    };
