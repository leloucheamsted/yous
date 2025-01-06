import 'dart:io';

import 'package:dio/dio.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/use_cases/configurations/get_user_settings_use_case.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

mixin BaseAuthCubit on Loggable {
  Future<
          (
            bool isFacebookAllowed,
            bool isCanalplusAllowed,
            bool isAppleAllowed,
            bool isGarAllowed
          )>
      getAuthButtonsVisibility<T>(
          GetUserSettingsUseCase getUserSettingsUseCase) async {
    final result = await getUserSettingsUseCase(null);
    bool facebookAllowed = false;
    bool canalplusAllowed = false;
    bool appleAllowed = false;
    bool garAllowed = false;

    if (result.isErr) {
      logInfo("Getting user settings failed");
      return (false, false, false, false);
    }

    final settings = result.ok!;

    facebookAllowed = settings.countryConfiguration?.facebookAllowed ?? false;
    canalplusAllowed = settings.canalplusSettings?.allowed ?? false;
    appleAllowed = facebookAllowed && Platform.isIOS;
    garAllowed = settings.countryConfiguration?.garEnabled ?? false;
    return (facebookAllowed, canalplusAllowed, appleAllowed, garAllowed);
  }

  Future<bool> isInternetAvailable() async {
    final connectivity = locator<ConnectivityService>();
    return connectivity.isInternetAvailable;
  }
}
