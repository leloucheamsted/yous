import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/collection_search_output_item_entity.dart';
import 'package:youscribe/core/entities/people_search_output_item_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/models/responses/multi_type_search_output_model.dart';

class MultiTypeSearchOutPutEntity {
  MultiTypeSearchOutPutEntity({
    required MutliTypeSearchOutPutModel model,
  })  : products = model.products.isNull
            ? []
            : model.products!
                .map((e) =>
                    ProductEntity()..fromProductSearchItemOutputModel(e, false))
                .toList(growable: false),
        collections = model.collections.isNull
            ? []
            : model.collections
                ?.map(CollectionSearchOutputItemEntity.fromModel)
                .toList(growable: false),
        authors = model.authors.isNull
            ? []
            : model.authors!
                .map(PeopleSearchOutputItemEntity.fromModel)
                .toList(growable: false);

  MultiTypeSearchOutPutEntity.defaults()
      : products = [],
        collections = [],
        authors = [];

  final List<ProductEntity> products;
  final List<CollectionSearchOutputItemEntity>? collections;
  final List<PeopleSearchOutputItemEntity> authors;
}

enum SearchResultGroupType {
  products._("Products"),
  collections._("Collections"),
  authors._("Authors");

  const SearchResultGroupType._(this.value);
  final String value;

  @override
  String toString() => value;
}
