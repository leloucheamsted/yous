import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class DeleteAccountUseCase extends AsyncUseCase<void, void>
    with Debuggable, Loggable {
  DeleteAccountUseCase(UserAccountRepository productRepository)
      : _userAccountRepository = productRepository;

  final UserAccountRepository _userAccountRepository;

  @override
  String get debugName => 'DeleteAccountUseCase';

  @override
  FutureOrResult<void> execute(void params) async {
    try {
      final response = await _userAccountRepository.deleteAccount();
      return Ok(response);
    } on APIRequestException catch (ex) {
      logError("API Error while delete user account", error: Exception(ex));
      return Err(ex);
    } catch (e) {
      logError("API Error while delete user account", error: Exception(e));
      rethrow;
    }
  }
}
