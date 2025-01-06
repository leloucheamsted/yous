import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';

class FollowSubThemeByProductUseCase extends AsyncUseCase<int, bool> {
  FollowSubThemeByProductUseCase(UserAccountRepository productRepository)
      : _userAccountRepository = productRepository;

  final UserAccountRepository _userAccountRepository;

  @override
  FutureOrResult<bool> execute(int? params) async {
    final response =
        await _userAccountRepository.followSubThemeByProduct(params!);
    return Ok(response);
  }
}
