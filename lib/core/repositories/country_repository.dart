import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:youscribe/core/entities/canalplus_config_entity.dart';
import 'package:youscribe/core/entities/country_configuration_entity.dart';

abstract class CountryRepository extends BaseRepository {
  Future<CountryConfigurationEntity?> getCountryConfiguration();
  Future<CanalplusConfigEntity> getCanalplusConfig();
}
