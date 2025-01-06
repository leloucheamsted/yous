import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/product_model.dart';
part 'last_views_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class LastViewsModel {
  LastViewsModel({
    this.viewDate,
    this.product,
  });
  factory LastViewsModel.fromJson(Map<String, dynamic> json) =>
      _$LastViewsModelFromJson(json);
  DateTime? viewDate;
  ProductModel? product;

  String toJson() {
    final map = _$LastViewsModelToJson(this);
    return jsonEncode(map);
  }
}
