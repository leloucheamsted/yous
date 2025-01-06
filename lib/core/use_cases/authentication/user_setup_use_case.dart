import 'dart:async';

import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe/core/use_cases/configurations/get_country_configuration_use_case.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

///Responsible for setting and initializing values specific to the user,
///so that the app works properly.
///EG: - Set classifications, - Set App open count...
class UserSetupUseCase extends AsyncUseCase<UserSetupUseCaseParams, bool>
    with Debuggable, Loggable {
  final ConnectivityService _connectivityService =
      locator<ConnectivityService>();
  final UserAccountRepository _userAccountRepository =
      locator<UserAccountRepository>();
  late final GetCountryConfigurationUseCase _getCountryConfigurationUseCase =
      locator();

  @override
  String get debugName => 'UserSetupUseCase';

  @override
  FutureOrResult<bool> execute(UserSetupUseCaseParams? params) async {
    logInfo("UserSetupUseCase: execute");
    if (params!.isAuthenticated) {
      await _userAccountRepository.incrementAppOpenedCount();

      if (await _connectivityService.isInternetAvailable) {
        await _userAccountRepository
            .setLastTimeConnectedToInternet(DateTime.now());

        final countryConfig = await _getCountryConfigurationUseCase(
            GetCountryConfigurationUseCaseParams());
        if (countryConfig.isErr) {
          logError(
            "Error while getting country config from API.",
            error: countryConfig.err,
          );
        } else if (countryConfig.ok != null) {
          await _userAccountRepository.setCountryConfig(countryConfig.ok!);
        }

        final result = await _userAccountRepository
            .getClassificationSettingsForCurrentUser();

        if (Auth.currentSession()?.currentUserAccountEntity != null) {
          Auth.currentSession()!
              .currentUserAccountEntity!
              .classificationTreeId = result.classificationTreeId;
        }
      }
    }

    return const Ok(true);
  }

  @override
  FutureOr<void> onStart(UserSetupUseCaseParams? params) {
    if (params == null) {
      throw ArgumentError.notNull('params');
    }
  }
}

class UserSetupUseCaseParams {
  const UserSetupUseCaseParams({
    required this.isAuthenticated,
  });

  final bool isAuthenticated;
}
