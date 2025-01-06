import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/ys_product_get_model.dart';
part 'product_commentary_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ProductCommentaryModel {
  ProductCommentaryModel({
    required this.comments,
    this.source = '',
    this.opinionSource = OpinionSource.ysTeam,
  });
  factory ProductCommentaryModel.fromJson(Map<String, dynamic> json) =>
      _$ProductCommentaryModelFromJson(json);
  String comments;
  String source;
  OpinionSource opinionSource;

  String toJson() {
    final map = _$ProductCommentaryModelToJson(this);
    return jsonEncode(map);
  }
}
