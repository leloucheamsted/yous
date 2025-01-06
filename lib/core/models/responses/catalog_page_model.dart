// -- catalog_page_model.dart --
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/language_model.dart';
import 'package:youscribe/core/models/responses/product_facet_model.dart';
import 'package:youscribe/core/models/responses/product_search_item_output_model.dart';
import 'package:youscribe/core/models/responses/product_search_output_model.dart';
part 'catalog_page_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class CatalogPageModel extends ProductSearchOutputModel {
  CatalogPageModel(
    this.description,
    this.title,
  );
  factory CatalogPageModel.fromJson(Map<String, dynamic> json) =>
      _$CatalogPageModelFromJson(json);
  @JsonKey(name: "Text")
  String? description;
  String? title;

  String toJSon() {
    final map = _$CatalogPageModelToJson(this);
    return jsonEncode(map);
  }
}
