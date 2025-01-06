import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'subscription_state_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class SubscriptionStateModel {
  SubscriptionStateModel({
    required this.isSubscriber,
  });
  factory SubscriptionStateModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionStateModelFromJson(json);
  bool isSubscriber;

  String toJson() {
    final map = _$SubscriptionStateModelToJson(this);
    return jsonEncode(map);
  }
}
