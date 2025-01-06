import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/ys_product_get_model.dart';
part 'library_product_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class LibraryProductModel {
  LibraryProductModel({
    this.isPublic,
    this.creationDate,
    this.product,
  });

  factory LibraryProductModel.fromJson(Map<String, dynamic> json) =>
      _$LibraryProductModelFromJson(json);
  bool? isPublic;
  DateTime? creationDate;
  YSProductGetModel? product;

  String toJson() {
    final map = _$LibraryProductModelToJson(this);
    return jsonEncode(map);
  }
}
