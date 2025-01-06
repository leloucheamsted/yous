// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_theme_follow_item_with_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubThemeFollowItemWithCategoryModel
    _$SubThemeFollowItemWithCategoryModelFromJson(Map<String, dynamic> json) =>
        SubThemeFollowItemWithCategoryModel(
          json['Id'] as int,
          json['Name'] as String,
          json['CategoryId'] as int?,
        );

Map<String, dynamic> _$SubThemeFollowItemWithCategoryModelToJson(
        SubThemeFollowItemWithCategoryModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'CategoryId': instance.categoryId,
    };
