import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/account_get_properties.dart';
import 'package:youscribe/core/models/responses/image_url_output.dart';
part 'mobile_facebook_account.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class MobileFacebookAccount {
  MobileFacebookAccount({
    this.isSubscriber,
    this.cobranding,
    this.isNewUser,
    this.properties,
    this.avatarUrls,
  });
  factory MobileFacebookAccount.fromJson(Map<String, dynamic> json) =>
      _$MobileFacebookAccountFromJson(json);
  bool? isSubscriber;
  String? cobranding;
  bool? isNewUser;
  List<ImageUrlOutput>? avatarUrls;
  List<AccountGetProperties>? properties;

  String toJson() {
    final map = _$MobileFacebookAccountToJson(this);
    return jsonEncode(map);
  }
}
