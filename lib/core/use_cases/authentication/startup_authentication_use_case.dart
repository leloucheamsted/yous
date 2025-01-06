import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/current_user_account_entity.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe/core/use_cases/authentication/base_authentication_use_case.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class StartupAuthenticationUseCase
    extends AsyncUseCase<void, CurrentUserAccountEntity?>
    with Debuggable, Loggable, BaseAuthenticationUseCase {
  StartupAuthenticationUseCase(this._userAccountRepository);

  final UserAccountRepository _userAccountRepository;
  final ConnectivityService _connectivityService =
      locator<ConnectivityService>();

  @override
  String get debugName => 'StartupAuthenticationUseCase';

  @override
  FutureOrResult<CurrentUserAccountEntity?> execute(void params) async {
    try {
      final currentUserAccountEntity =
          await _userAccountRepository.getCurrentUserAccountOffline();

      if (currentUserAccountEntity != null) {
        if (currentUserAccountEntity.token.isNullOrEmpty) {
          return const Ok(null);
        }

        if (await _connectivityService.isInternetAvailable) {
          final isTokenValid =
              await _userAccountRepository.isCurrentUserTokenValid();
          if (!isTokenValid) {
            return const Ok(null);
          }
        } else {
          return Ok(currentUserAccountEntity);
        }

        await updateCurrentUser(
            _userAccountRepository, currentUserAccountEntity);
      }

      return Ok(currentUserAccountEntity);
    } catch (e) {
      if (e is AppException) {
        return Err(e);
      } else {
        return Err(ClientException(e.toString()));
      }
    }
  }
}
