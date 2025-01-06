import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/product_model.dart';
part 'product_suggests_result.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ProductSuggestsResult {
  ProductSuggestsResult({
    required this.productId,
    required this.suggests,
  });
  factory ProductSuggestsResult.fromJson(Map<String, dynamic> json) =>
      _$ProductSuggestsResultFromJson(json);
  int? productId;
  List<ProductModel>? suggests;

  String toJson() {
    final map = _$ProductSuggestsResultToJson(this);
    return jsonEncode(map);
  }
}
