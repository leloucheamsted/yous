import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'save_in_app_subscription.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class SaveInAppSubscription {
  SaveInAppSubscription({
    this.platform,
    this.purchaseToken,
    this.purchaseId,
    this.productId,
  });
  factory SaveInAppSubscription.fromJson(Map<String, dynamic> json) =>
      _$SaveInAppSubscriptionFromJson(json);
  String? platform;
  String? purchaseToken;
  String? purchaseId;
  String? productId;

  String toJson() {
    final map = _$SaveInAppSubscriptionToJson(this);
    return jsonEncode(map);
  }
}
