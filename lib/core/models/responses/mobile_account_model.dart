import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/image_url_output.dart';
part 'mobile_account_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class MobileAccountModel {
  MobileAccountModel({
    this.userName,
    this.id,
    this.email,
    this.imageUrl,
    this.token,
    this.trackingId,
    this.isSubscriber,
    this.cobranding,
    this.additionnalRightRequired,
    this.additionnalRightExpiration,
    this.avatarUrls,
  });
  factory MobileAccountModel.fromJson(Map<String, dynamic> json) =>
      _$MobileAccountModelFromJson(json);

  @JsonKey(name: 'UserName')
  String? userName;
  @JsonKey(name: 'Id')
  int? id;
  @JsonKey(name: 'Email')
  String? email;
  @JsonKey(name: 'ImageUrl')
  String? imageUrl;
  @JsonKey(name: 'YsAuthToken')
  String? token;
  @JsonKey(name: 'TrackingId')
  String? trackingId;
  @JsonKey(name: 'IsSubscriber')
  bool? isSubscriber;
  @JsonKey(name: 'Cobranding')
  String? cobranding;
  @JsonKey(name: 'AdditionnalRightRequired')
  bool? additionnalRightRequired;
  @JsonKey(name: 'AdditionnalRightExpiration')
  DateTime? additionnalRightExpiration;
  @JsonKey(name: 'AvatarUrls')
  List<ImageUrlOutput>? avatarUrls;

  String toJson() {
    final map = _$MobileAccountModelToJson(this);
    return jsonEncode(map);
  }
}
