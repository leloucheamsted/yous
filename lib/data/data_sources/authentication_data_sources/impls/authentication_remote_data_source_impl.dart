import 'dart:convert';

import 'package:youscribe/core/entities/current_user_account_entity.dart';
import 'package:youscribe/core/models/responses/mobile_account_model.dart';
import 'package:youscribe/core/repositories/repository_constants.dart';
import 'package:youscribe/data/data_sources/authentication_data_sources/authentication_remote_data_source.dart';
import 'package:youscribe/data/data_sources/base_remote_data_source.dart';

class AuthenticationRemoteDataSourceImpl extends BaseRemoteDataSource
    implements AuthenticationRemoteDataSource {
  AuthenticationRemoteDataSourceImpl({
    required super.dio,
    required super.appSettings,
  });

  @override
  Future<MobileAccountModel?> login(String userName, String password) async {
    final cleanUserName = Uri.encodeQueryComponent(userName);
    final cleanPassword = Uri.encodeQueryComponent(password);

    final url =
        '${appSettings.mobileAPIUrl}/v1/accounts/login?userName=$cleanUserName&password=$cleanPassword';

    final response = await get(url, headers: {
      RepositoryConstants.contentType: RepositoryConstants.contentTypeValue,
      RepositoryConstants.userAgentHeader: [
        '${appSettings.userAgent}/${RepositoryConstants.userAgentVersion}',
        RepositoryConstants.ysRestHeaderValue
      ],
    });

    return MobileAccountModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<MobileAccountModel?> signUp(
    String email, {
    required String countryCode,
    String? giftCode,
    bool createSubscription = true,
  }) async {
    final String url =
        '${appSettings.mobileAPIUrl}/v1/accounts?countryCode=$countryCode&createSubscription=$createSubscription${giftCode != null ? '&code=$giftCode' : ''}';

    final response = await postStringBody(url, '"$email"', headers: {
      RepositoryConstants.contentType: RepositoryConstants.contentTypeValue,
      RepositoryConstants.userAgentHeader: [
        '${appSettings.userAgent}/${RepositoryConstants.userAgentVersion}',
        RepositoryConstants.ysRestHeaderValue
      ],
    });

    return MobileAccountModel.fromJson(response.data!);
  }

  @override
  Future<MobileAccountModel> authenticateWithFacebook(
      {required String accessToken,
      required String countryCode,
      String? giftCode,
      bool createSubscription = false}) async {
    final url =
        '${appSettings.mobileAPIUrl}/v1/accounts/facebook?countryCode=$countryCode&createSubscription=$createSubscription&code=$giftCode';
    // ignore: inference_failure_on_function_invocation
    final result = await dio.put(url, data: '"$accessToken"');

    return MobileAccountModel.fromJson(result.data! as Map<String, dynamic>);
  }

  @override
  Future<bool> forgotPassword(String email) async {
    final url =
        '${appSettings.mainYSAPIUrl}/api/v1/accounts/forgot-passwords?userNameOrEmail=$email';
    // ignore: inference_failure_on_function_invocation
    final response = await dio.put(url);
    if (response.statusCode != 204 && response.statusCode != 200) {
      return false;
    }
    return true;
  }

  @override
  Future<CurrentUserAccountEntity?> authenticateWithApple(
      {required String appleUserId,
      required String countryCode,
      required bool createSubscription,
      required String email,
      required String languageCode,
      required String subscriptionCode,
      required String tokenId,
      required String userName}) async {
    final url = "${appSettings.mobileAPIUrl}${appSettings.appleAuthEndpoint}";
    final accoumtModel = await postAppleToken(
        url,
        countryCode,
        tokenId,
        userName,
        email,
        languageCode,
        createSubscription,
        subscriptionCode,
        appleUserId);

    return CurrentUserAccountEntity.fromMobileAccount(accoumtModel);
  }

  Future<MobileAccountModel> postAppleToken(
      String url,
      String countryCode,
      String token,
      String userName,
      String email,
      String languageCode,
      bool createSubscription,
      String subscriptionCode,
      String appleUserId) async {
    final body = jsonEncode({
      'TokenId': token,
      'UserName': userName,
      'Email': email,
      'LanguageCode': languageCode,
      'CountryCode': countryCode,
      'AppleUserId': appleUserId,
      'CreateSubscription': createSubscription,
      'SubscriptionCode': subscriptionCode,
    });

    // ignore: inference_failure_on_function_invocation
    final response = await dio.post(url, data: body);
    final responseDynamic = response.data! as dynamic;
    return MobileAccountModel.fromJson(responseDynamic as Map<String, dynamic>);
  }
}
