// ignore_for_file: avoid_setters_without_getters

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/router/router.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/authentication/authentication_status.dart';
import 'package:youscribe/core/repositories/products_repository.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class YsTimer with Debuggable, Loggable {
  static const int inactiveSessionSpanInMinutes = kDebugMode ? 1 : 5;
  static const int inactiveSessionCheckSpanInDays = 1;
  static const int audioPlayerCheckSpanInMinutes = 1;
  static const int garSessionTimeoutInMinutes = 360;
  late DateTime _default;
  static const int itterations = 0;
  late int _audiobookIdInTimer;
  late int _minutesToStopTimer;
  late DateTime _timeToStopAudiobook = DateTime.now();
  int get audiobookIdInTimer => _audiobookIdInTimer;
  int get minutesToStopTimer => _minutesToStopTimer;
  DateTime get timeToStopAudiobook => _timeToStopAudiobook;
  set setAudiobookIdInTimer(int value) => _audiobookIdInTimer = value;
  set setMinutesToStopTimer(int value) => _minutesToStopTimer = value;
  set setTimeToStopAudiobook(DateTime value) => _timeToStopAudiobook = value;
  final ProductRepository _productRepository = locator<ProductRepository>();
  final UserAccountRepository userAccountRepository = locator();

  bool isInternetAvailable = false;

  @override
  String get debugName => 'YsTimer';

  void monitorAudioPlayer(int productId, int minutesToStop) {
    updateAudioPlayerTimerValues(productId, minutesToStop);
    Timer.periodic(Duration(minutes: minutesToStop), (timer) {
      timer.cancel();
      if (_timeToStopAudiobook == DateTime.now() || _audiobookIdInTimer == 0) {
        timer.cancel();
        return;
      }
      final hasTimeArrived = timeToStopAudiobook.isBefore(DateTime.now());
      if (hasTimeArrived) {
        // TODO: stop action audio player
        performAudioPlayerTimerStopActions();
      }
    });
  }

  void updateAudioPlayerTimerValues(int productId, int minutesToStop) {
    _timeToStopAudiobook = DateTime.now();
    setAudiobookIdInTimer = productId;
    setMinutesToStopTimer = minutesToStop;
    setTimeToStopAudiobook =
        timeToStopAudiobook.add(Duration(minutes: minutesToStop));
  }

  void performAudioPlayerTimerStopActions() {
    // TODO: implement void function to stop audio recoding
    //----------------------------------------------------------------
    // ----------------------------------------------------------------
    // locator<Workmanager>().registerOneOffTask(
    //   ServiceName.notification,
    //   ServiceName.notification,
    //   constraints: Constraints(networkType: NetworkType.not_required),
    // );
    final AudioPlayer player = locator();
    // ignore: cascade_invocations
    player.stop();
    stopMonitoringAudioPlayer();
  }

  void stopMonitoringAudioPlayer() {
    _audiobookIdInTimer = 0;
    _minutesToStopTimer = 0;
  }

  Future<void> monitorInActiveSessionReadOnStart() async {
    if (isInternetAvailable) {
      return;
    }
    final userSettings = await userAccountRepository.getUserSettings();
    if (userSettings.isNull) {
      return;
    }
    final lastInactiveSessionUserReadTriggerDate =
        userSettings.lastInactiveSessionUserReadTriggerDate ?? DateTime.now();
    const inactiveSessionCheckSpan =
        Duration(days: inactiveSessionCheckSpanInDays);
    if (DateTime.now().difference(lastInactiveSessionUserReadTriggerDate) >=
        inactiveSessionCheckSpan) {
      Timer.periodic(const Duration(minutes: inactiveSessionSpanInMinutes),
          (timer) async {
        timer.cancel();
        final result = await performSessionInactiveLogic();
        if (result) {
          // ignore: use_build_context_synchronously
          await AppRouter.navigatorKey.currentState!.context
              .pushNamed(Routes.recommandations);
        }

        return;
      });
    }

    return;
  }

  Future<bool> performSessionInactiveLogic() async {
    try {
      final authenticationStatus =
          locator<AuthenticationManager>().authenticationStatus;
      final lastMinuteReadBookCount = await _productRepository
          .readLastReadProductsCountSinceNMinutes(inactiveSessionSpanInMinutes);
      final hasUserReadABookAfterNMin = lastMinuteReadBookCount >= 1;
      final isUserAuthenticated =
          authenticationStatus == AuthenticationStatus.authenticated;
      logInfo("""
### InactiveSessionApsn:$inactiveSessionSpanInMinutes, LastReadCount Since that time: $lastMinuteReadBookCount, """
          "isUserAuth: $isUserAuthenticated");

      if (!hasUserReadABookAfterNMin && isUserAuthenticated) {
        final userSettings = await userAccountRepository.getUserSettings();
        userSettings.lastInactiveSessionUserReadTriggerDate = DateTime.now();
        await userAccountRepository.saveUserSettings(userSettings);
        await userAccountRepository.setLastInactiveSessionUserReadTriggerDate();
        return true;
      }
      return false;
    } catch (e) {
      logError('Big error occured while performing inactive session logic: $e',
          error: Exception(e));
      rethrow;
    }
  }

  Future<void> logoutGARUser() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final SharedPreferences _prefs = await prefs;
    final lastLogin = DateTime.parse(_prefs.getString('lastlLogin')!);
    final lastLoginDiff = DateTime.now().difference(lastLogin).inMinutes;
    Timer.periodic(
        Duration(minutes: garSessionTimeoutInMinutes - lastLoginDiff),
        (timer) async {
      timer.cancel();
      await _prefs.setString(
          PreferenceKey.lastLogout, DateTime.now().toString());
      await _prefs.setBool(PreferenceKey.isGarUserConnected, false);
      final auth = locator<AuthenticationManager>();
      await auth.logOutWithGAR();
      return;
    });
  }
}
