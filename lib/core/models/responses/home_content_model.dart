import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/editorial_model.dart';
import 'package:youscribe/core/models/responses/image_push_content_model.dart';
import 'package:youscribe/core/models/responses/shelf_push_content_model.dart';
part 'home_content_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class HomeContentModel {
  HomeContentModel({
    this.imagePushs,
    this.shelfPushs,
    this.editorials,
  });
  factory HomeContentModel.fromJson(Map<String, dynamic> json) =>
      _$HomeContentModelFromJson(json);
  List<ImagePushContentModel>? imagePushs;
  List<ShelfPushContentModel>? shelfPushs;
  List<EditorialModel>? editorials;

  String toJson() {
    final map = _$HomeContentModelToJson(this);
    return jsonEncode(map);
  }
}
