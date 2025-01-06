import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'product_get_classification.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ProductGetClassification {
  ProductGetClassification(
    this.id,
    this.name,
    this.label,
    this.sortOrder,
    this.type,
  );
  factory ProductGetClassification.fromJson(Map<String, dynamic> json) =>
      _$ProductGetClassificationFromJson(json);
  int? id;
  String? name;
  String? label;
  int? sortOrder;
  String? type;

  String toJson() {
    final map = _$ProductGetClassificationToJson(this);
    return jsonEncode(map);
  }
}
