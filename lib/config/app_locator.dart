// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_settings.dart';
import 'package:youscribe/config/flavors.dart';
import 'package:youscribe/config/iap_connection.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/helpers/dio_logger.dart';
import 'package:youscribe/core/use_cases/use_case_locator_helper.dart';
import 'package:youscribe/data/data_locator_helper.dart';
import 'package:youscribe/infrastructure/infrastructure_locator_helper.dart';
import 'package:youscribe/infrastructure/readers/audio_reader_monitor.dart';
import 'package:youscribe/infrastructure/service/reader_stats_service.dart';
import 'package:youscribe/styles/youscribe_theme.dart';
import 'package:youscribe/utilities/ys_timer.dart';

final locator = GetIt.instance;
final currentFlavor = F.appFlavor;
final rateMyApp = RateMyApp(
  preferencesPrefix: 'rateYouscribe',
  minDays: 7,
  minLaunches: 10,
  remindDays: 7,
  remindLaunches: 10,
  googlePlayIdentifier: 'youscribe.mobileapp',
  appStoreIdentifier: 'com.youscribe.youscribe.app',
);
final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
void setup(Flavor flavor) {
  if (flavor == Flavor.youscribedev) {
  } else if (flavor == Flavor.maktabatidev) {}
}

Future<void> _initCommon(GetIt locator) async {
  // Inject Utils
  locator
    ..registerLazySingleton<Workmanager>(Workmanager.new)
    ..registerLazySingleton<ReceivePort>(ReceivePort.new)
    ..registerLazySingleton<IAPConnection>(IAPConnection.new)
    ..registerLazySingleton<RxSharedPreferences>(
        RxSharedPreferences.getInstance)
    // Inject Clients
    ..registerLazySingleton<Dio>(() {
      return Dio()..interceptors.add(DioLogger());
    })
    ..registerLazySingleton(YouScribeTheme.new)
    ..registerLazySingleton(YsTimer.new)

    // Inject Infrastructure Services
    ..registerInfrastructureServices()

    // Inject Repositories
    ..registerRepositories()

    // Inject Datasources
    ..registerDataSources()

    // Inject Usecases
    ..registerUseCases()
    // Inject Others...
    ..registerLazySingleton<AuthenticationManager>(
      () => AuthenticationManager(
        loginUseCase: locator(),
        loginWithCanalPlusUseCase: locator(),
        logoutUseCase: locator(),
        signUpUseCase: locator(),
        loginWithFacebookUseCase: locator(),
        loginWithAppleUseCase: locator(),
        loginWithGARUseCase: locator(),
        logoutFromGARUseCase: locator(),
        onAuthenticationStatusChangeUseCase: locator(),
        stusecase: locator(),
      ),
    )
    ..registerLazySingleton<AudioPlayer>(AudioPlayer.new)
    ..registerLazySingleton<AudioReaderMonitor>(AudioReaderMonitorImpl.new)
    ..registerLazySingleton<ReaderStatsService>(ReaderStatsService.new);
}

