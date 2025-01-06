// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canal_plus_config_text_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CanalPlusConfigTextItem _$CanalPlusConfigTextItemFromJson(
        Map<String, dynamic> json) =>
    CanalPlusConfigTextItem(
      type: $enumDecodeNullable(
              _$CanalPlusConfigTextItemTypeEnumMap, json['Type']) ??
          CanalPlusConfigTextItemType.text,
      value: json['Value'] as String?,
    );

Map<String, dynamic> _$CanalPlusConfigTextItemToJson(
        CanalPlusConfigTextItem instance) =>
    <String, dynamic>{
      'Type': _$CanalPlusConfigTextItemTypeEnumMap[instance.type]!,
      'Value': instance.value,
    };

const _$CanalPlusConfigTextItemTypeEnumMap = {
  CanalPlusConfigTextItemType.text: 'Text',
  CanalPlusConfigTextItemType.link: 'Link',
};
