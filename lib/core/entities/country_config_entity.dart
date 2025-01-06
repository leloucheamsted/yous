import 'package:youscribe/core/entities/country_configuration_entity.dart';
import 'package:youscribe/core/models/responses/country_config_model.dart';

class CountryConfigEntity {
  CountryConfigEntity({
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
  factory CountryConfigEntity.fromModel(CountryConfigModel model) =>
      CountryConfigEntity(
        defaultCobranding: model.defaultCobranding,
        facebookAllowed: model.facebookAllowed,
        registerAllowed: model.registerAllowed,
        inAppPurchaseAllowed: model.inAppPurchaseAllowed,
        countryCode: model.countryCode,
        garEnabled: model.garEnabled,
        garAuthRedirectUrl: model.garAuthRedirectUrl,
        garLogoutUrl: model.garLogoutUrl,
        registerPopup: model.registerPopup != null
            ? CountryConfigPopupEntity.fromModel(model.registerPopup!)
            : null,
      );

  String? defaultCobranding;
  bool? facebookAllowed;
  bool? registerAllowed;
  bool? inAppPurchaseAllowed;
  String? countryCode;
  bool? garEnabled;
  String? garAuthRedirectUrl;
  String? garLogoutUrl;
  CountryConfigPopupEntity? registerPopup;
}
