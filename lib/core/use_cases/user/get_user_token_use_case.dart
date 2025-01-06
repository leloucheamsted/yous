import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/account_premium_token_output_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class GetUserTokenUseCase
    extends AsyncUseCase<int, AccountPremiumTokenOutputEntity>
    with Debuggable, Loggable {
  GetUserTokenUseCase(UserAccountRepository productRepository)
      : _userAccountRepository = productRepository;

  final UserAccountRepository _userAccountRepository;

  @override
  String get debugName => 'GetUserTokenUseCase';

  @override
  FutureOrResult<AccountPremiumTokenOutputEntity> execute(int? params) async {
    try {
      logInfo("retreive user tokens");
      final response = await _userAccountRepository.getUsedTokens(params!);
      return Ok(response);
    } on APIRequestException catch (e) {
      logError("API Error while retrieve user tokens", error: Exception(e));
      return Err(e);
    } catch (e) {
      logError("Error while retrieve user tokens", error: Exception(e));
      rethrow;
    }
  }
}
