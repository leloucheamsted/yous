import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'editorial_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class EditorialModel {
  EditorialModel({
    this.typeId,
    this.firstImage,
    this.secondImage,
    this.backgroundImage,
    this.firstLink,
    this.secondLink,
    this.order,
  });
  factory EditorialModel.fromJson(Map<String, dynamic> json) =>
      _$EditorialModelFromJson(json);
  int? typeId;
  String? firstImage;
  String? secondImage;
  String? backgroundImage;
  String? firstLink;
  String? secondLink;
  int? order;

  String toJson() {
    final map = _$EditorialModelToJson(this);
    return jsonEncode(map);
  }
}