Future<void> configureApp(Flavor flavor, GetIt? workerLocator) async {
  if (flavor == Flavor.youscribedev) {
    final AppSettings appSettings = AppSettings(
      appName: F.title,
      apiStreamingURL: 'https://api-streaming.youscribe.com/v2/products/',
      appBrand: AppBrand.youScribe,
      appleAuthEndpoint: '/v1/accounts/apple',
      applicationId: 8,
      canalPlusAuthUrl:
          'https://pass.canal-plus.com/provider-IdPOAuth2/auth/YouScribe?client_id=youscribe&redirect_uri={0}&response_type=code&scope=scope1 scope2 offline_access',
      canalPlusYsRedirectUrl:
          'https://www.youscribe.com/authorize/CanalPlusMobile',
      daysLeftBeforeBookExpiry: 7,
      garSSOAuthUrl: 'https://preprod2.youscribe.com/authorize/GarAuthMobile',
      logoutGarUrl:
          'https://preprod2.youscribe.com/authorize/GarSsoOidcMobileLogout?accountid=userId',
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

    if (Platform.isAndroid) {
      appSettings
        ..inAppPurchaseSubscriptionId = 'youscribe.mobileapp.sub.week'
        ..pdfLicenseKey =
            'i_-WbHpW516GiOI-mjbUqTaaawwFIwC4kuINMePSJcqwMwd4QD-4tHlT1_tZs-QdRMDlt42Vf9syzO_BIFNlrNliI2aVlA8_TdSRnQfRzVHKNd4Vq29zYKY2P0ivP7Tr92m9cyo0UnB6TNmK5SqC4-TPH9km8YsmRES2EsK6_qxzb1E9kLaNkOBH0S-GdivcZwRLvbgrPXliLbS9iNRUiDUqEFE5xkPOP_wqC9xpGRsYHVDh3dCqhP2QNW5jeJqh4lFqpTWx_JCv2OKwZsKlnh9zOhzHYVYpte6OwJGgoBHu_UlBt2hPic2oTnnTfnixhh6v19rcBFcH16_JXdKTRbsyi8X_UdU1MvXX2NKkvO2qagTBXiLo95y0m84PwQ2csx6rW1ZSO3MsZ7IQFKKqXOSGl0XH1Wn2_9aiPPNPi1UsDjh5VnmqYFhf-2w7_iErZasP4_D1oJ8fNwlBardX_412btf1ySk6XEkyOEtMh7SWbjtz9DeAWL2UYXYIdLAaOFzPVgJe676bxMbYSXhCPjU20s4IfDII6fNJrWePruaL60fJmhtDzGnEnUHlXwH29ZkW392I2jITINje1Xle0p5TLzvHEZLIGSsYIV9vDJQ=';
    } else if (Platform.isIOS) {
      appSettings
        ..inAppPurchaseSubscriptionId =
            'catalogsubscriptions.normal.offer.monthly'
        ..pdfLicenseKey =
            'mmN6nht/gJsYYv5RcCggrkj1AZ+Mb0PSZHfn9TNwEa7dxnQQp3Y604KVDnX6ye27jxDp9Kw60+7Vcpqy63iv85UuuMVBOJ81eH6RwcSqckVV9N3d369GCKTtGssdNcZ5XCcDtvjjGftaukhW0I1OABmC+FrDwwC2bEC8z1D4WYwyaklYXQOB7QttVz7ob83shHzM7fzEIlfrwo4vC3vS9R402ekjJswdmKDVTigYNBqed6ofK/1hgRv3yYLDwomd/t4JPSLMTwnd7Mv+7/WynFgJwLjongUJ6cA+ZWRgD/B5v6n8RuNZkHqEqK+rlvtdq+w0rQqNbuc6YGsF2+L2f4yDHCPHIWnPu1QBBhqzPDUfhn7PYEEOsIn1buPKv2WBOBBhTSpfHp1of3DAmxUPgnULvvTC+ipOlfwoiscEP8k6ErF+U6Dvh3YxRQvNDiBmIu/dZKBC5qVF/ag7o+l9ASdeICW/So51kc9/7m1ars0D6r4icxkt32qC0Mvy2EYTTgFnoAYUUSxVZFEcMZVQNTVXhsbQ+YXzJgkhseaHpLlEBhLS0CyXXvuS2Wn03LJyG8kq8UyJsPAy/quHMJYNuomNMQTZ900XwF3j8MMydmU=';
    }

    locator.registerSingleton<AppSettings>(appSettings);
  } else if (flavor == Flavor.maktabatidev) {
    final AppSettings appSettings = AppSettings(
      appName: F.title,
      apiStreamingURL: 'https://api-streaming.maktabati.ma/v2/products/',
      appBrand: AppBrand.maktabati,
      applicationId: 8,
      daysLeftBeforeBookExpiry: 7,
      editorialBaseImageUrl: 'http://cms.uscri.be',
      mainYSAPIUrl: 'https://api.maktabati.ma',
      mobileAPIUrl: 'https://api-mobile.maktabati.ma',
      privacyPolicyUrl: 'https://maktabati.ma/cgu',
      secretKey:
          'QWPhUihq/zMePaqYXO4q1bfoB/Vx5d9SgHg2OXNI8scBVw+8vVtPQRBrRAmGvglW',
      supportEmail: 'serviceclient@maktabati.ma',
      termsOfServiceUrl: 'https://maktabati.ma/cgu',
      userAgent: 'YouScribe.MobileApp',
      ysAuthHeaderKey: 'YS-AUTH',
      appleAuthEndpoint: '',
      canalPlusAuthUrl: '',
      garSSOAuthUrl: '',
      logoutGarUrl: '',
      canalPlusYsRedirectUrl: '',
      inAppPurchaseDefaultPrice: '',
      faqUrl: 'https://maktabati.ma/faq',
      telemetryKey: '',
      personnalDataCharterGarUrl: '',
      legalNoticesGarUrl: '',
    );

    if (Platform.isAndroid) {
      appSettings
        ..inAppPurchaseSubscriptionId = 'youscribe.mobileapp.sub.week'
        ..pdfLicenseKey =
            'i_-WbHpW516GiOI-mjbUqTaaawwFIwC4kuINMePSJcqwMwd4QD-4tHlT1_tZs-QdRMDlt42Vf9syzO_BIFNlrNliI2aVlA8_TdSRnQfRzVHKNd4Vq29zYKY2P0ivP7Tr92m9cyo0UnB6TNmK5SqC4-TPH9km8YsmRES2EsK6_qxzb1E9kLaNkOBH0S-GdivcZwRLvbgrPXliLbS9iNRUiDUqEFE5xkPOP_wqC9xpGRsYHVDh3dCqhP2QNW5jeJqh4lFqpTWx_JCv2OKwZsKlnh9zOhzHYVYpte6OwJGgoBHu_UlBt2hPic2oTnnTfnixhh6v19rcBFcH16_JXdKTRbsyi8X_UdU1MvXX2NKkvO2qagTBXiLo95y0m84PwQ2csx6rW1ZSO3MsZ7IQFKKqXOSGl0XH1Wn2_9aiPPNPi1UsDjh5VnmqYFhf-2w7_iErZasP4_D1oJ8fNwlBardX_412btf1ySk6XEkyOEtMh7SWbjtz9DeAWL2UYXYIdLAaOFzPVgJe676bxMbYSXhCPjU20s4IfDII6fNJrWePruaL60fJmhtDzGnEnUHlXwH29ZkW392I2jITINje1Xle0p5TLzvHEZLIGSsYIV9vDJQ=';
    } else if (Platform.isIOS) {
      appSettings
        ..inAppPurchaseSubscriptionId =
            'catalogsubscriptions.normal.offer.monthly'
        ..pdfLicenseKey =
            'mmN6nht/gJsYYv5RcCggrkj1AZ+Mb0PSZHfn9TNwEa7dxnQQp3Y604KVDnX6ye27jxDp9Kw60+7Vcpqy63iv85UuuMVBOJ81eH6RwcSqckVV9N3d369GCKTtGssdNcZ5XCcDtvjjGftaukhW0I1OABmC+FrDwwC2bEC8z1D4WYwyaklYXQOB7QttVz7ob83shHzM7fzEIlfrwo4vC3vS9R402ekjJswdmKDVTigYNBqed6ofK/1hgRv3yYLDwomd/t4JPSLMTwnd7Mv+7/WynFgJwLjongUJ6cA+ZWRgD/B5v6n8RuNZkHqEqK+rlvtdq+w0rQqNbuc6YGsF2+L2f4yDHCPHIWnPu1QBBhqzPDUfhn7PYEEOsIn1buPKv2WBOBBhTSpfHp1of3DAmxUPgnULvvTC+ipOlfwoiscEP8k6ErF+U6Dvh3YxRQvNDiBmIu/dZKBC5qVF/ag7o+l9ASdeICW/So51kc9/7m1ars0D6r4icxkt32qC0Mvy2EYTTgFnoAYUUSxVZFEcMZVQNTVXhsbQ+YXzJgkhseaHpLlEBhLS0CyXXvuS2Wn03LJyG8kq8UyJsPAy/quHMJYNuomNMQTZ900XwF3j8MMydmU=';
    }

    workerLocator.isNull
        ? locator.registerSingleton<AppSettings>(appSettings)
        : workerLocator?.registerSingleton<AppSettings>(appSettings);
  }
  await _initCommon(workerLocator ?? locator);
  workerLocator.isNotNull
      ? await workerLocator?.allReady()
      : await locator.allReady();
}
