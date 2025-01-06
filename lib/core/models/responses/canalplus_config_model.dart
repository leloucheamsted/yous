import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/canal_plus_config_text_item.dart';
part 'canalplus_config_model.g.dart';

enum CanalPlusConfigTextItemType {
  @JsonValue("Text")
  text,
  @JsonValue("Link")
  link,
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class CanalplusConfigModel {
  CanalplusConfigModel({
    this.allowed,
    List<CanalPlusConfigTextItem>? notSubscriberMessage,
  }) : notSubscriberMessage = notSubscriberMessage ?? [];
  factory CanalplusConfigModel.fromJson(Map<String, dynamic> json) =>
      _$CanalplusConfigModelFromJson(json);
  bool? allowed;
  List<CanalPlusConfigTextItem>? notSubscriberMessage;

  String toJson() {
    final map = _$CanalplusConfigModelToJson(this);
    return jsonEncode(map);
  }
}
