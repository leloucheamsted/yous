// ignore_for_file: avoid_dynamic_calls, 
// inference_failure_on_function_invocation

import 'package:dio/dio.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/account_premium_token_output_entity.dart';
import 'package:youscribe/core/repositories/repository_constants.dart';
import 'package:youscribe/data/data_sources/base_remote_data_source.dart';
import 'package:youscribe/data/data_sources/user_acount_data_sources/account_premium_token_data_source.dart';

// ignore:
class AccountPremiumTokenDataSourceImpl extends BaseRemoteDataSource
    implements AccountPremiumTokenDataSource {
  AccountPremiumTokenDataSourceImpl(
      {required super.dio, required super.appSettings});

  final String getNextTokenUrl =
      "api/v1/accounts/premium/get-next-by-account-id/{accountId}";
  final String getAllTokenUrl =
      "api/v1/accounts/premium/all-by-account-id/{accountId}";
  final String getOpenTokenUrl =
      "api/v1/accounts/premium/open-by-account-id/{accountId}";
  final String getExpiredTokenUrl =
      "api/v1/accounts/premium/expired-by-account-id/{accountId}";
  final String getUsedTokenUrl =
      "api/v1/accounts/premium/used-by-account-id/{accountId}";
  final String putAddTokenUrl =
      "api/v1/accounts/premium/add-to-account-id/{accountId}";
  final String putUseTokenUrl =
      "api/v1/accounts/premium/use-token/{accountId}/{productId}";
  final String deleteTokenUrl =
      "api/v1/accounts/premium/delete-token/{tokenId}";

  @override
  Future<bool> addToAccountIdAsync(
      int accountId, String type, DateTime? expireDate, int? count) async {
    var url = putAddTokenUrl.replaceAll('{accountId}', accountId.toString());
    final Map<String, String> dico = {};
    if (expireDate != null) {
      dico['expireDate'] = expireDate.toString();
    }
    if (count != null) {
      dico['count'] = count.toString();
    }
    if (type.isNotEmpty) {
      dico['type'] = type;
    }
    if (dico.isNotEmpty) {
      url += '?$dico';
    }
    final response = await put(url, {});
    if (response.statusCode == 200) {
      // await addErrorsAsync(response);
    }
    return response.statusCode == 200;
  }

  @override
  Future<bool> deleteTokenAsync(int tokenId) {
    // TODO: implement unFollowAuthor
    // info: required  Youscribe request data source

    throw UnimplementedError();
  }

  @override
  Future<AccountPremiumItemOutputEntity> getAllByAccountIdAsync(
      int accountId) async {
    final url = getAllTokenUrl.replaceAll('{accountId}', accountId.toString());
    final response = await get(url);

    return response.data! as AccountPremiumItemOutputEntity;
  }

  @override
  Future<AccountPremiumItemOutputEntity> getExpiredByAccountIdAsync(
      int accountId) async {
    final url =
        getExpiredTokenUrl.replaceAll('{accountId}', accountId.toString());
    final response = await get(url);
    return response.data! as AccountPremiumItemOutputEntity;
  }

  @override
  Future<DateTime?> getNextTokenAsync(int accountId) async {
    final headers = {RepositoryConstants.ysAuthHeader: await getAuthToken()};
    final result = await dio.get(
        "${appSettings.mainYSAPIUrl}/api/v1/accounts/premium/get-next-by-account-id/$accountId",
        options: Options(headers: headers));

    final String? response;
    if (result.data != null) {
      response = result.data.toString();
    } else {
      response = null;
    }
    return response.isNotNull ? DateTime.parse(result.data.toString()) : null;
  }

  @override
  Future<AccountPremiumTokenOutputEntity> getOpenByAccountIdAsync(
      int accountId) async {
    final headers = {RepositoryConstants.ysAuthHeader: await getAuthToken()};

    final url = getOpenTokenUrl.replaceAll('{accountId}', accountId.toString());
    final response = await dio.get("${appSettings.mainYSAPIUrl}/$url",
        options: Options(headers: headers));
    final responseDynamic = response.data["Tokens"] as List<dynamic>;
    final tokens = responseDynamic
        .map<AccountPremiumItemOutputEntity>((model) =>
            AccountPremiumItemOutputEntity(
                accountId: model['AccountId'] as int,
                id: model['Id'] as int,
                productId: model['ProductId'] != null
                    ? model['ProductId'] as int
                    : null,
                createDate: DateTime.parse(model['CreateDate'].toString()),
                type: model['Type'] as int))
        .toList();
    return AccountPremiumTokenOutputEntity(tokens: tokens);
  }

  @override
  Future<AccountPremiumTokenOutputEntity> getUsedByAccountIdAsync(
      int accountId) async {
    final headers = {RepositoryConstants.ysAuthHeader: await getAuthToken()};

    final url =
        getUsedTokenUrl.replaceFirst('{accountId}', accountId.toString());
    final response = await dio.get("${appSettings.mainYSAPIUrl}/$url",
        options: Options(headers: headers));
    final responseDynamic = response.data["Tokens"] as List<dynamic>;
    final tokens = responseDynamic
        .map<AccountPremiumItemOutputEntity>((model) =>
            AccountPremiumItemOutputEntity(
                accountId: model['AccountId'] as int,
                id: model['Id'] as int,
                productId: model['ProductId'] as int,
                createDate: DateTime.parse(model['CreateDate'].toString()),
                type: model['Type'] as int))
        .toList();
    return AccountPremiumTokenOutputEntity(tokens: tokens);
  }

  @override
  Future<bool> useTokenAsync(int accountId, int productId) async {
    final headers = {RepositoryConstants.ysAuthHeader: await getAuthToken()};

    final url = putUseTokenUrl
        .replaceAll("{accountId}", accountId.toString())
        .replaceAll("{productId}", productId.toString());
    final response = await dio.put("${appSettings.mainYSAPIUrl}/$url",
        data: {}, options: Options(headers: headers));
    return response.statusCode == 200;
  }
}
