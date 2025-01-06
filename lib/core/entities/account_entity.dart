import 'package:youscribe/core/models/responses/account_model.dart';
import 'package:youscribe/core/models/responses/account_properties_model.dart';
import 'package:youscribe/core/models/responses/civility_type.dart';
import 'package:youscribe/core/models/responses/email_status_type.dart';
import 'package:youscribe/core/models/responses/gender_type.dart';
import 'package:youscribe/core/models/responses/image_url_output.dart';

class FacebookAccountEntity extends AccountGetEntity {
  FacebookAccountEntity({
    required this.isNewUser,
  });
  final bool isNewUser;
}

class AccountPropertiesEntity {
  AccountPropertiesEntity({this.id, this.value, this.type});
  int? id;
  String? value;
  String? type;

  void fromAccountPropertiesModel(AccountPropertiesModel model) {
    id = model.id;
    value = model.value;
    type = model.type;
  }
}

class AccountGetEntity extends AccountEntity {
  AccountGetEntity({
    this.properties,
  }) : super(
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

  List<AccountPropertiesEntity>? properties;
}

class AccountEntity {
  AccountEntity({
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
  int id;
  List<ImageUrlOutput> avatarUrls;
  String userName;
  String displayableUserName;
  String password;
  String email;
  String firstName;
  String lastName;
  String externalId;
  GenderType? gender;
  CivilityType? civility;
  DateTime? birthDate;
  String countryCode;
  String? blogUrl;
  String? webSiteUrl;
  String? facebookPage;
  String? twitterPage;
  String? city;
  String? biography;
  String? phoneNumber;
  bool emailIsPublic;
  EmailStatusType? emailStatus;
  String domainLanguageIsoCode;
  String? trackingId;
  String ysAuthToken;
  bool premiumIsAllowed;

  void fromAccountModel(AccountModel model) {
    id = model.id;
    userName = model.userName;
    displayableUserName = model.displayableUserName;
    password = model.password;
    email = model.email;
    firstName = model.firstName;
    lastName = model.lastName;
    externalId = model.externalId;
    gender = model.gender;
    civility = model.civility;
    birthDate = model.birthDate ?? DateTime.now();
    countryCode = model.countryCode;
    blogUrl = model.blogUrl;
    webSiteUrl = model.webSiteUrl;
    facebookPage = model.facebookPage;
    twitterPage = model.twitterPage;
    city = model.city;
    biography = model.biography;
    phoneNumber = model.phoneNumber;
    emailIsPublic = model.emailIsPublic;
    emailStatus = model.emailStatus;
    domainLanguageIsoCode = model.domainLanguageIsoCode;
    trackingId = model.trackingId;
    ysAuthToken = model.ysAuthToken;
    premiumIsAllowed = model.premiumIsAllowed;
  }
}

enum NotificationFrequency { realTime, byDay, byWeek, never }
