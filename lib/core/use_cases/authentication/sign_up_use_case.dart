import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/current_user_account_entity.dart';
import 'package:youscribe/core/entities/sign_up_with_email_entity.dart';
import 'package:youscribe/core/repositories/authentication_repository.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe/core/use_cases/authentication/base_authentication_use_case.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class SignUpUseCase
    extends AsyncUseCase<SignUpWithEmailEntity, CurrentUserAccountEntity>
    with Debuggable, Loggable, BaseAuthenticationUseCase {
  SignUpUseCase({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;
  final UserAccountRepository _userAccountRepository =
      locator<UserAccountRepository>();

  @override
  String get debugName => 'SignUpUseCase';

  @override
  FutureOrResult<CurrentUserAccountEntity> execute(
      SignUpWithEmailEntity? params) async {
    try {
      final email = params!.email;
      final countryCode = params.countryCode;
      final giftCode = params.giftCode;
      final createSubscription = params.createSubscription;

      final userResponse = await _authenticationRepository.signUp(
        email,
        countryCode: countryCode,
        giftCode: giftCode,
        createSubscription: createSubscription,
      );

      if (userResponse.isErr) {
        return Err(userResponse.err!);
      }

      if (userResponse.ok.isNull) {
        return const Err(ClientException('Cannot create the user'));
      }

      await _userAccountRepository.saveUserAccount(userResponse.ok!);

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
