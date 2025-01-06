import 'package:youscribe/core/models/responses/follow_item_model.dart';
import 'package:youscribe/core/models/responses/sub_theme_follow_item_with_category_model.dart';

class FollowItemEntity {
  FollowItemEntity(this.id, this.name);
  factory FollowItemEntity.fromModel(FollowItemModel model) =>
      FollowItemEntity(model.id, model.name);
  final int? id;
  String? name;
}

class SubThemeFollowItemWithCategoryEntity extends FollowItemEntity {
  SubThemeFollowItemWithCategoryEntity(super.id, super.name, this.categoryId);
  factory SubThemeFollowItemWithCategoryEntity.fromModel(
          SubThemeFollowItemWithCategoryModel model) =>
      SubThemeFollowItemWithCategoryEntity(
          model.id, model.name, model.categoryId);
  final int? categoryId;
}
