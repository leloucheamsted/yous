import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/requests/product_search_parameters.dart';
part 'multi_type_search_request_model.g.dart';

enum MultisearchType {
  products,
  audiobooks,
  bds,
  books,
  press,
  authors,
  collections
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class MultiTypeSearchRequestModel {
  MultiTypeSearchRequestModel({this.filters, this.requestedSearch});
  factory MultiTypeSearchRequestModel.fromJson(Map<String, dynamic> json) =>
      _$MultiTypeSearchRequestModelFromJson(json);

  ProductSearchParameters? filters;
  List<MultisearchType>? requestedSearch;

  Map<String, dynamic> toJson() {
    return _$MultiTypeSearchRequestModelToJson(this);
  }
}
