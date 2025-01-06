import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/image_url_output.dart';
part 'light_account_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class LightAccountModel {
  LightAccountModel({
    this.id,
    this.displayableUserName,
    this.biography,
    this.isFollowed,
    this.avatarUrls,
  });

  factory LightAccountModel.fromJson(Map<String, dynamic> json) =>
      _$LightAccountModelFromJson(json);
  int? id;
  String? displayableUserName;
  String? biography;
  bool? isFollowed;
  List<ImageUrlOutput>? avatarUrls;

  String toJson() {
    final map = _$LightAccountModelToJson(this);
    return jsonEncode(map);
  }
}
