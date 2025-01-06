import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/collection_search_output_item_model.dart';
import 'package:youscribe/core/models/responses/people_search_output_item_model.dart';
import 'package:youscribe/core/models/responses/product_search_item_output_model.dart';

part 'multi_type_search_output_model.g.dart';

@JsonSerializable()
class MutliTypeSearchOutPutModel {
  MutliTypeSearchOutPutModel({
    required this.products,
    required this.authors,
    this.collections,
  });
  factory MutliTypeSearchOutPutModel.fromJson(Map<String, dynamic> json) =>
      _$MutliTypeSearchOutPutModelFromJson(json);
  @JsonKey(name: 'Products')
  final List<ProductSearchItemOutputModel>? products;
  @JsonKey(name: 'Collections')
  final List<CollectionSearchOutputItemModel>? collections;
  @JsonKey(name: 'Authors')
  final List<PeopleSearchOutputItemModel>? authors;

  Map<String, dynamic> toJson() {
    return _$MutliTypeSearchOutPutModelToJson(this);
  }
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
