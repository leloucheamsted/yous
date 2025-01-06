import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/account_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class LoadUserAccounttUseCase extends AsyncUseCase<void, AccountGetEntity>
    with Debuggable, Loggable {
  LoadUserAccounttUseCase(UserAccountRepository productRepository)
      : _userAccountRepository = productRepository;

  final UserAccountRepository _userAccountRepository;

  @override
  String get debugName => 'LoadUserAccounttUseCase';

  @override
  FutureOrResult<AccountGetEntity> execute(void params) async {
    try {
      logInfo("load current user account");
      final response = await _userAccountRepository.loadUserAccount();
      return Ok(response);
    } on APIRequestException catch (e) {
      logError("APi error white   retrieve current user's account: $e",
          error: Exception(e));
      return Err(e);
    } catch (e) {
      logError("error white   retrieve current user's account",
          error: Exception(e));
      rethrow;
    }
  }
}
