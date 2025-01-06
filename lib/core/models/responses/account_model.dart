import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/civility_type.dart';
import 'package:youscribe/core/models/responses/email_status_type.dart';
import 'package:youscribe/core/models/responses/gender_type.dart';
import 'package:youscribe/core/models/responses/image_url_output.dart';

part 'account_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class AccountModel {
  AccountModel({
    required this.id,
    required this.avatarUrls,
    required this.userName,
    required this.displayableUserName,
    required this.password,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.externalId,
    required this.countryCode,
    required this.emailIsPublic,
    required this.domainLanguageIsoCode,
    required this.trackingId,
    required this.ysAuthToken,
    required this.premiumIsAllowed,
    this.gender,
    this.civility,
    this.birthDate,
    this.blogUrl,
    this.webSiteUrl,
    this.facebookPage,
    this.twitterPage,
    this.city,
    this.biography,
    this.phoneNumber,
    this.emailStatus,
  });
  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);
  final int id;
  final List<ImageUrlOutput> avatarUrls;
  final String userName;
  final String displayableUserName;
  final String password;
  final String email;
  final String firstName;
  final String lastName;
  final String externalId;
  final GenderType? gender;
  final CivilityType? civility;
  final DateTime? birthDate;
  final String countryCode;
  final String? blogUrl;
  final String? webSiteUrl;
  final String? facebookPage;
  final String? twitterPage;
  final String? city;
  final String? biography;
  final String? phoneNumber;
  final bool emailIsPublic;
  final EmailStatusType? emailStatus;
  final String domainLanguageIsoCode;
  final String? trackingId;
  final String ysAuthToken;
  final bool premiumIsAllowed;

  String toJson() {
    final map = _$AccountModelToJson(this);
    return jsonEncode(map);
  }
}
