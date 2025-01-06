import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/user_global_settings_entity.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';

class GetUserSettingsUseCase
    extends AsyncUseCase<void, UserGlobalSettingsEntity?> {
  GetUserSettingsUseCase(UserAccountRepository userAccountRepository)
      : _userAccountRepository = userAccountRepository;

  final UserAccountRepository _userAccountRepository;

  @override
  FutureOrResult<UserGlobalSettingsEntity?> execute(void params) async {
    return Ok(await _userAccountRepository.getUserSettings());
  }
}
