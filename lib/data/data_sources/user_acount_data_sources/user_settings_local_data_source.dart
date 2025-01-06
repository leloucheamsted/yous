import 'package:youscribe/core/entities/canalplus_config_entity.dart';
import 'package:youscribe/core/entities/country_configuration_entity.dart';
import 'package:youscribe/core/entities/product_category_entity.dart';
import 'package:youscribe/core/entities/user_global_settings_entity.dart';
import 'package:youscribe/utilities/constants.dart';

abstract class UserSettingsLocalDataSource {
  Future<void> setCountryConfig(CountryConfigurationEntity countryConfig);
  Future<void> save(UserGlobalSettingsEntity data);
  Future<UserGlobalSettingsEntity?> retrieve();
  Future<void> setCanalplusConfig(CanalplusConfigEntity canalplusConfig);
  Future<void> setClassificationTree(
      List<ProductCategoryEntity> classificationTree);
  Future<void> delete();
  Future<void> setTheme(ThemeType theme);
  Future<void> setPreferredLanguageCode(String lang, String countryCode);
  Future<void> setLastTimeConnectedToInternet(DateTime dateTime);
  Future<void> incrementAppOpenedCount();
  Future<void> setIsCanalplusUser(bool val);
  Future<void> setDontDisplaySwipeProductsListHelp(bool val);
  Future<void> setLastInactiveSessionUserReadTriggerDate();
}
