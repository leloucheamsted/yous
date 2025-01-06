import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/country_configuration_entity.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';

class SetUserCountryConfigUseCase
    extends AsyncUseCase<CountryConfigurationEntity, void> {
  SetUserCountryConfigUseCase(this.repository);
  final UserAccountRepository repository;

  @override
  FutureOrResult<void> execute(CountryConfigurationEntity? params) async {
    return Ok(await repository.setCountryConfig(params!));
  }
}
