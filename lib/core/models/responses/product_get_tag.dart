import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'product_get_tag.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ProductGetTag {
  ProductGetTag(
    this.id,
    this.value,
  );
  factory ProductGetTag.fromJson(Map<String, dynamic> json) =>
      _$ProductGetTagFromJson(json);
  int? id;
  String? value;

  String toJson() {
    final map = _$ProductGetTagToJson(this);
    return jsonEncode(map);
  }
}
