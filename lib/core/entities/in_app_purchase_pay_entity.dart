class InAppPurchasePayEntity {
  InAppPurchasePayEntity({
    required this.isValid,
    required this.status,
    required this.receiptAlreadyUsedOnOrderId,
    required this.receiptAlreadyAttachedOnAccountEmail,
  });
  bool isValid;
  InAppPurchasePaymentStatus status;
  int? receiptAlreadyUsedOnOrderId;
  String receiptAlreadyAttachedOnAccountEmail;
}

enum InAppPurchasePaymentStatus {
  ok(0),
  receiptAlreadyUse(1),
  receiptAttachedToAnotherAccount(2),
  error(3);

  const InAppPurchasePaymentStatus(this.value);
  final num value;
}
