import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/product_model.dart';
part 'favorite_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class FavoriteModel {
  FavoriteModel({this.favoritedDate, this.product});
  factory FavoriteModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteModelFromJson(json);
  DateTime? favoritedDate;
  ProductModel? product;

  String toJson() {
    final map = _$FavoriteModelToJson(this);
    return jsonEncode(map);
  }
}
