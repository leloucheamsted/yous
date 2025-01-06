import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/product_model.dart';
part 'shelf_push_content_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ShelfPushContentModel {
  ShelfPushContentModel({
    this.id,
    this.selectionUrl,
    this.order,
    this.title,
    this.totalCount,
    this.products,
  });
  factory ShelfPushContentModel.fromJson(Map<String, dynamic> json) =>
      _$ShelfPushContentModelFromJson(json);
  String? id;
  String? selectionUrl;
  int? order;
  String? title;
  int? totalCount;
  List<ProductModel>? products;

  String toJson() {
    final map = _$ShelfPushContentModelToJson(this);
    return jsonEncode(map);
  }
}
