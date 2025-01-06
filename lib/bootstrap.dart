import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:workmanager/workmanager.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/app_settings.dart';
import 'package:youscribe/config/flavors.dart';
import 'package:youscribe/data/data_locator_helper.dart';
import 'package:youscribe/firebase_options.dart';
import 'package:youscribe/infrastructure/background_service/background_service_manager.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe_analytics/youscribe_analytics.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  return runZonedGuarded(() async {
    await configureApp(F.appFlavor!, null);

    WidgetsFlutterBinding.ensureInitialized();

    // Setup database here, because getting the db path needs flutter
    // to be initialized
    await locator.setupDatabase();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    setup(F.appFlavor!);

    await locator<Workmanager>().initialize(
      callbackDispatcher,
      isInDebugMode: kDebugMode,
    );

    await FlutterDownloader.initialize(debug: kDebugMode, ignoreSsl: true);

    /// Initialize the logger
    await Logger.init(
      LoggerConfig(
        sentryDsn: locator.get<AppSettings>().telemetryKey,
        environment: F.environment,
        clearLogIntervalMs:
            locator.get<AppSettings>().logIntervalInMiliSeconds.toInt(),
      ),
    );

    /// Initialize the analytics tracker
    await AnalyticsTracker.init();

    await _initAudioNotification();

    await rateMyApp.init();

    runApp(await builder());
  }, (exception, stackTrace) async {
    if (Logger.isInitialized) {
      await Logger.instance.handleException(exception, stackTrace: stackTrace);
    } else {
      if (kDebugMode) {
        print('Error: $exception');
        print('Stacktrace: $stackTrace');
      }
    }
  });
}

Future<void> _initAudioNotification() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: androidNotificationChannelId,
    androidNotificationChannelName: androidNotificationChannelName,
    androidNotificationOngoing: true,
    androidNotificationIcon: 'mipmap/ic_notif',
  );
}
