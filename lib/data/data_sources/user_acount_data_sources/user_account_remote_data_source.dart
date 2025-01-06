import 'package:youscribe/core/entities/account_entity.dart';
import 'package:youscribe/core/entities/account_premium_token_output_entity.dart';
import 'package:youscribe/core/entities/current_user_account_entity.dart';
import 'package:youscribe/core/entities/follow_item_entity.dart';
import 'package:youscribe/core/entities/in_app_purchase_pay_entity.dart';
import 'package:youscribe/core/entities/light_account_entity.dart';
import 'package:youscribe/core/entities/product_follow_output_entity.dart';
import 'package:youscribe/core/models/responses/user_classification_settings_response.dart';

abstract class UserAccountRemoteDataSource {
  Future<UserClassificationSettingsResponse>
      getClassificationSettingsForCurrentUser();
  Future<void> updateUserAccountInfo(CurrentUserAccountEntity userAccount);
  Future<AccountGetEntity> loadUserAccount();
  Future<void> deleteAccount();
  Future<void> callLogoutOnApi();
  Future<void> sendUserInitializationInfoToAPI(String country,
      String firebaseToken, String langugeCode, String deviceId);
  Future<AccountPremiumTokenOutputEntity> getUsedTokens(int accountId);
  Future<DateTime?> getDateForNextToken(int accountId);
  Future<AccountPremiumTokenOutputEntity> getExpiredTokens(int accountId);
  Future<AccountPremiumTokenOutputEntity> getAllTokens(int accountId);
  Future<AccountPremiumTokenOutputEntity> getAvailableTokens(int accountId);
  Future<bool> useToken(int accountId, int productId);
  Future<InAppPurchasePayEntity> createAppleSubscription(
      String itunesId, String receipt);
  Future<bool> isUserSubscribed();
  Future<bool> isCurrentUserTokenValid();
  Future<LightAccountEntity> getPublisherAccount(int? id);
  Future<LightAccountEntity> getOwnerAccount(int? id);
  Future<bool> followEditor(int id);
  Future<bool> followAuthor(int id);
  Future<bool> followEditorByProduct(int id);
  Future<bool> followSubThemeByProduct(int id);
  Future<bool> followSubTheme(int subthemeId, int categoryId);
  Future<bool> isSubThemeFollowed(int subthemeId, int categoryId);
  Future<bool> unFollowEditorByProduct(int id);
  Future<bool> unFollowSubThemeByProduct(int id);
  Future<bool> unFollowSubTheme(int themeId, int categoryId);
  Future<bool> unFollowAuthorByProduct(int id);
  Future<bool> followAuthorByProduct(int id);
  Future<bool> unFollowEditor(int id);
  Future<bool> unFollowAuthor(int id);
  Future<List<bool>> unFollowEditors(List<int> id);
  Future<List<bool>> unFollowSubThemes(
      List<(int subThemeId, int categoryId)> ids);
  Future<List<FollowItemEntity>> getAuthorsFollowed();
  Future<List<FollowItemEntity>> getEditorsFollowed();
  Future<List<SubThemeFollowItemWithCategoryEntity>> getThemesFollowed();
  Future<ProductFollowOutputEntity> getFolowedByProduct(int productId);
  Future<List<bool>> unFollowAuthors(List<int> ids);
  Future<bool> isUserEligibleToLisEtGagne(int userId);
  Future<bool> hasUserActivatedLisEtGagne(int userId);
}
