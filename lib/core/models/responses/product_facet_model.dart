import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/base/base_classification_facet_model.dart';
part 'product_facet_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ProductFacetModel extends BaseClassificationFacetModel {
  ProductFacetModel({
    super.id,
    super.name,
    super.label,
    this.parent,
    this.count,
    this.mobileIconUrl,
    this.children = const [],
  });
  factory ProductFacetModel.fromJson(Map<String, dynamic> json) =>
      _$ProductFacetModelFromJson(json);
  int? count;
  String? mobileIconUrl;
  ProductFacetModel? parent;
  @JsonKey(name: "Children")
  List<ProductFacetModel>? children;
  @JsonKey(name: "Childs")
  List<ProductFacetModel>? children2;

  @override
  String toString() => label!;

  String toJson() {
    final map = _$ProductFacetModelToJson(this);
    return jsonEncode(map);
  }
}
