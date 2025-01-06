import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'collection_search_product_output_item_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class CollectionSearchProductOutputItemModel {
  CollectionSearchProductOutputItemModel({this.productId, this.productOrder});
  factory CollectionSearchProductOutputItemModel.fromJson(
          Map<String, dynamic> json) =>
      _$CollectionSearchProductOutputItemModelFromJson(json);
  int? productId;
  int? productOrder;

  String toJson() {
    final map = _$CollectionSearchProductOutputItemModelToJson(this);
    return jsonEncode(map);
  }
}
