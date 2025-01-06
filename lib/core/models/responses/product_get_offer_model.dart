import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'product_get_offer_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ProductGetOfferModel {
  ProductGetOfferModel({
    this.id,
    this.offerTypeName,
    this.allowStreaming,
    this.allowDownload,
    this.price,
    this.currency,
    this.priceTaxIncluded,
    this.taxRate,
    this.maxDeviceUse,
    this.maxDayUse,
    this.maxTimeUse,
  });
  factory ProductGetOfferModel.fromJson(Map<String, dynamic> json) =>
      _$ProductGetOfferModelFromJson(json);
  int? id;
  String? offerTypeName;
  bool? allowStreaming;
  bool? allowDownload;
  double? price;
  String? currency;
  bool? priceTaxIncluded;
  double? taxRate;
  int? maxDeviceUse;
  int? maxDayUse;
  int? maxTimeUse;

  String toJson() {
    final map = _$ProductGetOfferModelToJson(this);
    return jsonEncode(map);
  }
}
