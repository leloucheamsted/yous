import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/repositories/authentication_repository.dart';

class ForgotPasswordUseCase extends AsyncUseCase<String, bool> {
  ForgotPasswordUseCase({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  FutureOrResult<bool> execute(String? params) async {
    final result = await _authenticationRepository.forgotPassword(params!);
    return Ok(result);
  }
}
