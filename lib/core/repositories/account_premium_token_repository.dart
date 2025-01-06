import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:youscribe/core/entities/account_premium_token_output_entity.dart';

abstract class AccountPremiumTokenRepository extends BaseRepository {
  Future<AccountPremiumItemOutputEntity> getAllByAccountIdAsync(int accountId);
  Future<AccountPremiumTokenOutputEntity> getOpenByAccountIdAsync(
      int accountId);
  Future<AccountPremiumItemOutputEntity> getExpiredByAccountIdAsync(
      int accountId);
  Future<AccountPremiumTokenOutputEntity> getUsedByAccountIdAsync(
      int accountId);
  Future<bool> addToAccountIdAsync(
      int accountId, String type, DateTime? expireDate, int? count);
  Future<bool> useTokenAsync(int accountId, int productId);
  Future<bool> deleteTokenAsync(int tokenId);
  Future<DateTime?> getNextTokenAsync(int accountId);
}
