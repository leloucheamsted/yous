import 'package:youscribe/core/entities/canalplus_config_entity.dart';
import 'package:youscribe/core/entities/country_configuration_entity.dart';

abstract class CountryConfigRemoteDataSource {
  Future<CountryConfigurationEntity?> getCountryConfiguration();
  Future<CanalplusConfigEntity> getCanalplusConfig();
}
