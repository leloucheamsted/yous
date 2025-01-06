// ignore_for_file: non_constant_identifier_names

import 'package:youscribe/core/entities/base/base_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/entities/product_facet_entity.dart';

class ProductSearchOutputEntity extends BaseEntity {
  ProductSearchOutputEntity(
      {required this.totalResults,
      required this.products,
      required this.themes,
      required this.categories,
      required this.languages,
      required this.classifications});
  int totalResults;
  List<ProductEntity> products;
  List<ProductFacetEntity> themes;
  List<ProductFacetEntity> categories;
  List<ProductFacetEntity> languages;
  List<ProductFacetEntity> classifications;
}

class CollectionSearchOutputEntity extends ProductSearchOutputEntity {
  CollectionSearchOutputEntity(
      {required this.collections,
      required super.totalResults,
      required super.products,
      required super.themes,
      required super.categories,
      required super.languages,
      required super.classifications});
  List<CollectionSearchOutputItemEntity> collections;
}

class CollectionSearchOutputItemEntity extends BaseEntity {
  CollectionSearchOutputItemEntity({
    required this.products,
    required this.title,
    required this.productsOrder,
    required this.thumbnailUrlS,
    required this.thumbnailUrlM,
    required this.thumbnailUrlL,
    required this.thumbnailUrlL_WebP,
    required this.thumbnailUrlM_WebP,
    required this.thumbnailUrlS_WebP,
    required this.isAdultContent,
    required this.isVisible,
    required this.pertinenceWeight,
  });
  late int id;

  String title;
  List<CollectionSearchProductOutputItemEntity> products;
  MapEntry<int, int> productsOrder;
  String thumbnailUrlS;
  String thumbnailUrlM;
  String thumbnailUrlL;
  String thumbnailUrlS_WebP;
  String thumbnailUrlM_WebP;
  String thumbnailUrlL_WebP;
  bool isAdultContent;
  bool isVisible;
  double pertinenceWeight;
}

class CollectionSearchProductOutputItemEntity {
  CollectionSearchProductOutputItemEntity({
    required this.productId,
    required this.productOrder,
  });
  int productId;
  int productOrder;
}
