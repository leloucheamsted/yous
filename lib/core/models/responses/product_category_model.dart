import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/base/base_classification_facet_model.dart';
part 'product_category_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ProductCategoryModel extends BaseClassificationFacetModel {
  ProductCategoryModel({
    super.name,
    super.label,
    this.isPublic,
    this.description,
    this.children,
    super.id,
  });
  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryModelFromJson(json);

  bool? isPublic;
  String? description;
  List<ProductCategoryModel>? children;

  Map<String, dynamic> toJson() {
    return _$ProductCategoryModelToJson(this);
  }
}
