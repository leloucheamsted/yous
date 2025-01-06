// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'in_app_purchase_pay_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InAppPurchasePayModel _$InAppPurchasePayModelFromJson(
        Map<String, dynamic> json) =>
    InAppPurchasePayModel(
      isValid: json['IsValid'] as bool?,
      status: $enumDecodeNullable(
          _$InAppPurchasePaymentStatusEnumMap, json['Status']),
      receiptAlreadyUsedOnOrderId: json['ReceiptAlreadyUsedOnOrderId'] as int?,
      receiptAlreadyAttachedOnAccountEmail:
          json['ReceiptAlreadyAttachedOnAccountEmail'] as String?,
    );

Map<String, dynamic> _$InAppPurchasePayModelToJson(
        InAppPurchasePayModel instance) =>
    <String, dynamic>{
      'IsValid': instance.isValid,
      'Status': _$InAppPurchasePaymentStatusEnumMap[instance.status],
      'ReceiptAlreadyUsedOnOrderId': instance.receiptAlreadyUsedOnOrderId,
      'ReceiptAlreadyAttachedOnAccountEmail':
          instance.receiptAlreadyAttachedOnAccountEmail,
    };

const _$InAppPurchasePaymentStatusEnumMap = {
  InAppPurchasePaymentStatus.ok: 0,
  InAppPurchasePaymentStatus.receiptAlreadyUse: 1,
  InAppPurchasePaymentStatus.receiptAttachedToAnotherAccount: 2,
  InAppPurchasePaymentStatus.error: 3,
  InAppPurchasePaymentStatus.unknown: 4,
};
