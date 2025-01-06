// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canalplus_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CanalplusConfigModel _$CanalplusConfigModelFromJson(
        Map<String, dynamic> json) =>
    CanalplusConfigModel(
      allowed: json['Allowed'] as bool?,
      notSubscriberMessage: (json['NotSubscriberMessage'] as List<dynamic>?)
          ?.map((e) =>
              CanalPlusConfigTextItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CanalplusConfigModelToJson(
        CanalplusConfigModel instance) =>
    <String, dynamic>{
      'Allowed': instance.allowed,
      'NotSubscriberMessage': instance.notSubscriberMessage,
    };
