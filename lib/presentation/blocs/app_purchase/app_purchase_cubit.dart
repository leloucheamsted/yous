import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/app_settings.dart';
import 'package:youscribe/config/flavors.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/country_configuration_entity.dart';
import 'package:youscribe/core/entities/user_global_settings_entity.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/infrastructure/in_app_purchase_service.dart';
import 'package:youscribe/core/infrastructure/service.dart';
import 'package:youscribe/core/repositories/country_config_repository.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe/core/use_cases/configurations/get_user_settings_use_case.dart';
import 'package:youscribe_analytics/youscribe_analytics.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'app_purchase_state.dart';

class AppPurchaseCubit extends Cubit<AppPurchaseState>
    with Debuggable, Loggable, Trackable {
  AppPurchaseCubit() : super(AppPurchaseInitialState());
  late final ConnectivityService _connectivityService = locator();
  late final GetUserSettingsUseCase _getUserSettingsUseCase = locator();
  final CountryConfigRepository _countryConfigRepository =
      locator<CountryConfigRepository>();
  final UserAccountRepository _userAccountRepository =
      locator<UserAccountRepository>();
  final AppSettings appSettings = locator();
  final InAppPurchaseService _inAppPurchaseService = locator();
  final Service service = locator();
  String _price = "";

  @override
  String get debugName => 'AppPurchaseCubit';

  Future<void> callSubscriptionPopup(bool isTokenScreen) async {
    try {
      logInfo("Starting in app purchase scenario.");
      if (Platform.isIOS) {
        if (currentFlavor == Flavor.maktabatidev) {
          emit(ShowMaktabatiPurchaseState());
          return;
        }

        logInfo("Starting in app purchase popup.");
        await tracker.trackInAppPurchaseInitiated();
        logInfo("Getting product price.");
        _price = await _inAppPurchaseService.getProductPrice();
        emit(ShowInAppPurchasePopupState(price: _price));
        return;
      } else {
        await tracker.trackInAppPurchaseInitiated();

        if (!await _connectivityService.isInternetAvailable) {
          await tracker.trackInAppPurchaseCanceled();
          emit(InternetErrorPurchaseState());

          return;
        } else {
          final isInappPurchaseAllowed = await isAnAppPurchaseAllowd();
          if (Platform.isAndroid && isInappPurchaseAllowed.$1) {
            final model = isInappPurchaseAllowed.$2;
            try {
              if (model != null) {
                emit(ShowSmsPurchaseState(model));
                return;
              }
            } catch (e) {
              logError("Error occured while calling subscription initiation.",
                  error: Exception(e));
              emit(UnknowExceptionErrorState());
            }
          } else {
            logInfo("Starting in app purchase native control.");
            final result = await _inAppPurchaseService.subscribe();
            if (!result) {
              await tracker.trackInAppPurchaseFailed();

              return;
            }
            logInfo("In app purchase succeded ? $result");
            logInfo("Setting user as subscriber.");
            await setUserAsSubscriber(isTokenScreen);
            return;
          }
        }
      }
      return;
    } catch (e) {
      logError("Error occured while calling subscription initiation.",
          error: Exception(e));
      emit(UnknowExceptionErrorState());
    }
    return;
  }

  Future<void> redirectToSMSApp(String number, String text) async {
    final Uri sms = Uri.parse('sms:$number?body=$text');
    try {
      await launchUrl(sms);
    } catch (e) {
      logError("Error while redirecting to sms app.", error: Exception(e));
      emit(NoSMSAppErrorState());
    }
  }

  Future<void> setUserAsSubscriber(bool isTokenScreen) async {
    final userAccount = await AuthenticationManager.getCurrentUser();
    userAccount!.isSubscriber = true;
    await _userAccountRepository.saveUserAccount(userAccount);
    await tracker.trackInAppPurchaseSucceeded();
    emit(AppPurchaseCompleteState(isTokenScreen: isTokenScreen));
  }

  Future<(bool, CountryConfigPopupEntity?)> isAnAppPurchaseAllowd() async {
    final response = await _getUserSettingsUseCase(null);
    UserGlobalSettingsEntity? userSettings =
        response.ok ?? UserGlobalSettingsEntity(appOpenedCount: 0, localId: 0);
    if (response.ok.isNull || userSettings.countryConfiguration.isNotNull) {
      if (!await _connectivityService.isInternetAvailable) {
        userSettings = await loadUserCountryConfigs();
      }

      if (response.ok.isNull) {
        return (false, null);
      }
    }

    return (
      response.ok!.countryConfiguration != null &&
          response.ok!.countryConfiguration!.inAppPurchaseAllowed!,
      userSettings.countryConfiguration!.registerPopup,
    );
  }

  Future<UserGlobalSettingsEntity> loadUserCountryConfigs() async {
    logInfo('Loading country configurations from API.');
    final countryConfig =
        await _countryConfigRepository.getCountryConfiguration();

    logError('Caching country config', error: Exception());
    if (countryConfig != null) {
      await _userAccountRepository.setCountryConfig(countryConfig);
    }

    return UserGlobalSettingsEntity(
        countryConfiguration: countryConfig, appOpenedCount: 0, localId: null);
  }

  Future<void> maktabatiUrlPurchase() async {
    final Uri url = Uri.parse(appSettings.faqUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> cancelPurchase() async {
    await tracker.trackInAppPurchaseCanceled();
    emit(AppPurchaseInitialState());
  }

  Future<bool> startFreeTrial(bool isTokenScreen) async {
    emit(ShowInAppPurchasePopupState(price: _price).copyWith(isBusy: true));
    if (!await _connectivityService.isInternetAvailable) {
      await tracker.trackInAppPurchaseFailed();
      emit(InternetErrorPurchaseState());
      return false;
    }
    final purchaseSuccessful = await _inAppPurchaseService.subscribe();
    if (!purchaseSuccessful) {
      await tracker.trackInAppPurchaseFailed();
      emit(PurchaseErrorPurchaseState());
      return purchaseSuccessful;
    }
    emit(AppPurchaseCompleteState(isTokenScreen: isTokenScreen));
    return purchaseSuccessful;
  }

  Future<void> termsPrivacyPolicy() async {
    await _uRLTapped(appSettings.privacyPolicyUrl);
  }

  Future<void> termsOfServices() async {
    await _uRLTapped(appSettings.termsOfServiceUrl);
  }

  // reste state to init
  void resetState() {
    emit(AppPurchaseInitialState());
  }

  Future<void> _uRLTapped(String uri) async {
    try {
      final Uri url = Uri.parse(uri);
      if (!await launchUrl(url)) {
        emit(UnknowExceptionErrorState());
      }
    } catch (ex) {
      logError("Error occured while running url tapped.", error: Exception(ex));
      emit(UnknowExceptionErrorState());
    }
  }
}
