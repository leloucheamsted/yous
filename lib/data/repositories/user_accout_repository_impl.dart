import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/account_entity.dart';
import 'package:youscribe/core/entities/account_premium_token_output_entity.dart';
import 'package:youscribe/core/entities/canalplus_config_entity.dart';
import 'package:youscribe/core/entities/country_configuration_entity.dart';
import 'package:youscribe/core/entities/current_user_account_entity.dart';
import 'package:youscribe/core/entities/follow_item_entity.dart';
import 'package:youscribe/core/entities/in_app_purchase_pay_entity.dart';
import 'package:youscribe/core/entities/light_account_entity.dart';
import 'package:youscribe/core/entities/product_category_entity.dart';
import 'package:youscribe/core/entities/product_follow_output_entity.dart';
import 'package:youscribe/core/entities/simple_library_entity.dart';
import 'package:youscribe/core/entities/user_global_settings_entity.dart';
import 'package:youscribe/core/models/responses/user_classification_settings_response.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe/data/data_sources/user_acount_data_sources/user_account_local_data_source.dart';
import 'package:youscribe/data/data_sources/user_acount_data_sources/user_account_remote_data_source.dart';
import 'package:youscribe/data/data_sources/user_acount_data_sources/user_settings_local_data_source.dart';
import 'package:youscribe/utilities/constants.dart';

class UserAccountRepositoryImpl implements UserAccountRepository {
  UserAccountRepositoryImpl({
    required UserAccountRemoteDataSource userAccountRemoteDataSource,
    required UserSettingsLocalDataSource userSettingsLocalDataSource,
    required UserAccountLocalDataSource userAccountLocalDataSource,
  })  : _userAccountRemoteDataSource = userAccountRemoteDataSource,
        _userAccountLocalDataSource = userAccountLocalDataSource,
        _userSettingsLocalDataSource = userSettingsLocalDataSource;

  final UserAccountRemoteDataSource _userAccountRemoteDataSource;
  final UserSettingsLocalDataSource _userSettingsLocalDataSource;
  final UserAccountLocalDataSource _userAccountLocalDataSource;

  @override
  Future<void> callLogoutOnApi() {
    return _userAccountRemoteDataSource.callLogoutOnApi();
  }

  @override
  Future<InAppPurchasePayEntity> createAppleSubscription(
      String itunesId, String receipt) {
    return _userAccountRemoteDataSource.createAppleSubscription(
        itunesId, receipt);
  }

  @override
  Future<void> deleteAccount() {
    return _userAccountRemoteDataSource.deleteAccount();
  }

  @override
  Future<bool> followAuthor(int id) {
    return _userAccountRemoteDataSource.followAuthor(id);
  }

  @override
  Future<bool> followAuthorByProduct(int id) {
    return _userAccountRemoteDataSource.followAuthorByProduct(id);
  }

  @override
  Future<bool> followEditor(int id) {
    return _userAccountRemoteDataSource.followEditor(id);
  }

  @override
  Future<bool> followEditorByProduct(int id) {
    return _userAccountRemoteDataSource.followEditorByProduct(id);
  }

  @override
  Future<bool> followSubTheme(int subthemeId, int categoryId) {
    return _userAccountRemoteDataSource.followSubTheme(subthemeId, categoryId);
  }

  @override
  Future<bool> followSubThemeByProduct(int id) {
    return _userAccountRemoteDataSource.followSubThemeByProduct(id);
  }

  @override
  Future<AccountPremiumTokenOutputEntity> getAllTokens(int accountId) {
    return _userAccountRemoteDataSource.getAllTokens(accountId);
  }

  @override
  Future<List<FollowItemEntity>> getAuthorsFollowed() {
    return _userAccountRemoteDataSource.getAuthorsFollowed();
  }

  @override
  Future<AccountPremiumTokenOutputEntity> getAvailableTokens(int accountId) {
    return _userAccountRemoteDataSource.getAvailableTokens(accountId);
  }

