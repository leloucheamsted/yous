import 'package:isar/isar.dart';
import 'package:youscribe/core/entities/base/base_entity.dart';
import 'package:youscribe/core/entities/canalplus_config_entity.dart';
import 'package:youscribe/core/entities/country_configuration_entity.dart';
import 'package:youscribe/core/entities/product_category_entity.dart';
import 'package:youscribe/utilities/constants.dart';

part 'user_global_settings_entity.g.dart';

@Collection()
class UserGlobalSettingsEntity extends BaseEntity {
  UserGlobalSettingsEntity({
    required this.appOpenedCount,
    required super.localId,
    this.countryConfiguration,
    this.dontDisplaySwipeProductsListHelp,
    this.isCanalplusUser,
    this.canalplusSettings,
    this.hasSuccessfullySentCanalPlusUserInfo,
    this.classificationTree,
    this.lastTimeConnectedToInternet,
    this.lastInactiveSessionUserReadTriggerDate,
    this.preferredLanguageCode = '',
    this.preferredCountryCode = '',
    this.theme = ThemeType.system,
  });
  DateTime? lastTimeConnectedToInternet;
  CountryConfigurationEntity? countryConfiguration;
  bool? dontDisplaySwipeProductsListHelp = false;
  int appOpenedCount = 0;
  bool? isCanalplusUser = false;
  CanalplusConfigEntity? canalplusSettings;
  bool? hasSuccessfullySentCanalPlusUserInfo = false;
  List<ProductCategoryEntity>? classificationTree = [];
  DateTime? lastInactiveSessionUserReadTriggerDate;
  @enumerated
  ThemeType theme;
  String preferredLanguageCode;
  String preferredCountryCode;
}
