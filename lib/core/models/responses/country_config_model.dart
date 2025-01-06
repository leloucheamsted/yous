import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/country_config_popup_model.dart';
part 'country_config_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class CountryConfigModel {
  CountryConfigModel({
    this.defaultCobranding,
    this.facebookAllowed,
    this.registerAllowed,
    this.inAppPurchaseAllowed,
    this.countryCode,
    this.garEnabled,
    this.garAuthRedirectUrl,
    this.garLogoutUrl,
    this.registerPopup,
  });
  factory CountryConfigModel.fromJson(Map<String, dynamic> json) =>
      _$CountryConfigModelFromJson(json);

  String? defaultCobranding;
  bool? facebookAllowed;
  bool? registerAllowed;
  bool? inAppPurchaseAllowed;
  String? countryCode;
  bool? garEnabled;
  String? garAuthRedirectUrl;
  String? garLogoutUrl;
  CountryConfigPopupModel? registerPopup;

  String toJson() {
    final map = _$CountryConfigModelToJson(this);
    return jsonEncode(map);
  }
}
