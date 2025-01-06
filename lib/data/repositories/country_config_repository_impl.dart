import 'package:youscribe/core/entities/canalplus_config_entity.dart';
import 'package:youscribe/core/entities/country_configuration_entity.dart';
import 'package:youscribe/core/repositories/country_config_repository.dart';
import 'package:youscribe/data/data_sources/country_config_data_sources/country_config_remote_data_source.dart';
import 'package:youscribe/data/data_sources/user_acount_data_sources/user_settings_local_data_source.dart';

class CountryConfigRepositoryImpl implements CountryConfigRepository {
  CountryConfigRepositoryImpl(
      this._countryConfigRemoteDataSource, this._userSettingsLocalDataSource);

  final CountryConfigRemoteDataSource _countryConfigRemoteDataSource;
  final UserSettingsLocalDataSource _userSettingsLocalDataSource;

  @override
  Future<CanalplusConfigEntity?> getCanalplusConfig() async {
    final canalConfig =
        await _countryConfigRemoteDataSource.getCanalplusConfig();
    await _userSettingsLocalDataSource.setCanalplusConfig(canalConfig);

    return canalConfig;
  }

  @override
  Future<CountryConfigurationEntity?> getCountryConfiguration() async {
    final result =
        await _countryConfigRemoteDataSource.getCountryConfiguration();
    if (result != null) {
      await _userSettingsLocalDataSource.setCountryConfig(result);
    }

    return result;
  }

  @override
  Future<CanalplusConfigEntity?> getOfflineCanalplusConfig() async {
    final sett = await _userSettingsLocalDataSource.retrieve();
    return sett?.canalplusSettings;
  }

  @override
  Future<CountryConfigurationEntity?> getOfflineCountryConfiguration() async {
    final sett = await _userSettingsLocalDataSource.retrieve();
    return sett?.countryConfiguration;
  }
}
