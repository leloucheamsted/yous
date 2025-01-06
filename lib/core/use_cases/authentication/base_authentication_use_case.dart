import 'package:youscribe/core/entities/current_user_account_entity.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

mixin BaseAuthenticationUseCase on Loggable {
  Future<void> updateCurrentUser(UserAccountRepository userAccountRepository,
      CurrentUserAccountEntity currentUserAccountEntity) async {
    try {
      final remoteAccount = await userAccountRepository.loadUserAccount();
      currentUserAccountEntity.premiumIsAllowed =
          remoteAccount.premiumIsAllowed;
      await userAccountRepository.saveUserAccount(currentUserAccountEntity);
    } catch (e) {
      logError(
        "Error loading remote user account:",
        error: e as Exception,
      );
      rethrow;
    }
  }
}