  @override
  Future<UserClassificationSettingsResponse>
      getClassificationSettingsForCurrentUser() async {
    final classTr = await _userAccountRemoteDataSource
        .getClassificationSettingsForCurrentUser();

    final uAcc = await _userAccountLocalDataSource.retrieve();
    if (uAcc != null) {
      uAcc.classificationTreeId = classTr.classificationTreeId;
      await _userAccountLocalDataSource.save(uAcc);
    }

    return classTr;
  }

  @override
  Future<DateTime?> getDateForNextToken(int accountId) {
    return _userAccountRemoteDataSource.getDateForNextToken(accountId);
  }

  @override
  Future<List<FollowItemEntity>> getEditorsFollowed() {
    return _userAccountRemoteDataSource.getEditorsFollowed();
  }

  @override
  Future<AccountPremiumTokenOutputEntity> getExpiredTokens(int accountId) {
    return _userAccountRemoteDataSource.getExpiredTokens(accountId);
  }

  @override
  Future<ProductFollowOutputEntity> getFolowedByProduct(int productId) {
    return _userAccountRemoteDataSource.getFolowedByProduct(productId);
  }

  @override
  Future<LightAccountEntity> getOwnerAccount(int? id) {
    return _userAccountRemoteDataSource.getOwnerAccount(id);
  }

  @override
  Future<LightAccountEntity> getPublisherAccount(int? id) {
    return _userAccountRemoteDataSource.getPublisherAccount(id);
  }

  @override
  Future<List<SubThemeFollowItemWithCategoryEntity>> getThemesFollowed() {
    return _userAccountRemoteDataSource.getThemesFollowed();
  }

  @override
  Future<AccountPremiumTokenOutputEntity> getUsedTokens(int accountId) {
    return _userAccountRemoteDataSource.getUsedTokens(accountId);
  }

  @override
  Future<bool> hasUserActivatedLisEtGagne(int userId) {
    return _userAccountRemoteDataSource.hasUserActivatedLisEtGagne(userId);
  }

  @override
  Future<bool> isCurrentUserTokenValid() {
    return _userAccountRemoteDataSource.isCurrentUserTokenValid();
  }

  @override
  Future<bool> isSubThemeFollowed(int subthemeId, int categoryId) {
    return _userAccountRemoteDataSource.isSubThemeFollowed(
        subthemeId, categoryId);
  }

  @override
  Future<bool> isUserEligibleToLisEtGagne(int userId) {
    return _userAccountRemoteDataSource.isUserEligibleToLisEtGagne(userId);
  }

  @override
  Future<bool> isUserSubscribed() {
    return _userAccountRemoteDataSource.isUserSubscribed();
  }

  @override
  Future<AccountGetEntity> loadUserAccount() {
    return _userAccountRemoteDataSource.loadUserAccount();
  }

  @override
  Future<void> sendUserInitializationInfoToAPI(String country,
      String firebaseToken, String langugeCode, String deviceId) {
    return _userAccountRemoteDataSource.sendUserInitializationInfoToAPI(
        country, firebaseToken, langugeCode, deviceId);
  }

  @override
  Future<bool> unFollowAuthor(int id) {
    return _userAccountRemoteDataSource.unFollowAuthor(id);
  }

  @override
  Future<bool> unFollowAuthorByProduct(int id) {
    return _userAccountRemoteDataSource.unFollowAuthorByProduct(id);
  }

  @override
  Future<List<bool>> unFollowAuthors(List<int> ids) {
    return _userAccountRemoteDataSource.unFollowAuthors(ids);
  }

  @override
  Future<bool> unFollowEditor(int id) {
    return _userAccountRemoteDataSource.unFollowEditor(id);
  }

  @override
  Future<bool> unFollowEditorByProduct(int id) {
    return _userAccountRemoteDataSource.unFollowEditorByProduct(id);
  }

  @override
  Future<List<bool>> unFollowEditors(List<int> id) {
    return _userAccountRemoteDataSource.unFollowEditors(id);
  }

  @override
  Future<bool> unFollowSubTheme(int themeId, int categoryId) {
    return _userAccountRemoteDataSource.unFollowSubTheme(themeId, categoryId);
  }

  @override
  Future<bool> unFollowSubThemeByProduct(int id) {
    return _userAccountRemoteDataSource.unFollowSubThemeByProduct(id);
  }

