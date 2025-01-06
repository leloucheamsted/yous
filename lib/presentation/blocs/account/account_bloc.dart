// ignore_for_file: lines_longer_than_80_chars

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/use_cases/configurations/get_user_settings_use_case.dart';
import 'package:youscribe/core/use_cases/configurations/set_user_configurations_usecase.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState>
    with Debuggable, Loggable {
  AccountBloc() : super(const AccountState()) {
    on<InitAccountEvent>(_onInit);
    on<SetAccountLanguageEvent>(_onSetAccountLanguage);
    on<SetAccountThemeEvent>(_onSetAccountTheme);
    on<SetAccountDisplayHelpHintEvent>(_onSetAccountDisplayHelpHint);
  }

  final GetUserSettingsUseCase _getUserConfigurationsUseCase = locator();
  final SetUserConfigurationsUseCase _setUserConfigurationsUseCase = locator();
  final RxSharedPreferences rxPrefs = locator();

  @override
  String get debugName => 'AccountBloc';

  Future<void> _onInit(
      InitAccountEvent event, Emitter<AccountState> emit) async {
    final settingsResult = await _getUserConfigurationsUseCase(null);

    if (settingsResult.isErr) {
      logError(
        "Error initializing app:",
        error: settingsResult.err,
      );
      emit(
        state.copyWith(
          theme: ThemeType.system,
          language: '',
          countryCode: '',
          stopHelpHint: false,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        theme: settingsResult.ok!.theme,
        language: settingsResult.ok!.preferredLanguageCode,
        countryCode: settingsResult.ok!.preferredCountryCode,
        stopHelpHint: settingsResult.ok!.dontDisplaySwipeProductsListHelp,
      ),
    );
  }

  Future<void> _onSetAccountDisplayHelpHint(
      SetAccountDisplayHelpHintEvent event, Emitter<AccountState> emit) async {
    final result =
        await _setUserConfigurationsUseCase(SetUserConfigurationsUseCaseParams(
      displayHelpHint: event.display,
    ));

    if (result.isErr) {
      logError("Error setting account display help hint:", error: result.err);
      return;
    }

    emit(state.copyWith(stopHelpHint: event.display));
  }

  Future<void> _onSetAccountTheme(
      SetAccountThemeEvent event, Emitter<AccountState> emit) async {
    final result =
        await _setUserConfigurationsUseCase(SetUserConfigurationsUseCaseParams(
      theme: event.theme,
    ));

    if (result.isErr) {
      logError("Error setting account theme:", error: result.err);
      return;
    }

    emit(
      state.copyWith(theme: event.theme),
    );
  }

  Future<void> _onSetAccountLanguage(
      SetAccountLanguageEvent event, Emitter<AccountState> emit) async {
    final result = await _setUserConfigurationsUseCase(
        SetUserConfigurationsUseCaseParams(
            languageCode: event.languageCode, countryCode: event.countryCode));

    if (result.isErr) {
      logError("Error setting account language:", error: result.err);
      return;
    }

    if (event.languageCode.isEmpty) {
      emit(
        state.copyWith(
          language: '',
          countryCode: '',
        ),
      );
    } else {
      emit(
        state.copyWith(
          language: event.languageCode,
          countryCode: event.countryCode,
        ),
      );
    }
    await rxPrefs.setBool(PreferenceKey.libraryIsReloaded, true);
  }
}
