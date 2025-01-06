class AccountPremiumItemOutputEntity {
  AccountPremiumItemOutputEntity({
    required this.id,
    required this.accountId,
    required this.productId,
    required this.createDate,
    required this.type,
    this.usedDate,
    this.expireDate,
  });
  int id;
  int accountId;
  int? productId;
  DateTime createDate;
  DateTime? usedDate;
  DateTime? expireDate;
  int type;
}

class AccountPremiumTokenOutputEntity {
  AccountPremiumTokenOutputEntity({required this.tokens});
  List<AccountPremiumItemOutputEntity> tokens;
}
