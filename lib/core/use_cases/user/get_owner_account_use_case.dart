import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/light_account_entity.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';

class GetOwnerAccountUseCase extends AsyncUseCase<int, LightAccountEntity> {
  GetOwnerAccountUseCase(UserAccountRepository userAccountRepository)
      : _userAccountRepository = userAccountRepository;

  final UserAccountRepository _userAccountRepository;

  @override
  FutureOrResult<LightAccountEntity> execute(int? params) async {
    final ownerResult = await _userAccountRepository.getOwnerAccount(params);
    return Ok(ownerResult);
  }
}
