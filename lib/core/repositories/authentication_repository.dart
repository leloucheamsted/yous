import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:youscribe/core/entities/current_user_account_entity.dart';

abstract class AuthenticationRepository extends BaseRepository {
  FutureOrResult<CurrentUserAccountEntity?> login(
      [({String userName, String password})? credentials]);

  FutureOrResult<void> logOut();
  Future<bool> forgotPassword(String email);

  FutureOrResult<CurrentUserAccountEntity?> signUp(
    String email, {
    required String countryCode,
    String? giftCode,
    bool createSubscription = true,
  });
  FutureOrResult<CurrentUserAccountEntity?> authenticateWithFacebook(
      [({
        String accessToken,
        String countryCode,
        String? giftCode,
        bool createSubscription
      })? credentials]);

  FutureOrResult<CurrentUserAccountEntity?> authenticateWithApple(
      [({
        String countryCode,
        String tokenId,
        String languageCode,
        String userName,
        String email,
        bool createSubscription,
        String subscriptionCode,
        String appleUserId,
      })? credentials]);
}
