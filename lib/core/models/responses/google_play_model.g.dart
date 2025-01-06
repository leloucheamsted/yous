// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_play_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GooglePlayPayModel _$GooglePlayPayModelFromJson(Map<String, dynamic> json) =>
    GooglePlayPayModel(
      isValid: json['IsValid'] as bool?,
      status: $enumDecodeNullable(_$GooglePlayPayStatusEnumMap, json['Status']),
      receiptAlreadyUsedOnOrderId: json['ReceiptAlreadyUsedOnOrderId'] as int?,
      receiptAlreadyAttachedOnAccountEmail:
          json['ReceiptAlreadyAttachedOnAccountEmail'] as String?,
    );

Map<String, dynamic> _$GooglePlayPayModelToJson(GooglePlayPayModel instance) =>
    <String, dynamic>{
      'IsValid': instance.isValid,
      'Status': _$GooglePlayPayStatusEnumMap[instance.status],
      'ReceiptAlreadyUsedOnOrderId': instance.receiptAlreadyUsedOnOrderId,
      'ReceiptAlreadyAttachedOnAccountEmail':
          instance.receiptAlreadyAttachedOnAccountEmail,
    };

const _$GooglePlayPayStatusEnumMap = {
  GooglePlayPayStatus.ok: 0,
  GooglePlayPayStatus.receiptAlreadyUse: 1,
  GooglePlayPayStatus.receiptAttachedToAnotherAccount: 2,
  GooglePlayPayStatus.error: 3,
};
