import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/base/base_model.dart';
import 'package:youscribe/core/models/responses/thumbnail_output_model.dart';
part 'people_search_output_item_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class PeopleSearchOutputItemModel extends BaseModel {
  PeopleSearchOutputItemModel({
    this.id,
    this.name,
    this.pertinenceWeight,
    this.thumbnails,
  });

  factory PeopleSearchOutputItemModel.fromJson(Map<String, dynamic> json) =>
      _$PeopleSearchOutputItemModelFromJson(json);
  int? id;
  String? name;
  double? pertinenceWeight;
  List<ThumbnailOutputModel>? thumbnails;

  String toJson() {
    final map = _$PeopleSearchOutputItemModelToJson(this);
    return jsonEncode(map);
  }
}
