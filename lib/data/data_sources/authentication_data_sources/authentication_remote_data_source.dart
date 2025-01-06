import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:youscribe/core/entities/current_user_account_entity.dart';
import 'package:youscribe/core/models/responses/mobile_account_model.dart';

abstract class AuthenticationRemoteDataSource extends BaseDataSource {
  Future<MobileAccountModel?> login(String userName, String password);
  Future<bool> forgotPassword(String email);
  Future<MobileAccountModel?> signUp(
    String email, {
    required String countryCode,
    String? giftCode,
    bool createSubscription = true,
  });
  Future<MobileAccountModel?> authenticateWithFacebook(
      {required String accessToken,
      required String countryCode,
      String? giftCode,
      bool createSubscription = true});
  Future<CurrentUserAccountEntity?> authenticateWithApple(
      {required String appleUserId,
      required String countryCode,
      required bool createSubscription,
      required String email,
      required String languageCode,
      required String subscriptionCode,
      required String tokenId,
      required String userName});
}
