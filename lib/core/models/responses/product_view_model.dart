import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'product_view_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ProductViewModel {
  ProductViewModel({
    this.accountId,
    this.productId,
    this.trackingId,
    this.actionDate,
  });
  factory ProductViewModel.fromJson(Map<String, dynamic> json) =>
      _$ProductViewModelFromJson(json);
  int? accountId;
  int? productId;
  String? trackingId;
  DateTime? actionDate;

  String toJson() {
    final map = _$ProductViewModelToJson(this);
    return jsonEncode(map);
  }
}
