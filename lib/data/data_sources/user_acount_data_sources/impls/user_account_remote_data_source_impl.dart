// ignore_for_file: avoid_dynamic_calls, 
// inference_failure_on_function_invocation

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:youscribe/core/entities/account_entity.dart';
import 'package:youscribe/core/entities/account_premium_token_output_entity.dart';
import 'package:youscribe/core/entities/current_user_account_entity.dart';
import 'package:youscribe/core/entities/follow_item_entity.dart';
import 'package:youscribe/core/entities/in_app_purchase_pay_entity.dart';
import 'package:youscribe/core/entities/light_account_entity.dart';
import 'package:youscribe/core/entities/product_follow_output_entity.dart';
import 'package:youscribe/core/models/responses/account_get_model.dart';
import 'package:youscribe/core/models/responses/follow_item_model.dart';
import 'package:youscribe/core/models/responses/light_account_model.dart';
import 'package:youscribe/core/models/responses/sub_theme_follow_item_with_category_model.dart';
import 'package:youscribe/core/models/responses/subscription_state_model.dart';
import 'package:youscribe/core/models/responses/unfollow_response_model.dart';
import 'package:youscribe/core/models/responses/user_classification_settings_response.dart';
import 'package:youscribe/core/repositories/repository_constants.dart';
import 'package:youscribe/data/data_sources/base_remote_data_source.dart';
import 'package:youscribe/data/data_sources/user_acount_data_sources/account_premium_token_data_source.dart';
import 'package:youscribe/data/data_sources/user_acount_data_sources/user_account_remote_data_source.dart';

