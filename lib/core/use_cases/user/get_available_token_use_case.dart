import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/account_premium_token_output_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class GetAvailableTokensUseCase
    extends AsyncUseCase<int, AccountPremiumTokenOutputEntity>
    with Debuggable, Loggable {
  GetAvailableTokensUseCase(UserAccountRepository productRepository)
      : _userAccountRepository = productRepository;

  final UserAccountRepository _userAccountRepository;

  @override
  String get debugName => 'GetAvailableTokensUseCase';

  @override
  FutureOrResult<AccountPremiumTokenOutputEntity> execute(int? params) async {
    try {
      logInfo("Retreive available user's tokens");
      final response = await _userAccountRepository.getAvailableTokens(params!);
      return Ok(response);
    } on APIRequestException catch (e) {
      logError("API Error while retreive user's available tokens",
          error: Exception(e));
      return Err(e);
    } catch (e) {
      logError("Error while retreive user's available tokens",
          error: Exception(e));
      rethrow;
    }
  }
}
