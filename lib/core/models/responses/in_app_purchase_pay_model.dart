import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'in_app_purchase_pay_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class InAppPurchasePayModel {
  InAppPurchasePayModel({
    this.isValid,
    this.status,
    this.receiptAlreadyUsedOnOrderId,
    this.receiptAlreadyAttachedOnAccountEmail,
  });
  factory InAppPurchasePayModel.fromJson(Map<String, dynamic> json) =>
      _$InAppPurchasePayModelFromJson(json);
  bool? isValid;
  InAppPurchasePaymentStatus? status;
  int? receiptAlreadyUsedOnOrderId;
  String? receiptAlreadyAttachedOnAccountEmail;

  String toJson() {
    final map = _$InAppPurchasePayModelToJson(this);
    return jsonEncode(map);
  }
}

enum InAppPurchasePaymentStatus {
  @JsonValue(0)
  ok,
  @JsonValue(1)
  receiptAlreadyUse,
  @JsonValue(2)
  receiptAttachedToAnotherAccount,
  @JsonValue(3)
  error,
  @JsonValue(4)
  unknown
}
