// File Name: product_list_model.dart

import 'package:isar/isar.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/models/responses/shelf_push_content_model.dart';

part 'selection_model.g.dart';

class ProductListEntity {
  ProductListEntity({
    this.products = const [],
    this.id,
    this.intId,
    this.title,
  });
  @ignore
  List<ProductEntity> products = [];
  String? id;
  int? intId;
  String? title;
}

@embedded
class SelectionEntity extends ProductListEntity {
  SelectionEntity({
    super.products,
    this.selectionUrl,
    this.totalCount,
    this.order,
    super.id,
    super.title,
  });

  SelectionEntity.fromShelfPushContent(ShelfPushContentModel c)
      : super(
          products: c.products == null
              ? <ProductEntity>[]
              : c.products!.map((p) {
                  final product = ProductEntity(id: p.id)..fromProductModel(p);
                  return product;
                }).toList(),
          id: c.id,
          title: c.title,
        ) {
    totalCount = c.totalCount;
    order = c.order;
    selectionUrl = c.selectionUrl;
  }
  String? selectionUrl;
  int? totalCount;
  int? order;
}
