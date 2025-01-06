import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/product_model.dart';
part 'my_selection_product_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class MySelectionProductModel {
  MySelectionProductModel({
    this.product,
    this.dateAdded,
  });

  factory MySelectionProductModel.fromJson(Map<String, dynamic> json) =>
      _$MySelectionProductModelFromJson(json);
  DateTime? dateAdded;
  ProductModel? product;

  String toJson() {
    final map = _$MySelectionProductModelToJson(this);
    return jsonEncode(map);
  }
}
