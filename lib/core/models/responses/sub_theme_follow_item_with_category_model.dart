import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/follow_item_model.dart';
part 'sub_theme_follow_item_with_category_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class SubThemeFollowItemWithCategoryModel extends FollowItemModel {
  SubThemeFollowItemWithCategoryModel(
      int super.id, String super.name, this.categoryId);

  factory SubThemeFollowItemWithCategoryModel.fromJson(
          Map<String, dynamic> json) =>
      _$SubThemeFollowItemWithCategoryModelFromJson(json);

  int? categoryId = 0;

  @override
  String toJson() {
    final map = _$SubThemeFollowItemWithCategoryModelToJson(this);
    return jsonEncode(map);
  }
}
