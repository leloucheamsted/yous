import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/current_user_account_entity.dart';
import 'package:youscribe/core/repositories/authentication_repository.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe/core/use_cases/authentication/base_authentication_use_case.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class LoginUseCase extends AsyncUseCase<({String userName, String password}),
        CurrentUserAccountEntity>
    with Debuggable, Loggable, BaseAuthenticationUseCase {
  LoginUseCase({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;
  final UserAccountRepository _userAccountRepository =
      locator<UserAccountRepository>();

  @override
  String get debugName => 'LoginUseCase';

  @override
  FutureOrResult<CurrentUserAccountEntity> execute(
      ({String password, String userName})? params) async {
    try {
      final userResponse = await _authenticationRepository.login(params);

      if (userResponse.isErr) {
        return Err(userResponse.err!);
      }

      if (userResponse.ok.isNull) {
        return const Err(ClientException('Cannot retrieve the user'));
      }

      await updateCurrentUser(_userAccountRepository, userResponse.ok!);
      return Ok(userResponse.ok!);
    } catch (e) {
      if (e is AppException) {
        return Err(e);
      } else {
        return const Err(ClientException('Unknown error'));
      }
    }
  }
}
