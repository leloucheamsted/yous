import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/product_get_document_format.dart';
import 'package:youscribe/core/models/responses/product_get_document_properties.dart';
part 'product_get_document.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ProductGetDocument {
  ProductGetDocument(
    this.id,
    this.properties,
    this.documentProtectionTypeName,
    this.formats,
    this.nbPages,
    this.pageWidthPoints,
    this.pageHeightPoints,
  );
  factory ProductGetDocument.fromJson(Map<String, dynamic> json) =>
      _$ProductGetDocumentFromJson(json);
  int? id;
  String? documentProtectionTypeName;
  int? nbPages;
  int? pageWidthPoints;
  int? pageHeightPoints;
  List<ProductGetDocumentProperties>? properties;
  List<ProductGetDocumentFormat>? formats;

  String toJson() {
    final map = _$ProductGetDocumentToJson(this);
    return jsonEncode(map);
  }
}