class UserAccountRemoteDataSourceImpl extends BaseRemoteDataSource
    implements UserAccountRemoteDataSource {
  UserAccountRemoteDataSourceImpl(
      {required super.dio,
      required AccountPremiumTokenDataSource premiumTokenDataSource,
      required super.appSettings})
      : _premiumTokenDataSource = premiumTokenDataSource;

  final AccountPremiumTokenDataSource _premiumTokenDataSource;

  @override
  Future<AccountGetEntity> loadUserAccount() async {
    final url = '${appSettings.mainYSAPIUrl}/api/v1/accounts';

    final response = await get(url);
    final userAccount =
        AccountGetModel.fromJson(response.data as Map<String, dynamic>);
    return AccountGetEntity()
      ..fromAccountModel(userAccount)
      ..premiumIsAllowed = response.data['PremiumIsAllowed'] as bool;
  }

  @override
  Future<AccountPremiumTokenOutputEntity> getExpiredTokens(int accountId) {
    // TODO: implement GetExpiredTokens
    // info: required  Youscribe request in AccountPremiumTokenDataSource
    throw UnimplementedError();
  }

  @override
  Future<AccountPremiumTokenOutputEntity> getUsedTokens(int accountId) {
    return _premiumTokenDataSource.getUsedByAccountIdAsync(accountId);
  }

  @override
  Future<void> callLogoutOnApi() async {
    final url = "${appSettings.mobileAPIUrl}/v1/accounts/logout";
    await get(url);
  }

  @override
  Future<InAppPurchasePayEntity> createAppleSubscription(
      String itunesId, String receipt) async {
    final url =
        '${appSettings.mobileAPIUrl}/v1/subscriptions/in-app-purchase?itunesId=${Uri.encodeQueryComponent(itunesId)}';
    final stringifiedJSON = jsonEncode(receipt);
    final response = await post(url, stringifiedJSON as Map<String, dynamic>);

    return response.data! as InAppPurchasePayEntity;
  }

  @override
  Future<void> deleteAccount() async {
    final url = '${appSettings.mainYSAPIUrl}/api/v1/accounts/delete-account';

    await delete(url);
  }

  @override
  Future<bool> followAuthor(int id) async {
    final url = '${appSettings.mainYSAPIUrl}/api/v2/follow/author-follow';
    final Map<String, dynamic> body = {'id': id};
    final response = await post(url, body);

    return (response.data!['IsFollowed']! as bool?) ?? false;
  }

  @override
  Future<bool> followAuthorByProduct(int id) async {
    final url =
        '${appSettings.mainYSAPIUrl}/api/v2/follow/author-follow/product';
    final Map<String, dynamic> body = {'productId': id};
    final response = await post(url, body);
    return (response.data!['Results'][0]['IsFollowed'] as bool?) ?? false;
  }

  @override
  Future<bool> followEditor(int id) async {
    final url = '${appSettings.mainYSAPIUrl}/api/v2/follow/editor-follow';
    final Map<String, dynamic> body = {'id': id};
    final response = await post(url, body);
    return (response.data!['IsFollowed'] as bool?) ?? false;
  }

  @override
  Future<bool> followEditorByProduct(int id) async {
    final url =
        '${appSettings.mainYSAPIUrl}/api/v2/follow/editor-follow/product';
    final Map<String, dynamic> body = {'ProductId': id};
    final response = await post(url, body);
    return (response.data!['IsFollowed'] as bool?) ?? false;
  }

  @override
  Future<bool> followSubTheme(int subthemeId, int categoryId) async {
    final url = '${appSettings.mainYSAPIUrl}/api/v2/follow/subtheme-follow';
    final body = {
      'id': subthemeId,
      'categoryId': categoryId,
    };
    final response = await post(url, body);
    return (response.data!['IsFollowed'] as bool?) ?? false;
  }

  @override
  Future<bool> followSubThemeByProduct(int id) async {
    final url =
        '${appSettings.mainYSAPIUrl}/api/v2/follow/subtheme-follow/product';
    final body = {'productId': id};
    final response = await post(url, body);
    return (response.data!['IsFollowed'] as bool?) ?? false;
  }

  @override
  Future<AccountPremiumTokenOutputEntity> getAllTokens(int accountId) {
    // TODO: implement getAllTokens
    // info: required  Youscribe request in AccountPremiumTokenDataSource
    throw UnimplementedError();
  }

  @override
  Future<List<FollowItemEntity>> getAuthorsFollowed() async {
    final url = "${appSettings.mainYSAPIUrl}/api/v2/follow/authors-followed";

    final response = await getWithType<dynamic>(url);
    final result = response.data! as List<dynamic>;
    final list = result
        .map((e) => FollowItemEntity.fromModel(
            FollowItemModel.fromJson(e as Map<String, dynamic>)))
        .toList();
    return list;
  }

  @override
  Future<AccountPremiumTokenOutputEntity> getAvailableTokens(int accountId) {
    return _premiumTokenDataSource.getOpenByAccountIdAsync(accountId);
  }

  @override
  Future<UserClassificationSettingsResponse>
      getClassificationSettingsForCurrentUser() async {
    // Make a Get request here: services.youscribe.com/api/v1/accounts/classifications/type-id
    final url =
        '${appSettings.mainYSAPIUrl}/api/v1/accounts/classifications/type-id';
    final headers = {RepositoryConstants.ysAuthHeader: await getAuthToken()};
    // ignore: inference_failure_on_function_invocation
    final response = await dio.get(url, options: Options(headers: headers));
    return UserClassificationSettingsResponse(
      classificationTreeId: response.data as int?,
    );
  }

  @override
  Future<DateTime?> getDateForNextToken(int accountId) {
    return _premiumTokenDataSource.getNextTokenAsync(accountId);
  }

  @override
  Future<List<FollowItemEntity>> getEditorsFollowed() async {
    final url = '${appSettings.mainYSAPIUrl}/api/v2/follow/editors-followed';

    final response = await getWithType<dynamic>(url);
    final result = response.data! as List<dynamic>;
    final list = result
        .map((e) => FollowItemEntity.fromModel(
            FollowItemModel.fromJson(e as Map<String, dynamic>)))
        .toList();
    return list;
  }

  @override
  Future<ProductFollowOutputEntity> getFolowedByProduct(int productId) async {
    final url =
        '${appSettings.mainYSAPIUrl}/api/v2/follow/product-followed?productId=$productId';
    final response = await get(url);
    final data = response.data as Map<String, dynamic>;
    final result = ProductFollowOutputEntity(
      isAuthorFollowed: data['IsAuthorFollowed'] as bool?,
      isEditorFollowed: data['IsEditorFollowed'] as bool?,
      isSubthemeFollowed: data['IsSubthemeFollowed'] as bool?,
    );
    return result;
  }

  @override
  Future<LightAccountEntity> getOwnerAccount(int? id) async {
    final url = "${appSettings.mainYSAPIUrl}/api/v1/people/$id";
    final response = await get(url);
    return response.data! as LightAccountEntity;
  }

  @override
  Future<LightAccountEntity> getPublisherAccount(int? id) async {
    final url =
        '${appSettings.mainYSAPIUrl}/api/v1/accounts/light-account-by-id/$id';
    final response = await get(url);
    final account =
        LightAccountModel.fromJson(response.data as Map<String, dynamic>);
    return LightAccountEntity(model: account);
  }

  @override
  Future<List<SubThemeFollowItemWithCategoryEntity>> getThemesFollowed() async {
    final url = '${appSettings.mainYSAPIUrl}/api/v2/follow/subthemes-followed';

    final response = await getWithType<dynamic>(url);
    final responseDynamic = response.data! as List<dynamic>;
    final listModel = List<SubThemeFollowItemWithCategoryModel>.from(
        responseDynamic.map((e) => SubThemeFollowItemWithCategoryModel.fromJson(
            e as Map<String, dynamic>))).toList();
    final List<SubThemeFollowItemWithCategoryEntity> result = [];
    if (listModel.isEmpty) {
      return [];
    }
    for (final item in listModel) {
      result.add(SubThemeFollowItemWithCategoryEntity.fromModel(item));
    }
    return result;
  }

  @override
  Future<bool> hasUserActivatedLisEtGagne(int userId) async {
    final url =
        "${appSettings.mainYSAPIUrl}/api/v1/readandwin/isactiveuser/{userId}";
    final response = await get(url);
    return response.data! as bool;
  }

  @override
  Future<bool> isCurrentUserTokenValid() async {
    final url = '${appSettings.mainYSAPIUrl}/api/v1/authorize';
    //getting bool
    final response = await getWithType<bool>(url);

    return response.data ?? false;
  }

  @override
  Future<bool> isSubThemeFollowed(int subthemeId, int categoryId) async {
    final url =
        '${appSettings.mainYSAPIUrl}/api/v2/follow/subtheme-followed?subThemeId=$subthemeId&categoryId=$categoryId';

    final response = await get(url);
    final isFollowed = response.data["IsFollowed"] as bool?;
    return isFollowed ?? false;
  }

  @override
  Future<bool> isUserEligibleToLisEtGagne(int userId) async {
    final url =
        "${appSettings.mobileAPIUrl}/api/v1/readandwin/eligibleuser/$userId";
    final response = await get(url);

    return response.data! as bool;
  }

  @override
  Future<bool> isUserSubscribed() async {
    final url = '${appSettings.mobileAPIUrl}/v1/subscriptions/current';
    final response = await get(url);
    final result =
        SubscriptionStateModel.fromJson(response.data as Map<String, dynamic>);
    return result.isSubscriber;
  }

  @override
  Future<void> sendUserInitializationInfoToAPI(String country,
      String firebaseToken, String languageCode, String deviceId) async {
    final body = {
      'firebaseToken': firebaseToken,
      'country': country,
      'languageCode': languageCode,
      'deviceId': deviceId,
    };

    final url = '${appSettings.mobileAPIUrl}/v1/accounts/updateMobileUserInfo';

    await put(url, body);
  }

  @override
  Future<bool> unFollowAuthor(int id) async {
    final url = '${appSettings.mainYSAPIUrl}/api/v2/follow/author-unfollow';
    final body = {'id': id};
    final response = await post(url, body);
    return (response.data!['IsUnfollowed']! as bool?) ?? false;
  }

  @override
  Future<bool> unFollowAuthorByProduct(int id) async {
    final url =
        '${appSettings.mainYSAPIUrl}/api/v2/follow/author-unfollow/product';
    final Map<String, dynamic> body = {'ProductId': id};
    final response = await post(url, body);
    return (response.data!['Results'][0]['IsUnfollowed']! as bool?) ?? false;
  }

  @override
  Future<List<bool>> unFollowAuthors(List<int> ids) async {
    final url = '${appSettings.mainYSAPIUrl}/api/v2/follow/authors-unfollow';
    final body = jsonEncode(ids.map((id) => {"id": id}).toList());
    final response = await postStringBody(url, body);
    final unfollowedlist = List<UnfollowResponseEntity>.from(
        (response.data!["Results"] as List<dynamic>)
            .map((e) => UnfollowResponseEntity.fromModel(
                UnfollowResponseModel.fromJson(e as Map<String, dynamic>)))
            .toList());

    final responseData = BulkUnFollowResponseEntity(results: unfollowedlist);
    return responseData.results.map((item) => item.isUnfollowed).toList();
  }

  @override
  Future<bool> unFollowEditor(int id) async {
    final url = '${appSettings.mainYSAPIUrl}/api/v2/follow/editor-unfollow';
    final body = {id: id};
    final response = await post(url, body as Map<String, dynamic>);
    return (response.data!['IsUnfollowed']! as bool?) ?? false;
  }

  @override
  Future<bool> unFollowEditorByProduct(int id) async {
    final url =
        '${appSettings.mainYSAPIUrl}/api/v2/follow/editor-unfollow/product';

    final Map<String, dynamic> body = {'ProductId': id};
    final response = await post(url, body);
    return (response.data!['IsUnfollowed']! as bool?) ?? false;
  }

  @override
  Future<List<bool>> unFollowEditors(List<int> id) async {
    final url = '${appSettings.mainYSAPIUrl}/api/v2/follow/editors-unfollow';
    final body = jsonEncode(id.map((i) => {"id": i}).toList());
    final response = await postStringBody(url, body);
    final unfollowedlist = List<UnfollowResponseEntity>.from(
        (response.data!["Results"] as List<dynamic>)
            .map((e) => UnfollowResponseEntity.fromModel(
                UnfollowResponseModel.fromJson(e as Map<String, dynamic>)))
            .toList());

    final responseData = BulkUnFollowResponseEntity(results: unfollowedlist);
    return responseData.results.map((item) => item.isUnfollowed).toList();
  }

  @override
  Future<bool> unFollowSubTheme(int themeId, int categoryId) async {
    final url = '${appSettings.mainYSAPIUrl}/api/v2/follow/subtheme-unfollow';

    final Map<String, dynamic> body = {'id': themeId, 'categoryId': categoryId};
    final response = await post(url, body);
    return (response.data!['IsUnfollowed'] as bool?) ?? false;
  }

  @override
  Future<bool> unFollowSubThemeByProduct(int id) async {
    final url =
        '${appSettings.mainYSAPIUrl}/api/v2/follow/subtheme-unfollow/product';
    final body = {
      'productId': id,
    };
    final response = await post(url, body);
    return (response.data!['IsUnfollowed'] as bool?) ?? false;
  }

  @override
  Future<List<bool>> unFollowSubThemes(
      List<(int subThemeId, int categoryId)> ids) async {
    final url = '${appSettings.mainYSAPIUrl}/api/v2/follow/subthemes-unfollow';
    final body = jsonEncode(
        ids.map((id) => {"Id": id.$1, "CategoryId": id.$2}).toList());

    final response = await postStringBody(url, body);
    final unfollowedlist = List<UnfollowResponseEntity>.from(
        (response.data!['Results'] as List<dynamic>)
            .map((e) => UnfollowResponseEntity.fromModel(
                UnfollowResponseModel.fromJson(e as Map<String, dynamic>)))
            .toList());

    final responseData = BulkUnFollowResponseEntity(results: unfollowedlist);
    return responseData.results.map((item) => item.isUnfollowed).toList();
  }

  @override
  Future<void> updateUserAccountInfo(
      CurrentUserAccountEntity userAccount) async {
    final url = '${appSettings.mainYSAPIUrl}/api/v1/accounts';
    final Map<String, dynamic> json = {
      'FirstName': userAccount.firstName,
      'LastName': userAccount.lastName,
      'Email': userAccount.email,
    };

    await put(url, json);
  }

  @override
  Future<bool> useToken(int accountId, int productId) {
    return _premiumTokenDataSource.useTokenAsync(accountId, productId);
  }
}
