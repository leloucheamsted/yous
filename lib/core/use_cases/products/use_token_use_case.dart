import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';

class UseTokenUseCase extends AsyncUseCase<UseTokenUseCaseParameters, bool> {
  UseTokenUseCase(UserAccountRepository userAccountRepository)
      : _userAccountRepository = userAccountRepository;

  final UserAccountRepository _userAccountRepository;

  @override
  FutureOrResult<bool> execute(UseTokenUseCaseParameters? params) async {
    final result =
        await _userAccountRepository.useToken(params!.userId, params.productId);
    return Ok(result);
  }
}

class UseTokenUseCaseParameters {
  UseTokenUseCaseParameters(this.userId, this.productId);
  int userId;
  int productId;
}
