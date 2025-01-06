import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/app_settings.dart';
import 'package:youscribe/core/infrastructure/service.dart';
import 'package:youscribe/core/use_cases/configurations/get_user_settings_use_case.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe_analytics/youscribe_analytics.dart';

class ServiceImpl extends Service {
  ServiceImpl();

  @override
  Future<bool> showErrorMessageAndRequestReport(
      {required String title,
      required String message,
      required String supportEmailHeader}) async {
    final appSettings = locator<AppSettings>();

    try {
      final runtimePlatform = Platform.isAndroid ? 'Android' : 'iOS';
      String osVersion = "";
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final appVersion = packageInfo.version;
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        osVersion = androidInfo.version.release;
      }
      if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        osVersion = iosInfo.systemVersion;
      }
      final clientInfo =
          // ignore: lines_longer_than_80_chars
          "Error REPORT $supportEmailHeader OS: $runtimePlatform, AppVersion: $appVersion, OSVersion: $osVersion";
      final path = await logger.logFilePath;
      final file = File(path);
      final Email sendEmail = Email(
        subject: clientInfo,
        recipients: [appSettings.supportEmail],
        attachmentPaths: [file.path],
      );
      await FlutterEmailSender.send(sendEmail);
      return true;
    } catch (e) {
      logError("Error occured while mailing to Youscribe.",
          error: Exception(e));
    }

    try {
      final clientInfo = "Error REPORT $supportEmailHeader";
      final Email sendEmail = Email(
        subject: clientInfo,
        recipients: [appSettings.supportEmail],
      );
      await FlutterEmailSender.send(sendEmail);
      return true;
    } catch (e) {
      logError("Error occured while mailing to Youscribe.",
          error: Exception(e));
    }
    return false;
  }

  @override
  Future<bool> requestAppRating(bool byPassOpenCount) async {
    final SharedPreferences pref = await prefs;
    final bool isGARUserConnected =
        pref.getBool(PreferenceKey.isGarUserConnected) ?? false;
    if (isGARUserConnected) {
      return false;
    }
    final GetUserSettingsUseCase getUserSettingsUseCase = locator();

    try {
      final responseUserSettings = await getUserSettingsUseCase(null);
      final usersettings = responseUserSettings.ok;
      if ((usersettings?.appOpenedCount != 0 &&
              usersettings!.appOpenedCount % 10 == 0) ||
          byPassOpenCount) {
        await tracker.trackRatingRequestInitiated();

        logInfo("Ratings request alert triggered");
        return true;
      }
    } catch (e) {
      logError("Error while performing app ratings", error: Exception(e));
    }
    return false;
  }
}
