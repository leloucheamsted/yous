import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';

class IsUserSubscribeUseCase extends AsyncUseCase<void, bool?> {
  IsUserSubscribeUseCase(UserAccountRepository userAccountRepository)
      : _userAccountRepository = userAccountRepository;

  final UserAccountRepository _userAccountRepository;
  final ConnectivityService _connectivityService =
      locator<ConnectivityService>();

  @override
  FutureOrResult<bool?> execute(void params) async {
    try {
      final usr = await _userAccountRepository.getCurrentUserAccountOffline();
      if (!await _connectivityService.isInternetAvailable) {
        final isSubscribe = await _userAccountRepository.isUserSubscribed();
        usr!.isSubscriber = isSubscribe;
        await _userAccountRepository.saveUserAccount(usr);
      }
      
        return Ok(usr?.isSubscriber);
    } catch (e) {
      if (e is AppException) {
        return Err(e);
      }

      rethrow;
    }
  }
}
