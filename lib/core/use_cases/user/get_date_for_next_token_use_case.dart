import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class GetDateForNextTokenUseCase extends AsyncUseCase<int, DateTime?>
    with Debuggable, Loggable {
  GetDateForNextTokenUseCase(UserAccountRepository productRepository)
      : _userAccountRepository = productRepository;

  final UserAccountRepository _userAccountRepository;

  @override
  String get debugName => 'GetDateForNextTokenUseCase';

  @override
  FutureOrResult<DateTime?> execute(int? params) async {
    try {
      logInfo("Retreive date for next token");
      final response =
          await _userAccountRepository.getDateForNextToken(params!);
      return Ok(response);
    } on APIRequestException catch (e) {
      logError("API Error while retreive date for next token",
          error: Exception(e));
      return Err(e);
    } catch (e) {
      logError("Error while retreive date for next token", error: Exception(e));
      rethrow;
    }
  }
}
