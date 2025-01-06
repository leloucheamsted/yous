import 'package:isar/isar.dart';
import 'package:youscribe/core/entities/product_facet_entity.dart';
import 'package:youscribe/core/models/responses/category_type.dart';
import 'package:youscribe/core/models/responses/product_category_model.dart';
import 'package:youscribe/core/models/responses/product_facet_model.dart';

part 'product_category_entity.g.dart';

@embedded
class ProductCategoryEntity extends BaseProductFacetEntity {
  ProductCategoryEntity({
    super.name,
    super.label,
    this.isPublic,
    this.description,
    this.categoryType = CategoryType.none,
    int? id,
    this.isSelected,
  }) {
    this.id = id;
    children = [];
  }
  factory ProductCategoryEntity.fromFacetModel(ProductFacetModel model) =>
      ProductCategoryEntity(
        name: model.name,
        label: model.label,
        id: model.id,
      );

  factory ProductCategoryEntity.fromModel(ProductCategoryModel model) =>
      ProductCategoryEntity(
        name: model.name,
        label: model.label,
        isPublic: model.isPublic,
        description: model.description,
        id: model.id,
      );

  bool? isPublic;
  String? description;
  @enumerated
  CategoryType categoryType;
  int? _id;
  bool? isSelected;
  List<ProductCategoryEntity> children = [];
  ProductCategoryModel toModel() => ProductCategoryModel(
        name: name,
        label: label,
        isPublic: isPublic,
        description: description,
        id: id,
      );

  @override
  int? get id => _id;
  @override
  set id(int? value) {
    _id = value;
    categoryType = CategoryType.values.firstWhere(
        (element) => element.value == value,
        orElse: () => CategoryType.none);
  }

  @override
  String toString() => label ?? "";
}
