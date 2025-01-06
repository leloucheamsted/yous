import 'package:isar/isar.dart';
import 'package:youscribe/core/entities/canalplus_config_entity.dart';
import 'package:youscribe/core/entities/country_configuration_entity.dart';
import 'package:youscribe/core/entities/product_category_entity.dart';
import 'package:youscribe/core/entities/user_global_settings_entity.dart';
import 'package:youscribe/data/data_sources/base_local_data_source.dart';
import 'package:youscribe/data/data_sources/user_acount_data_sources/user_settings_local_data_source.dart';
import 'package:youscribe/utilities/constants.dart';

class UserSettingsLocalDataSourceImpl
    extends BaseLocalDataSource<UserGlobalSettingsEntity>
    implements UserSettingsLocalDataSource {
  UserSettingsLocalDataSourceImpl(super.isar);

  @override
  Future<void> delete() {
    return isar.writeTxn(() {
      return currentCollection.clear();
    });
  }

  @override
  Future<void> incrementAppOpenedCount() {
    return isar.writeTxn(() async {
      final settings = await currentCollection
          .filter()
          .appOpenedCountGreaterThan(-1)
          .findFirst();

      if (settings != null) {
        settings.appOpenedCount++;
        await currentCollection.put(settings);
      } else {
        final newSettings =
            UserGlobalSettingsEntity(localId: 1, appOpenedCount: 1);
        await currentCollection.put(newSettings);
      }
    });
  }

  @override
  Future<UserGlobalSettingsEntity?> retrieve() {
    return currentCollection.filter().appOpenedCountGreaterThan(-1).findFirst();
  }

  @override
  Future<void> save(UserGlobalSettingsEntity data) {
    data
      ..localId = 1
      ..appOpenedCount = 1;
    return isar.writeTxn(() async {
      await currentCollection.clear();
      await currentCollection.put(data);
    });
  }

  @override
  Future<void> setCanalplusConfig(CanalplusConfigEntity canalplusConfig) {
    return isar.writeTxn(() async {
      final set = await currentCollection
          .filter()
          .appOpenedCountGreaterThan(-100)
          .findFirst();
      if (set != null) {
        set.canalplusSettings = canalplusConfig;
        await currentCollection.put(set);
      } else {
        final newSettings = UserGlobalSettingsEntity(
            localId: 1, canalplusSettings: canalplusConfig, appOpenedCount: 1);
        await currentCollection.put(newSettings);
      }
    });
  }

  @override
  Future<void> setClassificationTree(
      List<ProductCategoryEntity> classificationTree) {
    return isar.writeTxn(() async {
      final set = await currentCollection
          .filter()
          .appOpenedCountGreaterThan(-100)
          .findFirst();
      if (set != null) {
        set.classificationTree = classificationTree;
        await currentCollection.put(set);
      } else {
        final newSettings = UserGlobalSettingsEntity(
            localId: 1,
            classificationTree: classificationTree,
            appOpenedCount: 1);
        await currentCollection.put(newSettings);
      }
    });
  }

  @override
  Future<void> setCountryConfig(CountryConfigurationEntity countryConfig) {
    return isar.writeTxn(() async {
      final set = await currentCollection
          .filter()
          .appOpenedCountGreaterThan(-100)
          .findFirst();
      if (set != null) {
        set.countryConfiguration = countryConfig;
        await currentCollection.put(set);
      } else {
        final newSettings = UserGlobalSettingsEntity(
            localId: 1, countryConfiguration: countryConfig, appOpenedCount: 1);
        await currentCollection.put(newSettings);
      }
    });
  }

  @override
  Future<void> setDontDisplaySwipeProductsListHelp(bool val) {
    return isar.writeTxn(() async {
      final set = await currentCollection
          .filter()
          .appOpenedCountGreaterThan(-100)
          .findFirst();
      if (set != null) {
        set.dontDisplaySwipeProductsListHelp = val;
        await currentCollection.put(set);
      } else {
        final newSettings = UserGlobalSettingsEntity(
            localId: 1,
            dontDisplaySwipeProductsListHelp: val,
            appOpenedCount: 1);
        await currentCollection.put(newSettings);
      }
    });
  }

  @override
  Future<void> setIsCanalplusUser(bool val) {
    return isar.writeTxn(() async {
      final set = await currentCollection
          .filter()
          .appOpenedCountGreaterThan(-100)
          .findFirst();
      if (set != null) {
        set.isCanalplusUser = val;
        await currentCollection.put(set);
      } else {
        final newSettings = UserGlobalSettingsEntity(
            localId: 1, isCanalplusUser: val, appOpenedCount: 1);
        await currentCollection.put(newSettings);
      }
    });
  }

  @override
  Future<void> setLastInactiveSessionUserReadTriggerDate() {
    return isar.writeTxn(() async {
      final set = await currentCollection
          .filter()
          .appOpenedCountGreaterThan(-100)
          .findFirst();
      if (set != null) {
        set.lastInactiveSessionUserReadTriggerDate = DateTime.now();
        await currentCollection.put(set);
      } else {
        final newSettings = UserGlobalSettingsEntity(
            localId: 1,
            lastInactiveSessionUserReadTriggerDate: DateTime.now(),
            appOpenedCount: 1);
        await currentCollection.put(newSettings);
      }
    });
  }

  @override
  Future<void> setLastTimeConnectedToInternet(DateTime dateTime) {
    return isar.writeTxn(() async {
      final set = await currentCollection
          .filter()
          .appOpenedCountGreaterThan(-100)
          .findFirst();
      if (set != null) {
        set.lastTimeConnectedToInternet = DateTime.now();
        await currentCollection.put(set);
      } else {
        final newSettings = UserGlobalSettingsEntity(
            localId: 1,
            lastTimeConnectedToInternet: DateTime.now(),
            appOpenedCount: 1);
        await currentCollection.put(newSettings);
      }
    });
  }

  @override
  Future<void> setTheme(ThemeType theme) {
    return isar.writeTxn(() async {
      final set = await currentCollection
          .filter()
          .appOpenedCountGreaterThan(-100)
          .findFirst();

      if (set != null) {
        set.theme = theme;
        await currentCollection.put(set);
      } else {
        final newSettings = UserGlobalSettingsEntity(
            localId: 1, theme: theme, appOpenedCount: 1);
        await currentCollection.put(newSettings);
      }
    });
  }

  @override
  Future<void> setPreferredLanguageCode(String lang, String countryCode) {
    return isar.writeTxn(() async {
      final set = await currentCollection
          .filter()
          .appOpenedCountGreaterThan(-100)
          .findFirst();
      if (set != null) {
        set
          ..preferredLanguageCode = lang
          ..preferredCountryCode = countryCode;
        await currentCollection.put(set);
      } else {
        final newSettings = UserGlobalSettingsEntity(
            localId: 1,
            preferredLanguageCode: lang,
            preferredCountryCode: countryCode,
            appOpenedCount: 1);
        await currentCollection.put(newSettings);
      }
    });
  }
}
