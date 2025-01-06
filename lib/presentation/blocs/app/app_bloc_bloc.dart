// ignore: depend_on_referenced_packages
import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:pspdfkit_flutter/pspdfkit.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/app_settings.dart';
import 'package:youscribe/core/use_cases/configurations/get_user_settings_use_case.dart';
import 'package:youscribe/core/use_cases/configurations/send_init_data_usecase.dart';
import 'package:youscribe/core/use_cases/configurations/set_user_configurations_usecase.dart';
import 'package:youscribe/core/use_cases/downloads/download_product_usecase.dart';
import 'package:youscribe/utilities/view_utilities.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'app_bloc_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> with Debuggable, Loggable {
  AppBloc() : super(AppInitialState()) {
    on<SetAppLanguageEvent>(_onSetAppLanguage);
    on<SetShowAppBarEvent>(_onShowAppBar);
    on<InitAppEvent>(_onInitApp);
    on<SendAppConfigEvent>(_onSendAppConfigToServer);
  }

  final SendInitDataUseCase _sendInitDataUseCase = locator();
  final GetUserSettingsUseCase _getUserConfigurationsUseCase = locator();
  final SetUserConfigurationsUseCase _setUserConfigurationsUseCase = locator();
  final DownloadProductUseCase _downloadProductUseCase = locator();

  final AppSettings _appSettings = locator();
  late StreamSubscription<String> _firebaseStreamSubscription;

  @override
  String get debugName => 'AppBloc';

  Future<void> _onInitApp(InitAppEvent event, Emitter<AppState> emit) async {
    try {
      final isSuccess = IsolateNameServer.registerPortWithName(
          locator<ReceivePort>().sendPort, 'downloader_send_port');
      if (!isSuccess) {
        IsolateNameServer.removePortNameMapping('downloader_send_port');
        IsolateNameServer.registerPortWithName(
            locator<ReceivePort>().sendPort, 'downloader_send_port');
      }
      _downloadProductUseCase.listenToDownloadStates();

      await FlutterDownloader.registerCallback(downloadCallback, step: 1);

      final settingsResult = await _getUserConfigurationsUseCase(null);
      if (settingsResult.isErr) {
        logError("Error initializing app:", error: settingsResult.err);
        emit(AppLanguageSetState('', ''));
        return;
      }

      emit(AppLanguageSetState(settingsResult.ok!.preferredLanguageCode,
          settingsResult.ok!.preferredCountryCode));
      await _initPsPDFKit();
    } catch (e) {
      logError("Error initializing app:", error: e as Exception);
    }
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    int status,
    int progress,
  ) {
    if (kDebugMode) {
      print(
        'Callback on background isolate: '
        'task ($id) is in status ($status) and process ($progress)',
      );
    }

    IsolateNameServer.lookupPortByName('downloader_send_port')
        ?.send([id, status, progress]);
  }

  Future<void> _initPsPDFKit() async {
    try {
      await Pspdfkit.setLicenseKeys(
          //Android
          // ignore: lines_longer_than_80_chars
          _appSettings.pdfLicenseKey,
          //iOS
          _appSettings.pdfLicenseKey);
    } catch (e) {
      logError("Fatal error while activating pspdfkit", error: Exception(e));
    }
  }

  Future<void> _onShowAppBar(
      SetShowAppBarEvent event, Emitter<AppState> emit) async {
    emit(AppBarSetState(event.showAppBar));
  }

  Future<void> _onSetAppLanguage(
      SetAppLanguageEvent event, Emitter<AppState> emit) async {
    emit(AppLanguageSetState(event.languageCode, event.countryCode));
  }

  Future<void> _firebaseTokenRefreshed(String token) {
    return _sendAppConfigDataToServer(token);
  }

  Future<void> _sendAppConfigDataToServer(String token,
      {String countryCode = '',
      String languageCode = '',
      String deviceId = ''}) async {
    try {
      String lang = '';
      String country = '';
      final settingsResult = await _getUserConfigurationsUseCase(null);

      if (settingsResult.isOk) {
        lang = settingsResult.ok!.preferredLanguageCode.isEmpty
            ? languageCode
            : settingsResult.ok!.preferredLanguageCode;
        country = settingsResult.ok!.preferredCountryCode.isEmpty
            ? countryCode
            : settingsResult.ok!.preferredCountryCode;
      } else {
        lang = languageCode;
        country = countryCode;
      }

      await _sendInitDataUseCase(SendInitDataUseCaseParameters(
        firebaseToken: token,
        languageCode: lang,
        countryCode: country,
        deviceIdentifier: deviceId,
      ));

      await _setUserConfigurationsUseCase(SetUserConfigurationsUseCaseParams(
          countryCode: country, languageCode: lang, firebaseToken: token));
    } catch (e) {
      logError("Error sending app configs to server:", error: e as Exception);
    }
  }

  Future<void> _onSendAppConfigToServer(
      SendAppConfigEvent event, Emitter<AppState> emit) async {
    String token = '';
    String? deviceId = '';

    final settings = await FirebaseMessaging.instance.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      token = await FirebaseMessaging.instance.getToken() ?? '';
      _firebaseStreamSubscription = FirebaseMessaging.instance.onTokenRefresh
          .listen(_firebaseTokenRefreshed);
    }

    if (event.deviceId.isNullOrEmpty) {
      deviceId = await getDeviceId();
    }

    await _sendAppConfigDataToServer(token,
        countryCode: event.countryCode,
        languageCode: event.languageCode,
        deviceId: deviceId ?? event.deviceId);
  }

  @override
  Future<void> close() {
    _downloadProductUseCase.dispose();
    _firebaseStreamSubscription.cancel();
    return super.close();
  }
}
