import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'country_config_register_popup_button_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class CountryConfigRegisterPopupButtonModel {
  CountryConfigRegisterPopupButtonModel({
    this.text,
    this.smsPhoneNumber,
    this.smsCode,
  });
  factory CountryConfigRegisterPopupButtonModel.fromJson(
          Map<String, dynamic> json) =>
      _$CountryConfigRegisterPopupButtonModelFromJson(json);

  String? text;
  String? smsPhoneNumber;
  String? smsCode;

  String toJson() {
    final map = _$CountryConfigRegisterPopupButtonModelToJson(this);
    return jsonEncode(map);
  }
}
