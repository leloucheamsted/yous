import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'product_get_document_format.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ProductGetDocumentFormat {
  ProductGetDocumentFormat({
    this.id,
    this.mimeType,
    this.extension,
    this.formatTypeId,
    this.eAN13,
    this.size,
  });
  factory ProductGetDocumentFormat.fromJson(Map<String, dynamic> json) =>
      _$ProductGetDocumentFormatFromJson(json);
  int? id;
  String? mimeType;
  String? extension;
  int? formatTypeId;
  String? eAN13;
  int? size;

  String toJson() {
    final map = _$ProductGetDocumentFormatToJson(this);
    return jsonEncode(map);
  }
}
