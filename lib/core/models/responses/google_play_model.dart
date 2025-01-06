import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'google_play_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class GooglePlayPayModel {
  GooglePlayPayModel({
    this.isValid,
    this.status,
    this.receiptAlreadyUsedOnOrderId,
    this.receiptAlreadyAttachedOnAccountEmail,
  });
  factory GooglePlayPayModel.fromJson(Map<String, dynamic> json) =>
      _$GooglePlayPayModelFromJson(json);
  bool? isValid;
  GooglePlayPayStatus? status;
  int? receiptAlreadyUsedOnOrderId;
  String? receiptAlreadyAttachedOnAccountEmail;

  String toJson() {
    final map = _$GooglePlayPayModelToJson(this);
    return jsonEncode(map);
  }
}

enum GooglePlayPayStatus {
  @JsonValue(0)
  ok,
  @JsonValue(1)
  receiptAlreadyUse,
  @JsonValue(2)
  receiptAttachedToAnotherAccount,
  @JsonValue(3)
  error,
}
