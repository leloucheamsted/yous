import 'package:youscribe/core/entities/canalplus_config_entity.dart';
import 'package:youscribe/core/entities/country_configuration_entity.dart';
import 'package:youscribe/core/repositories/country_repository.dart';
import 'package:youscribe/data/data_sources/country_config_data_sources/country_config_remote_data_source.dart';

class CountryRepositoryImpl implements CountryRepository {
  CountryRepositoryImpl({
    required CountryConfigRemoteDataSource countryRemoteDataSource,
  }) : _countryRemoteDataSource = countryRemoteDataSource;

  final CountryConfigRemoteDataSource _countryRemoteDataSource;

  @override
  Future<CanalplusConfigEntity> getCanalplusConfig() {
    return _countryRemoteDataSource.getCanalplusConfig();
  }

  @override
  Future<CountryConfigurationEntity?> getCountryConfiguration() {
    return _countryRemoteDataSource.getCountryConfiguration();
  }
}
