import 'package:youscribe/core/entities/collection_search_output_item_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';

class ProductSuggestionsResultEntity {
  ProductSuggestionsResultEntity(
      {required this.products, required this.collections});
  List<ProductEntity> products;
  List<CollectionSearchOutputItemEntity> collections;
}
