import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'language_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class LanguageModel {
  LanguageModel({
    this.name,
    this.id,
  });
  factory LanguageModel.fromJson(Map<String, dynamic> json) =>
      _$LanguageModelFromJson(json);
  String? name;
  int? id;
  String? label;

  String toJson() {
    final map = _$LanguageModelToJson(this);
    return jsonEncode(map);
  }
}
