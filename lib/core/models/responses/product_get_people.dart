import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'product_get_people.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ProductGetPeople {
  ProductGetPeople(
    this.firstName,
    this.lastName,
    this.function,
    this.id,
  );
  factory ProductGetPeople.fromJson(Map<String, dynamic> json) =>
      _$ProductGetPeopleFromJson(json);
  String? firstName;
  String? lastName;
  String? function;
  int? id;

  String toJson() {
    final map = _$ProductGetPeopleToJson(this);
    return jsonEncode(map);
  }
}
