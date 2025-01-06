import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'unfollow_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class UnfollowResponseModel {
  UnfollowResponseModel({required this.isUnfollowed, required this.id});
  factory UnfollowResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UnfollowResponseModelFromJson(json);
  bool isUnfollowed;
  int id;

  String toJson() {
    final map = _$UnfollowResponseModelToJson(this);
    return jsonEncode(map);
  }
}
