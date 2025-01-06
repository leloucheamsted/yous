import 'package:isar/isar.dart';
import 'package:youscribe/core/entities/base/base_entity.dart';
import 'package:youscribe/core/models/responses/collection_search_output_item_model.dart';
import 'package:youscribe/core/models/responses/collection_search_product_output_item_model.dart';

part 'collection_search_output_item_entity.g.dart';

@embedded
class CollectionSearchOutputItemEntity extends BaseEntity {
  CollectionSearchOutputItemEntity();
  factory CollectionSearchOutputItemEntity.fromModel(
    CollectionSearchOutputItemModel model,
  ) =>
      CollectionSearchOutputItemEntity()
        ..id = model.id
        ..title = model.title
        ..products = model.products
        ..productsOrder = model.productsOrder
        ..thumbnailUrlS = model.thumbnailUrlS
        ..thumbnailUrlM = model.thumbnailUrlM
        ..thumbnailUrlL = model.thumbnailUrlL
        ..thumbnailurlsWebp = model.thumbnailurlsWebp
        ..thumbnailurlmWebp = model.thumbnailurlmWebp
        ..thumbnailurllWebp = model.thumbnailurllWebp
        ..isAdultContent = model.isAdultContent
        ..isVisible = model.isVisible
        ..pertinenceWeight = model.pertinenceWeight;

  int? id;

  String? title;
  @ignore
  List<CollectionSearchProductOutputItemModel>? products;
  @ignore
  Map<int, int>? productsOrder;
  String? thumbnailUrlS;
  String? thumbnailUrlM;
  String? thumbnailUrlL;
  String? thumbnailurlsWebp;
  String? thumbnailurlmWebp;
  String? thumbnailurllWebp;
  bool? isAdultContent;
  bool? isVisible;
  double? pertinenceWeight;
}
