import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';

class UnFollowAuthorUseCase extends AsyncUseCase<int, bool> {
  UnFollowAuthorUseCase(UserAccountRepository productRepository)
      : _userAccountRepository = productRepository;

  final UserAccountRepository _userAccountRepository;

  @override
  FutureOrResult<bool> execute(int? params) async {
    final response = await _userAccountRepository.unFollowAuthor(params!);
    return Ok(response);
  }
}
