import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/product_offer_type.dart';
part 'product_offer_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ProductOfferModel {
  ProductOfferModel(this.type);
  factory ProductOfferModel.fromJson(Map<String, dynamic> json) =>
      _$ProductOfferModelFromJson(json);
  ProductOfferType? type;

  String toJson() {
    final map = _$ProductOfferModelToJson(this);
    return jsonEncode(map);
  }
}
