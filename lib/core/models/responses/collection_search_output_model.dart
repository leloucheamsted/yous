import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/collection_search_output_item_model.dart';
import 'package:youscribe/core/models/responses/language_model.dart';
import 'package:youscribe/core/models/responses/product_facet_model.dart';
import 'package:youscribe/core/models/responses/product_search_item_output_model.dart';
import 'package:youscribe/core/models/responses/product_search_output_model.dart';

part 'collection_search_output_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class CollectionSearchOutputModel extends ProductSearchOutputModel {
  CollectionSearchOutputModel();
  factory CollectionSearchOutputModel.fromJson(Map<String, dynamic> json) =>
      _$CollectionSearchOutputModelFromJson(json);
  List<CollectionSearchOutputItemModel>? collections;

  @override
  String toJson() {
    final map = _$CollectionSearchOutputModelToJson(this);
    return jsonEncode(map);
  }
}
