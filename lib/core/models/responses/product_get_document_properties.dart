import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'product_get_document_properties.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ProductGetDocumentProperties {
  ProductGetDocumentProperties(
    this.id,
    this.value,
    this.type,
  );
  factory ProductGetDocumentProperties.fromJson(Map<String, dynamic> json) =>
      _$ProductGetDocumentPropertiesFromJson(json);
  int? id;
  String? value;
  String? type;

  String toJson() {
    final map = _$ProductGetDocumentPropertiesToJson(this);
    return jsonEncode(map);
  }
}
