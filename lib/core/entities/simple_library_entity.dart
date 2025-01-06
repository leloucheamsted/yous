// File Name: library_models.dart

import 'package:isar/isar.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/models/responses/library_product_model.dart';
import 'package:youscribe/core/models/responses/product_model.dart';
import 'package:youscribe/core/models/responses/simple_library_model.dart';

part 'simple_library_entity.g.dart';

@embedded
class SimpleLibraryEntity {
  SimpleLibraryEntity() {
    lastProduct = LibraryProductEntity();
  }

  SimpleLibraryEntity.fromSimpleLibraryModel(
    SimpleLibraryModel simpleLibraryModel,
  ) {
    if (simpleLibraryModel.lastProduct != null) {
      lastProduct = LibraryProductEntity.fromLibraryProductModel(
        simpleLibraryModel.lastProduct!,
      );
    }
    hasProducts = lastProduct != null &&
        (simpleLibraryModel.productPrivateCount! > 0 ||
            simpleLibraryModel.productPublicCount! > 0);
    id = simpleLibraryModel.id;
    name = simpleLibraryModel.name;
    label = simpleLibraryModel.label;
    typeName = simpleLibraryModel.typeName;
    accountId = simpleLibraryModel.accountId;
    productPublicCount = simpleLibraryModel.productPublicCount;
    productPrivateCount = simpleLibraryModel.productPrivateCount;
  }
  int? id;
  String? name;
  String? label;
  String? typeName;
  int? accountId;
  int? productPublicCount;
  int? productPrivateCount;

  @ignore
  bool get isPublic => typeName == SelectionType.personal.value ? false : true;

  int get totalCount => productPrivateCount! + productPublicCount!;

  LibraryProductEntity? lastProduct;
  bool? hasProducts;
}

@embedded
class LibraryProductEntity {
  LibraryProductEntity() {
    product = ProductEntity();
  }

  LibraryProductEntity.fromLibraryProductModel(
    LibraryProductModel libraryProductModel,
  ) {
    if (libraryProductModel.product != null) {
      if (libraryProductModel.product!.thumbnailUrls != null &&
          libraryProductModel.product!.thumbnailUrls!.isNotEmpty) {
        imageUrl = libraryProductModel.product!.thumbnailUrls![0].url;
      }
      product = ProductEntity()
        ..fromProductModel(ProductModel.from(libraryProductModel.product!));
    }
    isPublic = libraryProductModel.isPublic;
    creationDate = libraryProductModel.creationDate;
  }
  String? imageUrl;
  bool? isPublic;
  DateTime? creationDate;
  @ignore
  ProductEntity? product;
}

enum SelectionType {
  personal._("Personal"),
  public._("Public");

  const SelectionType._(this.value);
  final String value;

  @override
  String toString() => value;
}
