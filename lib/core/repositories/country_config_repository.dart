import 'package:youscribe/core/entities/canalplus_config_entity.dart';
import 'package:youscribe/core/entities/country_configuration_entity.dart';

abstract class CountryConfigRepository {
  Future<CountryConfigurationEntity?> getCountryConfiguration();
  Future<CountryConfigurationEntity?> getOfflineCountryConfiguration();
  
  Future<CanalplusConfigEntity?> getCanalplusConfig();
  Future<CanalplusConfigEntity?> getOfflineCanalplusConfig();
}
