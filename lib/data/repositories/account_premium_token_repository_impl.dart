import 'package:youscribe/core/entities/account_premium_token_output_entity.dart';
import 'package:youscribe/core/repositories/account_premium_token_repository.dart';
import 'package:youscribe/data/data_sources/user_acount_data_sources/account_premium_token_data_source.dart';

class AccountPremiumTokenRepositoryImpl
    implements AccountPremiumTokenRepository {
  AccountPremiumTokenRepositoryImpl({
    required AccountPremiumTokenDataSource accountPremiumTokenDataSource,
  }) : _accountPremiumTokenDataSource = accountPremiumTokenDataSource;

  final AccountPremiumTokenDataSource _accountPremiumTokenDataSource;

  @override
  Future<bool> addToAccountIdAsync(
      int accountId, String type, DateTime? expireDate, int? count) {
    return _accountPremiumTokenDataSource.addToAccountIdAsync(
        accountId, type, expireDate, count);
  }

  @override
  Future<bool> deleteTokenAsync(int tokenId) {
    return _accountPremiumTokenDataSource.deleteTokenAsync(tokenId);
  }

  @override
  Future<AccountPremiumItemOutputEntity> getAllByAccountIdAsync(int accountId) {
    return _accountPremiumTokenDataSource.getAllByAccountIdAsync(accountId);
  }

  @override
  Future<AccountPremiumItemOutputEntity> getExpiredByAccountIdAsync(
      int accountId) {
    return _accountPremiumTokenDataSource.getAllByAccountIdAsync(accountId);
  }

  @override
  Future<DateTime?> getNextTokenAsync(int accountId) {
    return _accountPremiumTokenDataSource.getNextTokenAsync(accountId);
  }

  @override
  Future<AccountPremiumTokenOutputEntity> getOpenByAccountIdAsync(
      int accountId) {
    return _accountPremiumTokenDataSource.getOpenByAccountIdAsync(accountId);
  }

  @override
  Future<AccountPremiumTokenOutputEntity> getUsedByAccountIdAsync(
      int accountId) {
    return _accountPremiumTokenDataSource.getUsedByAccountIdAsync(accountId);
  }

  @override
  Future<bool> useTokenAsync(int accountId, int productId) {
    return _accountPremiumTokenDataSource.useTokenAsync(accountId, productId);
  }
}
