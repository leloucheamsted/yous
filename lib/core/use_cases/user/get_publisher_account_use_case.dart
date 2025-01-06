import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/light_account_entity.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';

class GetPublisherAccountUseCase extends AsyncUseCase<int, LightAccountEntity> {
  GetPublisherAccountUseCase(UserAccountRepository userAccountRepository)
      : _userAccountRepository = userAccountRepository;

  final UserAccountRepository _userAccountRepository;

  @override
  FutureOrResult<LightAccountEntity> execute(int? params) async {
    final ownerResult =
        await _userAccountRepository.getPublisherAccount(params);
    return Ok(ownerResult);
  }
}
