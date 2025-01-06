import 'package:youscribe/core/entities/people_search_output_item_entity.dart';
import 'package:youscribe/core/entities/product_search_results_entity.dart';
import 'package:youscribe/core/models/responses/people_search_result_model.dart';

class PeopleSearchResultsEntity extends ProductSearchResultsEntity {
  PeopleSearchResultsEntity(PeopleSearchResultModel productSearchOutputModel)
      : super.fromModel(productSearchOutputModel, isHomeSuggestion: false) {
    people = productSearchOutputModel.people
            ?.map(PeopleSearchOutputItemEntity.fromModel)
            .toList() ??
        [];
  }

  List<PeopleSearchOutputItemEntity>? people;
}
