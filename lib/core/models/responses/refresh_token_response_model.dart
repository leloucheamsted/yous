import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'refresh_token_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class RefreshTokenResponseModel {
  RefreshTokenResponseModel({
    this.tokenExpiry,
    this.accessToken,
    this.ysToken,
  });
  factory RefreshTokenResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponseModelFromJson(json);
  int? tokenExpiry;
  String? accessToken;
  String? ysToken;

  String toJson() {
    final map = _$RefreshTokenResponseModelToJson(this);
    return jsonEncode(map);
  }
}
