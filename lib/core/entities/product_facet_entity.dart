// ignore_for_file: flutter_style_todos

import 'package:youscribe/core/models/responses/product_facet_model.dart';

class ProductFacetEntity extends BaseProductFacetEntity {
  ProductFacetEntity({
    super.id,
    super.name,
    super.label,
    this.parent,
    this.count,
    this.mobileIconUrl,
    this.children = const [],
  });
  factory ProductFacetEntity.fromModel(ProductFacetModel model) {
    final productEntity = ProductFacetEntity(
      id: model.id,
      name: model.name,
      label: model.label,
      count: model.count,
      mobileIconUrl: model.mobileIconUrl,
      parent: model.parent != null
          ? ProductFacetEntity.fromModel(model.parent!)
          : null,
    );

    //TODO: Check that the map function iterates through every
    //children and their children
    // ignore: cascade_invocations
    productEntity.children = model.children != null
        ? model.children!.map(ProductFacetEntity.fromModel).toList()
        : model.children2 != null
            ? model.children2!.map(ProductFacetEntity.fromModel).toList()
            : [];

    return productEntity;
  }

  int? count;
  String? mobileIconUrl;
  ProductFacetEntity? parent;
  List<ProductFacetEntity> children;

  ProductFacetModel toModel() => ProductFacetModel(
        id: id,
        name: name,
        label: label,
        count: count,
        mobileIconUrl: mobileIconUrl,
        parent: parent?.toModel(),
        children: children.map((e) => e.toModel()).toList(),
      );

  @override
  String toString() => label!;
}

class BaseProductFacetEntity {
  BaseProductFacetEntity({this.id, this.name, this.label});

  int? id;
  String? name;
  String? label;
}
