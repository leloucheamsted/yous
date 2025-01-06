import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'follow_item_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class FollowItemModel {
  FollowItemModel(this.id, this.name);
  factory FollowItemModel.fromJson(Map<String, dynamic> json) =>
      _$FollowItemModelFromJson(json);
  int? id = 0;
  String? name = "";

  String toJson() {
    final map = _$FollowItemModelToJson(this);
    return jsonEncode(map);
  }
}
