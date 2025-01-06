import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/base/base_model.dart';
import 'package:youscribe/core/models/responses/collection_search_product_output_item_model.dart';
part 'collection_search_output_item_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class CollectionSearchOutputItemModel extends BaseModel {
  CollectionSearchOutputItemModel({
    this.id,
    this.title,
    this.products,
    this.productsOrder,
    this.thumbnailUrlS,
    this.thumbnailUrlM,
    this.thumbnailUrlL,
    this.thumbnailurlsWebp,
    this.thumbnailurlmWebp,
    this.thumbnailurllWebp,
    this.isAdultContent,
    this.isVisible,
    this.pertinenceWeight,
  });

  factory CollectionSearchOutputItemModel.fromJson(Map<String, dynamic> json) =>
      _$CollectionSearchOutputItemModelFromJson(json);

  int? id;
  String? title;
  List<CollectionSearchProductOutputItemModel>? products;
  Map<int, int>? productsOrder;
  String? thumbnailUrlS;
  String? thumbnailUrlM;
  String? thumbnailUrlL;
  @JsonKey(name: 'ThumbnailurlS_webp')
  String? thumbnailurlsWebp;
  @JsonKey(name: 'ThumbnailurlM_webp')
  String? thumbnailurlmWebp;
  @JsonKey(name: 'ThumbnailurlL_webp')
  String? thumbnailurllWebp;
  bool? isAdultContent;
  bool? isVisible;
  double? pertinenceWeight;

  Map<String, dynamic> toJson() {
    return _$CollectionSearchOutputItemModelToJson(this);
  }
}
