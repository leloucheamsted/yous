import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/current_user_account_entity.dart';
import 'package:youscribe/core/repositories/authentication_repository.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class LoginWithFacebookUseCase extends AsyncUseCase<
    ({
      String accessToken,
      String countryCode,
      String? giftCode,
      bool createSubscription
    }),
    CurrentUserAccountEntity> with Debuggable, Loggable {
  LoginWithFacebookUseCase({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;
  final AuthenticationRepository _authenticationRepository;

  @override
  String get debugName => 'LoginWithFacebookUseCase';

  @override
  FutureOrResult<CurrentUserAccountEntity> execute(
      ({
        String accessToken,
        String countryCode,
        String? giftCode,
        bool createSubscription
      })? params) async {
    try {
      final userResponse =
          await _authenticationRepository.authenticateWithFacebook(params);

      if (userResponse.isErr) {
        return Err(userResponse.err!);
      }

      if (userResponse.ok.isNull) {
        return const Err(ClientException('Cannot retrieve the user'));
      }
      return Ok(userResponse.ok!);
    } catch (e) {
      if (e is AppException) {
        return Err(e);
      } else {
        return Err(ClientException(e.toString()));
      }
    }
  }
}
