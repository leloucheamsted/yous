import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/base/base_model.dart';
import 'package:youscribe/core/models/responses/language_model.dart';
import 'package:youscribe/core/models/responses/product_facet_model.dart';
import 'package:youscribe/core/models/responses/product_search_item_output_model.dart';
part 'product_search_output_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ProductSearchOutputModel extends BaseModel {
  ProductSearchOutputModel({
    this.products,
    this.themes,
    this.categories,
    this.languages,
    this.classifications,
    this.totalResults,
  });
  factory ProductSearchOutputModel.fromJson(Map<String, dynamic> json) =>
      _$ProductSearchOutputModelFromJson(json);

  List<ProductSearchItemOutputModel>? products;
  List<ProductFacetModel>? themes;
  List<ProductFacetModel>? categories;
  List<LanguageModel>? languages;
  List<ProductFacetModel>? classifications;
  int? totalResults;
  String toJson() {
    final map = _$ProductSearchOutputModelToJson(this);
    return jsonEncode(map);
  }
}
