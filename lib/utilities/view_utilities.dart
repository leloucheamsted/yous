import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youscribe/core/use_cases/products/check_product_access_rights_use_case.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';

extension ViewUtilities on BuildContext {
  Future<void> handleReadRights(
      ProductAccessState canReadResult, String bookPublishDate) async {
    final context = this;

    if (canReadResult == ProductAccessState.internetNeeded) {
      if (context.mounted) {
        await Dialogs.displayInternetNeededAlert(context: context);
        return;
      }
    } else if (canReadResult == ProductAccessState.lackRights) {
      await Dialogs.displayCustomAlert(
          context: context,
          isOneButton: true,
          content: AppLocalizations.of(context)!.subscriptionRequired);
    } else if (canReadResult == ProductAccessState.lackRightsForPremium) {
      //TODO: Handle premium subscriptions
    } else if (canReadResult == ProductAccessState.lackRightsButIsSubscriber) {
      await Dialogs.displayCustomAlert(
          context: context,
          isOneButton: true,
          content: AppLocalizations.of(context)!.cantAccessProduct);
    } else if (canReadResult == ProductAccessState.notPublished) {
      await Dialogs.displayCustomAlert(
          title: AppLocalizations.of(context)!.cantAccessProduct,
          context: context,
          isOneButton: true,
          content:
              AppLocalizations.of(context)!.bookToBePublished(bookPublishDate));
    } else if (canReadResult == ProductAccessState.isDownloading) {
      await Dialogs.displayCustomAlert(
          context: context,
          isOneButton: true,
          content: AppLocalizations.of(context)!.downloadingGuardMessage);
    }
  }
}

extension DoubleHelper on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

extension DateTimeExtensions on DateTime {
  int get totalSeconds => millisecondsSinceEpoch ~/ 1000;
}

extension StreamControllerHelper<T> on StreamController<T> {
  void addWithCheck(T val) {
    if (!isClosed) {
      sink.add(val);
    }
  }
}

Future<String?> getDeviceId() async {
  final deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    final iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor;
  } else if (Platform.isAndroid) {
    final androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.id;
  }

  return '';
}

// cobranding

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }
}

// flutter_local_notifications: ^17.0.0
// void showNotification(RemoteMessage message) {
//   const channel = AndroidNotificationChannel(
//       androidNotificationChannelId, androidNotificationChannelName,
//       description: androidNotificationChannelDescription,
//       importance: Importance.high);

//   final details = AndroidNotificationDetails(channel.id, channel.name,
//       channelDescription: channel.description, icon: '@mipmap/ic_notif');

//   FlutterLocalNotificationsPlugin().show(
//       message.hashCode,
//       message.notification?.title ?? "",
//       message.notification?.body ?? "",
//       NotificationDetails(android: details));
// }
