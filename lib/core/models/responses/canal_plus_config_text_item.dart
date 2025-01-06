import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/canalplus_config_model.dart';

part 'canal_plus_config_text_item.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class CanalPlusConfigTextItem {
  CanalPlusConfigTextItem({
    this.type = CanalPlusConfigTextItemType.text,
    this.value,
  });
  factory CanalPlusConfigTextItem.fromJson(Map<String, dynamic> json) =>
      _$CanalPlusConfigTextItemFromJson(json);
  @enumerated
  CanalPlusConfigTextItemType type;
  String? value;

  String toJson() {
    final map = _$CanalPlusConfigTextItemToJson(this);
    return jsonEncode(map);
  }
}
