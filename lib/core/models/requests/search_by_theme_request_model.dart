import 'dart:core';
import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/requests/product_search_parameters.dart';
part 'search_by_theme_request_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ProductSearchByThemeInputModel extends ProductSearchParameters {
  ProductSearchByThemeInputModel({
    List<int>? parentsClassificationId,
    List<int>? childrenClassificationId,
    List<int>? themeIds,
  })  : parentsClassificationId = parentsClassificationId ?? [],
        childrenClassificationId = childrenClassificationId ?? [],
        themeIds = themeIds ?? [];
  factory ProductSearchByThemeInputModel.fromJson(Map<String, dynamic> json) =>
      _$ProductSearchByThemeInputModelFromJson(json);

  @JsonKey(name: 'parents_classification_id')
  List<int>? parentsClassificationId;

  @JsonKey(name: 'children_classification_id')
  List<int>? childrenClassificationId;

  @JsonKey(name: 'theme_Ids')
  List<int>? themeIds;

  @override
  Map<String, dynamic> toJson() {
    return _$ProductSearchByThemeInputModelToJson(this);
  }
}
