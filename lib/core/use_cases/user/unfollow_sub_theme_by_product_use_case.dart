import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';

class UnFollowSubThemeByProductUseCase extends AsyncUseCase<int, bool> {
  UnFollowSubThemeByProductUseCase(UserAccountRepository productRepository)
      : _userAccountRepository = productRepository;

  final UserAccountRepository _userAccountRepository;

  @override
  FutureOrResult<bool> execute(int? params) async {
    try {
      final response =
          await _userAccountRepository.unFollowSubThemeByProduct(params!);
      return Ok(response);
    } on APIRequestException catch (e) {
      return Err(e);
    } catch (e) {
      rethrow;
    }
  }
}
