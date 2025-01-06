import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/collection_search_output_item_model.dart';
import 'package:youscribe/core/models/responses/people_search_output_item_model.dart';
import 'package:youscribe/core/models/responses/product_search_item_output_model.dart';
part 'product_suggestions_result_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ProductSuggestionsResultModel {
  ProductSuggestionsResultModel(
      {required this.products, required this.collections, this.authors});
  factory ProductSuggestionsResultModel.fromJson(Map<String, dynamic> json) =>
      _$ProductSuggestionsResultModelFromJson(json);
  final List<ProductSearchItemOutputModel>? products;
  final List<CollectionSearchOutputItemModel>? collections;
  final List<PeopleSearchOutputItemModel>? authors;

  String toJson() {
    final map = _$ProductSuggestionsResultModelToJson(this);
    return jsonEncode(map);
  }
}
