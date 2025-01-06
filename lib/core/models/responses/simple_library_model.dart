import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/library_product_model.dart';
part 'simple_library_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class SimpleLibraryModel {
  SimpleLibraryModel({
    this.isPublic,
    this.id,
    this.name,
    this.label,
    this.typeName,
    this.accountId,
    this.productPublicCount,
    this.productPrivateCount,
    this.lastProduct,
  });

  factory SimpleLibraryModel.fromJson(Map<String, dynamic> json) =>
      _$SimpleLibraryModelFromJson(json);
  bool? isPublic;
  int? id;
  String? name;
  String? label;
  String? typeName;
  int? accountId;
  int? productPublicCount;
  int? productPrivateCount;
  LibraryProductModel? lastProduct;

  String toJson() {
    final map = _$SimpleLibraryModelToJson(this);
    return jsonEncode(map);
  }
}
