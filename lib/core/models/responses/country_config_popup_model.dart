import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/country_config_register_popup_button_model.dart';
part 'country_config_popup_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class CountryConfigPopupModel {
  CountryConfigPopupModel({
    this.title,
    this.topText,
    this.bottomText,
    this.buttons,
  });
  factory CountryConfigPopupModel.fromJson(Map<String, dynamic> json) =>
      _$CountryConfigPopupModelFromJson(json);
  String? title;
  List<String>? topText;
  List<String>? bottomText;
  List<CountryConfigRegisterPopupButtonModel>? buttons;

  String toJson() {
    final map = _$CountryConfigPopupModelToJson(this);
    return jsonEncode(map);
  }
}
