// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) => AccountModel(
      id: json['Id'] as int,
      avatarUrls: (json['AvatarUrls'] as List<dynamic>)
          .map((e) => ImageUrlOutput.fromJson(e as Map<String, dynamic>))
          .toList(),
      userName: json['UserName'] as String,
      displayableUserName: json['DisplayableUserName'] as String,
      password: json['Password'] as String,
      email: json['Email'] as String,
      firstName: json['FirstName'] as String,
      lastName: json['LastName'] as String,
      externalId: json['ExternalId'] as String,
      countryCode: json['CountryCode'] as String,
      emailIsPublic: json['EmailIsPublic'] as bool,
      domainLanguageIsoCode: json['DomainLanguageIsoCode'] as String,
      trackingId: json['TrackingId'] as String?,
      ysAuthToken: json['YsAuthToken'] as String,
      premiumIsAllowed: json['PremiumIsAllowed'] as bool,
      gender: $enumDecodeNullable(_$GenderTypeEnumMap, json['Gender']),
      civility: $enumDecodeNullable(_$CivilityTypeEnumMap, json['Civility']),
      birthDate: json['BirthDate'] == null
          ? null
          : DateTime.parse(json['BirthDate'] as String),
      blogUrl: json['BlogUrl'] as String?,
      webSiteUrl: json['WebSiteUrl'] as String?,
      facebookPage: json['FacebookPage'] as String?,
      twitterPage: json['TwitterPage'] as String?,
      city: json['City'] as String?,
      biography: json['Biography'] as String?,
      phoneNumber: json['PhoneNumber'] as String?,
      emailStatus:
          $enumDecodeNullable(_$EmailStatusTypeEnumMap, json['EmailStatus']),
    );

Map<String, dynamic> _$AccountModelToJson(AccountModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'AvatarUrls': instance.avatarUrls,
      'UserName': instance.userName,
      'DisplayableUserName': instance.displayableUserName,
      'Password': instance.password,
      'Email': instance.email,
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'ExternalId': instance.externalId,
      'Gender': _$GenderTypeEnumMap[instance.gender],
      'Civility': _$CivilityTypeEnumMap[instance.civility],
      'BirthDate': instance.birthDate?.toIso8601String(),
      'CountryCode': instance.countryCode,
      'BlogUrl': instance.blogUrl,
      'WebSiteUrl': instance.webSiteUrl,
      'FacebookPage': instance.facebookPage,
      'TwitterPage': instance.twitterPage,
      'City': instance.city,
      'Biography': instance.biography,
      'PhoneNumber': instance.phoneNumber,
      'EmailIsPublic': instance.emailIsPublic,
      'EmailStatus': _$EmailStatusTypeEnumMap[instance.emailStatus],
      'DomainLanguageIsoCode': instance.domainLanguageIsoCode,
      'TrackingId': instance.trackingId,
      'YsAuthToken': instance.ysAuthToken,
      'PremiumIsAllowed': instance.premiumIsAllowed,
    };

const _$GenderTypeEnumMap = {
  GenderType.male: 0,
  GenderType.female: 1,
};

const _$CivilityTypeEnumMap = {
  CivilityType.mr: 0,
  CivilityType.mrs: 1,
  CivilityType.mis: 2,
};

const _$EmailStatusTypeEnumMap = {
  EmailStatusType.valid: 0,
  EmailStatusType.invalid: 1,
};
