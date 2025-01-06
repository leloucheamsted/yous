// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_device_local_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDeviceLocalModel _$AccountDeviceLocalModelFromJson(
        Map<String, dynamic> json) =>
    AccountDeviceLocalModel(
      id: json['Id'] as int?,
      deviceId: json['DeviceId'] as String?,
      deviceTypeName: json['DeviceTypeName'] as String?,
      os: json['Os'] as String?,
      osVersion: json['OsVersion'] as String?,
      lastSeen: json['LastSeen'] == null
          ? null
          : DateTime.parse(json['LastSeen'] as String),
      label: json['Label'] as String?,
      modelName: json['ModelName'] as String?,
    );

Map<String, dynamic> _$AccountDeviceLocalModelToJson(
        AccountDeviceLocalModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DeviceId': instance.deviceId,
      'DeviceTypeName': instance.deviceTypeName,
      'Os': instance.os,
      'OsVersion': instance.osVersion,
      'LastSeen': instance.lastSeen?.toIso8601String(),
      'Label': instance.label,
      'ModelName': instance.modelName,
    };