  @override
  Future<List<bool>> unFollowSubThemes(List<(int, int)> ids) {
    return _userAccountRemoteDataSource.unFollowSubThemes(ids);
  }

  @override
  Future<void> saveUserAccount(CurrentUserAccountEntity userAccount) {
    return _userAccountLocalDataSource.save(userAccount);
  }

  @override
  Future<void> updateUserAccountInfoOnline(
      CurrentUserAccountEntity userAccount) {
    return _userAccountRemoteDataSource.updateUserAccountInfo(userAccount);
  }

  @override
  Future<bool> useToken(int accountId, int productId) {
    return _userAccountRemoteDataSource.useToken(accountId, productId);
  }

  @override
  Future<void> deleteUserSettings() {
    return _userSettingsLocalDataSource.delete();
  }

  @override
  Future<void> incrementAppOpenedCount() {
    return _userSettingsLocalDataSource.incrementAppOpenedCount();
  }

  @override
  Future<UserGlobalSettingsEntity> getUserSettings() async {
    var us = await _userSettingsLocalDataSource.retrieve();
    if (us == null) {
      us = UserGlobalSettingsEntity(appOpenedCount: 1, localId: 1);
      await _userSettingsLocalDataSource.save(us);
    }

    return us;
  }

  @override
  Future<void> saveUserSettings(UserGlobalSettingsEntity data) {
    return _userSettingsLocalDataSource.save(data);
  }

  @override
  Future<void> setCanalplusConfig(CanalplusConfigEntity canalplusConfig) {
    return _userSettingsLocalDataSource.setCanalplusConfig(canalplusConfig);
  }

  @override
  Future<void> setClassificationTree(
      List<ProductCategoryEntity> classificationTree) {
    return _userSettingsLocalDataSource
        .setClassificationTree(classificationTree);
  }

  @override
  Future<void> setCountryConfig(CountryConfigurationEntity countryConfig) {
    return _userSettingsLocalDataSource.setCountryConfig(countryConfig);
  }

  @override
  Future<void> setTheme(ThemeType theme) {
    return _userSettingsLocalDataSource.setTheme(theme);
  }

  @override
  Future<void> setDontDisplaySwipeProductsListHelp(bool val) {
    return _userSettingsLocalDataSource
        .setDontDisplaySwipeProductsListHelp(val);
  }

  @override
  Future<void> setIsCanalplusUser(bool val) {
    return _userSettingsLocalDataSource.setIsCanalplusUser(val);
  }

  @override
  Future<void> setLastInactiveSessionUserReadTriggerDate() {
    return _userSettingsLocalDataSource
        .setLastInactiveSessionUserReadTriggerDate();
  }

  @override
  Future<void> setLastTimeConnectedToInternet(DateTime dateTime) {
    return _userSettingsLocalDataSource
        .setLastTimeConnectedToInternet(dateTime);
  }

  @override
  Future<void> setPreferredLanguageCode(String lang, String countryCode) {
    return _userSettingsLocalDataSource.setPreferredLanguageCode(
        lang, countryCode);
  }

  @override
  Future<CurrentUserAccountEntity?> getCurrentUserAccountOffline() {
    return _userAccountLocalDataSource.retrieve();
  }

  @override
  Future<int> getOfflineClassificationSettingsForCurrentUser() async {
    final usr = await _userAccountLocalDataSource.retrieve();

    if (usr != null) {
      return usr.classificationTreeId ?? 0;
    }

    return 0;
  }

  @override
  Future<List<SimpleLibraryEntity>?> retrieveUserSelections() async {
    final selections =
        await _userAccountLocalDataSource.retrieveUserSelections();
    return selections;
  }

  @override
  Future<void> saveUserSelections(List<SimpleLibraryEntity> selections) async {
    await _userAccountLocalDataSource.saveUserSelections(selections);
  }

  @override
  Future<void> setFirebaseToken(String firebaseToken) async {
    Auth.setFirebaseToken(firebaseToken);

    return _userAccountLocalDataSource.saveFirebaseToken(firebaseToken);
  }
}
