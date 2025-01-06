import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/current_user_account_entity.dart';
import 'package:youscribe/core/repositories/authentication_repository.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class LoginWithAppleUseCase extends AsyncUseCase<
    ({
      String countryCode,
      String tokenId,
      String languageCode,
      String userName,
      String email,
      bool createSubscription,
      String subscriptionCode,
      String appleUserId,
    }),
    CurrentUserAccountEntity> with Debuggable, Loggable {
  LoginWithAppleUseCase({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;
  final AuthenticationRepository _authenticationRepository;

  @override
  String get debugName => 'LoginWithAppleUseCase';

  @override
  FutureOrResult<CurrentUserAccountEntity> execute(
      ({
        String countryCode,
        String tokenId,
        String languageCode,
        String userName,
        String email,
        bool createSubscription,
        String subscriptionCode,
        String appleUserId,
      })? params) async {
    try {
      final userResponse =
          await _authenticationRepository.authenticateWithApple(params);

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
