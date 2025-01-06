import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/edito_v3_model.dart';
import 'package:youscribe/core/models/responses/image_push_content_model.dart';
import 'package:youscribe/core/models/responses/shelf_push_content_model.dart';
part 'home_v3_content_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class HomeV3ContentModel {
  HomeV3ContentModel({
    this.imagePushs,
    this.shelfPushs,
    this.editorialItems,
  });
  factory HomeV3ContentModel.fromJson(Map<String, dynamic> json) =>
      _$HomeV3ContentModelFromJson(json);
  List<ImagePushContentModel>? imagePushs;
  List<ShelfPushContentModel>? shelfPushs;
  List<EditoV3Model>? editorialItems;

  String toJson() {
    final map = _$HomeV3ContentModelToJson(this);
    return jsonEncode(map);
  }
}
