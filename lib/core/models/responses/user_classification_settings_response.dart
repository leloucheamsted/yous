import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'user_classification_settings_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class UserClassificationSettingsResponse {
  UserClassificationSettingsResponse({
    this.classificationTreeId,
  });

  factory UserClassificationSettingsResponse.fromJson(
          Map<String, dynamic> json) =>
      _$UserClassificationSettingsResponseFromJson(json);
  int? classificationTreeId;

  String toJson() {
    final map = _$UserClassificationSettingsResponseToJson(this);
    return jsonEncode(map);
  }
}
