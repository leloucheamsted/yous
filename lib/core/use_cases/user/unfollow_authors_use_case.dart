import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class UnFollowAuthorsUseCase extends AsyncUseCase<List<int>?, List<bool>>
    with Debuggable, Loggable {
  UnFollowAuthorsUseCase(UserAccountRepository productRepository)
      : _userAccountRepository = productRepository;

  final UserAccountRepository _userAccountRepository;

  @override
  String get debugName => 'UnFollowAuthorsUseCase';

  @override
  FutureOrResult<List<bool>> execute(List<int>? params) async {
    try {
      final response =
          await _userAccountRepository.unFollowAuthors(params ?? []);
      return Ok(response);
    } on APIRequestException catch (e) {
      logError("Error unfollowing authors : $e", error: Exception(e));
      return Err(e);
    } catch (e) {
      logError("Error unfollowing authors : $e", error: Exception(e));
      rethrow;
    }
  }
}
