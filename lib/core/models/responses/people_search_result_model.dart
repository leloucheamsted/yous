import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/language_model.dart';
import 'package:youscribe/core/models/responses/people_search_output_item_model.dart';
import 'package:youscribe/core/models/responses/product_facet_model.dart';
import 'package:youscribe/core/models/responses/product_search_item_output_model.dart';
import 'package:youscribe/core/models/responses/product_search_output_model.dart';
part 'people_search_result_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class PeopleSearchResultModel extends ProductSearchOutputModel {
  PeopleSearchResultModel() : super() {
    people = <PeopleSearchOutputItemModel>[];
  }
  factory PeopleSearchResultModel.fromJson(Map<String, dynamic> json) =>
      _$PeopleSearchResultModelFromJson(json);

  @JsonKey(name: 'Peoples')
  List<PeopleSearchOutputItemModel>? people;

  @override
  String toJson() {
    final map = _$PeopleSearchResultModelToJson(this);
    return jsonEncode(map);
  }
}
