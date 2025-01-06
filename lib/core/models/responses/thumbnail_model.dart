import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'thumbnail_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ThumbnailModel {
  ThumbnailModel({
    this.height,
    this.url,
    this.width,
  });
  factory ThumbnailModel.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailModelFromJson(json);
  int? height;
  String? url;
  int? width;

  String toJson() {
    final map = _$ThumbnailModelToJson(this);
    return jsonEncode(map);
  }
}
