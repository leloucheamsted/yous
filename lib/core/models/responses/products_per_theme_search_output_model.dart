import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/product_facet_model.dart';
import 'package:youscribe/core/models/responses/product_search_item_output_model.dart';
import 'package:youscribe/core/models/responses/product_search_output_model.dart';

part 'products_per_theme_search_output_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ProductsPerThemeSearchOutputModel extends ProductSearchOutputModel {
  ProductsPerThemeSearchOutputModel(
    this.themeId,
    this.classificationId,
  );
  factory ProductsPerThemeSearchOutputModel.fromJson(
          Map<String, dynamic> json) =>
      _$ProductsPerThemeSearchOutputModelFromJson(json);
  int? themeId;
  int? classificationId;

  @override
  String toJson() {
    final map = _$ProductsPerThemeSearchOutputModelToJson(this);
    return jsonEncode(map);
  }
}
