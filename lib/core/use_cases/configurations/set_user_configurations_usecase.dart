import 'dart:async';

import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class SetUserConfigurationsUseCase
    extends AsyncUseCase<SetUserConfigurationsUseCaseParams, bool>
    with Debuggable, Loggable {
  SetUserConfigurationsUseCase(this.repository);
  final UserAccountRepository repository;

  @override
  String get debugName => 'SetUserConfigurationsUseCase';

  @override
  FutureOr<void> onStart(SetUserConfigurationsUseCaseParams? params) {
    if (params == null) {
      throw Exception('You must provide a UserConfigurationParams');
    }
  }

  @override
  FutureOrResult<bool> execute(
      SetUserConfigurationsUseCaseParams? params) async {
    try {
      if (params!.theme != null) {
        await repository.setTheme(params.theme!);
      }
      if (params.languageCode != null) {
        await repository.setPreferredLanguageCode(
            params.languageCode ?? '', params.countryCode ?? '');
      }
      if (params.displayHelpHint != null) {
        await repository
            .setDontDisplaySwipeProductsListHelp(params.displayHelpHint!);
      }
      if (params.firebaseToken != null) {
        await repository.setFirebaseToken(params.firebaseToken!);
      }

      return const Ok(true);
    } catch (e) {
      logError(
        "Fatal error while updating user settings",
        error: Exception(e),
      );
      rethrow;
    }
  }
}

class SetUserConfigurationsUseCaseParams {
  SetUserConfigurationsUseCaseParams({
    this.languageCode,
    this.firebaseToken,
    this.countryCode,
    this.theme,
    this.displayHelpHint,
  });
  final String? languageCode;
  final String? countryCode;
  final String? firebaseToken;
  ThemeType? theme;
  bool? displayHelpHint;
}
