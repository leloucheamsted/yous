import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class UnFollowThemesUseCase extends AsyncUseCase<List<(int, int)>?, List<bool>>
    with Debuggable, Loggable {
  UnFollowThemesUseCase(UserAccountRepository productRepository)
      : _userAccountRepository = productRepository;

  final UserAccountRepository _userAccountRepository;

  @override
  String get debugName => 'UnFollowThemesUseCase';

  @override
  FutureOrResult<List<bool>> execute(List<(int, int)>? params) async {
    try {
      final response = await _userAccountRepository.unFollowSubThemes(params!);
      return Ok(response);
    } on APIRequestException catch (e) {
      logError("Error unfollowing themes : $e", error: Exception(e));
      return Err(e);
    } catch (e) {
      logError("Error unfollowing themes : $e", error: Exception(e));
      rethrow;
    }
  }
}
