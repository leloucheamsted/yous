// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_in_app_subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveInAppSubscription _$SaveInAppSubscriptionFromJson(
        Map<String, dynamic> json) =>
    SaveInAppSubscription(
      platform: json['Platform'] as String?,
      purchaseToken: json['PurchaseToken'] as String?,
      purchaseId: json['PurchaseId'] as String?,
      productId: json['ProductId'] as String?,
    );

Map<String, dynamic> _$SaveInAppSubscriptionToJson(
        SaveInAppSubscription instance) =>
    <String, dynamic>{
      'Platform': instance.platform,
      'PurchaseToken': instance.purchaseToken,
      'PurchaseId': instance.purchaseId,
      'ProductId': instance.productId,
    };
