import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/canalplus_config_entity.dart';
import 'package:youscribe/core/entities/country_config_entity.dart';
import 'package:youscribe/core/entities/country_configuration_entity.dart';
import 'package:youscribe/core/models/responses/canalplus_config_model.dart';
import 'package:youscribe/core/models/responses/country_config_model.dart';
import 'package:youscribe/data/data_sources/base_remote_data_source.dart';
import 'package:youscribe/data/data_sources/country_config_data_sources/country_config_remote_data_source.dart';

class CountryConfigRemoteDataSourceImpl extends BaseRemoteDataSource
    implements CountryConfigRemoteDataSource {
  CountryConfigRemoteDataSourceImpl(
      {required super.dio, required super.appSettings});

  @override
  Future<CanalplusConfigEntity> getCanalplusConfig() async {
    final response =
        await get("${appSettings.mobileAPIUrl}/v1/country/canalplus");
    final canalplusConfigModel =
        CanalplusConfigModel.fromJson(response.data as Map<String, dynamic>);
    return CanalplusConfigEntity.fromModel(canalplusConfigModel);
  }

  @override
  Future<CountryConfigurationEntity?> getCountryConfiguration() async {
    final url = "${appSettings.mobileAPIUrl}/v1/country";

    final response = await get(url);
    final respModel =
        CountryConfigModel.fromJson(response.data as Map<String, dynamic>);
    final CountryConfigEntity config = CountryConfigEntity.fromModel(respModel);

    if (config.isNotNull) {
      final countryConfig = CountryConfigurationEntity()
        ..countryCode = config.countryCode
        ..defaultCobranding = config.defaultCobranding
        ..facebookAllowed = config.facebookAllowed
        ..registerAllowed = config.registerAllowed
        ..inAppPurchaseAllowed = config.inAppPurchaseAllowed
        ..registerPopup = config.registerPopup == null
            ? null
            : CountryConfigPopupEntity(
                bottomText: config.registerPopup!.bottomText,
                title: config.registerPopup!.title,
                topText: config.registerPopup!.topText,
                buttons: List<CountryConfigRegisterPopupButtonEntity>.from(
                    config.registerPopup!.buttons!.map((e) =>
                        CountryConfigRegisterPopupButtonEntity(
                            smsCode: e.smsCode,
                            smsPhoneNumber: e.smsPhoneNumber,
                            text: e.text))));
      return countryConfig;
    }
    return null;
  }
}
