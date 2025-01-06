// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:youscribe/config/app_settings.dart';
import 'package:youscribe/data/data_sources/authentication_data_sources/impls/authentication_remote_data_source_impl.dart';

/// `dart test/authentication_test.dart <email>`
Future<void> main(
  List<String> args,
) async {
  final AppSettings appSettings = AppSettings(
    appName: "YouScribe",
    apiStreamingURL: 'https://api-streaming.youscribe.com/v2/products/',
    appBrand: AppBrand.youScribe,
    appleAuthEndpoint: '/v1/accounts/apple',
    applicationId: 8,
    canalPlusAuthUrl:
        'https://pass.canal-plus.com/provider-IdPOAuth2/auth/YouScribe?client_id=youscribe&redirect_uri={0}&response_type=code&scope=scope1 scope2 offline_access',
    canalPlusYsRedirectUrl:
        'https://www.youscribe.com/authorize/CanalPlusMobile',
    garSSOAuthUrl: 'https://preprod2.youscribe.com/authorize/GarAuthMobile',
    logoutGarUrl:
        'https://preprod2.youscribe.com/authorize/GarSsoOidcMobileLogout?accountid=userId',
    daysLeftBeforeBookExpiry: 7,
    editorialBaseImageUrl: 'http://cms.uscri.be',
    mainYSAPIUrl: 'https://services.youscribe.com',
    mobileAPIUrl: 'https://api-mobile.youscribe.com',
    privacyPolicyUrl: 'https://www.youscribe.com/Static?name=charte',
    secretKey:
        'QWPhUihq/zMePaqYXO4q1bfoB/Vx5d9SgHg2OXNI8scBVw+8vVtPQRBrRAmGvglW',
    supportEmail: 'user.support@youscribe.com',
    termsOfServiceUrl: 'https://www.youscribe.com/Static?name=cgu',
    userAgent: 'YouScribe.MobileApp',
    inAppPurchaseDefaultPrice: '9,99€',
    ysAuthHeaderKey: 'YS-AUTH',
    telemetryKey:
        'https://2d36630240b0dae30cc8d296b7d3f500@o4505917497212928.ingest.sentry.io/4505917508091904',
    personnalDataCharterGarUrl:
        'http://api-cms.youscribe.com/v1/staticcontent?name=chartegar&languageId=fr',
    legalNoticesGarUrl:
        'http://api-cms.youscribe.com/v1/staticcontent?name=termsgar&languageId=fr',
  );

  final client = Dio();
  final dataSource =
      AuthenticationRemoteDataSourceImpl(dio: client, appSettings: appSettings);
  final email = (args.isNotEmpty ? args.first : 'hugo@wyatt-studio.fr');

  final result = await dataSource.signUp(
    email,
    countryCode: 'fr',
    createSubscription: false,
  );
  if (kDebugMode) {
    print(result);
  }
}
