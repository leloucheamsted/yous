import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:youscribe/core/repositories/authentication_repository.dart';

class LogoutUseCase extends AsyncUseCase<NoParam?, void> {
  LogoutUseCase({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  FutureOrResult<void> execute(NoParam? params) =>
      _authenticationRepository.logOut();
}
