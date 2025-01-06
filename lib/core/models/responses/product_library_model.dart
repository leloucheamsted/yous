import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'product_library_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ProductLibraryModel {
  ProductLibraryModel({this.productId, this.libraryId});

  factory ProductLibraryModel.fromJson(Map<String, dynamic> json) =>
      _$ProductLibraryModelFromJson(json);
  int? productId;
  int? libraryId;

  String toJson() {
    final map = _$ProductLibraryModelToJson(this);
    return jsonEncode(map);
  }
}
