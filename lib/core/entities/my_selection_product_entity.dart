// File Name: library_models.dart

import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/models/responses/my_selection_product_model.dart';

class MySelectionProductEntity {
  MySelectionProductEntity(
    MySelectionProductModel mySelectionProduct,
  ) {
    dateAdded = mySelectionProduct.dateAdded;
    if (mySelectionProduct.product != null) {
      product = ProductEntity(id: mySelectionProduct.product!.id)
        ..fromProductModel(mySelectionProduct.product!);
    }
  }
  DateTime? dateAdded;
  ProductEntity? product;
}
