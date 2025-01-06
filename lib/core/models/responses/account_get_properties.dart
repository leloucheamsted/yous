import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'account_get_properties.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class AccountGetProperties {
  AccountGetProperties(
    this.id,
    this.value,
    this.type,
  );
  factory AccountGetProperties.fromJson(Map<String, dynamic> json) =>
      _$AccountGetPropertiesFromJson(json);
  int? id;
  String? value;
  String? type;

  String toJSon() {
    final map = _$AccountGetPropertiesToJson(this);
    return jsonEncode(map);
  }
}
