import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'account_properties_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class AccountPropertiesModel {
  AccountPropertiesModel(
      {required this.id, required this.value, required this.type});
  factory AccountPropertiesModel.fromJson(Map<String, dynamic> json) =>
      _$AccountPropertiesModelFromJson(json);
  final int id;
  final String value;
  final String type;

  String toJson() {
    final map = _$AccountPropertiesModelToJson(this);
    return jsonEncode(map);
  }
}
