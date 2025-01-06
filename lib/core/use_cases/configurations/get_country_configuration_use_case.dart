// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';

import 'package:youscribe/core/entities/country_configuration_entity.dart';
import 'package:youscribe/core/repositories/country_config_repository.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';

class GetCountryConfigurationUseCase extends AsyncUseCase<
    GetCountryConfigurationUseCaseParams, CountryConfigurationEntity?> {
  GetCountryConfigurationUseCase(
      CountryConfigRepository countryConfigRepository)
      : _countryConfigRepository = countryConfigRepository;

  final CountryConfigRepository _countryConfigRepository;
  final UserAccountRepository _userAccountRepository =
      locator<UserAccountRepository>();

  @override
  FutureOrResult<CountryConfigurationEntity?> execute(
      GetCountryConfigurationUseCaseParams? params) async {
    try {
      if (params!.offlineFirst) {
        final settings = await _userAccountRepository.getUserSettings();
        return Ok(settings.countryConfiguration);
      }
      final result = await _countryConfigRepository.getCountryConfiguration();
      return Ok(result);
    } catch (e) {
      if (e is AppException) {
        return Err(e);
      }

      rethrow;
    }
  }
}

class GetCountryConfigurationUseCaseParams {
  GetCountryConfigurationUseCaseParams({
    this.offlineFirst = false,
  });
  final bool offlineFirst;
}
