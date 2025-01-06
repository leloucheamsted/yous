import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/product_model.dart';
part 'offline_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class OfflineModel {
  OfflineModel({
    required this.offlinedDate,
    required this.product,
  });
  factory OfflineModel.fromJson(Map<String, dynamic> json) =>
      _$OfflineModelFromJson(json);
  DateTime? offlinedDate;
  ProductModel? product;

  String toJson() {
    final map = _$OfflineModelToJson(this);
    return jsonEncode(map);
  }
}
