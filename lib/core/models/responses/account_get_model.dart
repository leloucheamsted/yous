// ignore_for_file: annotate_overrides

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/account_model.dart';
import 'package:youscribe/core/models/responses/account_properties_model.dart';
import 'package:youscribe/core/models/responses/email_status_type.dart';
import 'package:youscribe/core/models/responses/image_url_output.dart';

part 'account_get_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class AccountGetModel extends AccountModel {
  AccountGetModel({required this.avatarUrls, required this.properties})
      : super(
            emailIsPublic: false,
            emailStatus: EmailStatusType.valid,
            premiumIsAllowed: false,
            countryCode: '',
            trackingId: '',
            ysAuthToken: '',
            twitterPage: '',
            domainLanguageIsoCode: '',
            id: 0,
            avatarUrls: [],
            userName: '',
            displayableUserName: '',
            password: '',
            email: '',
            firstName: '',
            lastName: '',
            externalId: '');
  factory AccountGetModel.fromJson(Map<String, dynamic> json) =>
      _$AccountGetModelFromJson(json);
  final List<ImageUrlOutput> avatarUrls;
  final List<AccountPropertiesModel> properties;

  @override
  String toJson() {
    final map = _$AccountGetModelToJson(this);
    return jsonEncode(map);
  }
}
