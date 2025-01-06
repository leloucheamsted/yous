import 'package:youscribe/core/entities/collection_search_output_item_entity.dart';
import 'package:youscribe/core/entities/product_search_results_entity.dart';
import 'package:youscribe/core/models/responses/collection_search_output_model.dart';

class CollectionSearchResultsEntity extends ProductSearchResultsEntity {
  CollectionSearchResultsEntity(
    CollectionSearchOutputModel productSearchOutputModel,
    bool isHomeSuggestion,
  ) : super.fromModel(productSearchOutputModel,
            isHomeSuggestion: isHomeSuggestion) {
    collections = productSearchOutputModel.collections
            ?.map(CollectionSearchOutputItemEntity.fromModel)
            .toList() ??
        [];
  }
  List<CollectionSearchOutputItemEntity>? collections;
}
