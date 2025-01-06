import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'image_push_content_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ImagePushContentModel {
  ImagePushContentModel({
    this.imageUrl,
    this.title,
    this.selectionPageName,
  });
  factory ImagePushContentModel.fromJson(Map<String, dynamic> json) =>
      _$ImagePushContentModelFromJson(json);
  String? imageUrl;
  String? title;
  String? selectionPageName;

  String toJson() {
    final map = _$ImagePushContentModelToJson(this);
    return jsonEncode(map);
  }
}
