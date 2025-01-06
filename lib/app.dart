// import 'package:background_downloader/background_downloader.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/app_provider.dart';
import 'package:youscribe/config/router/router.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/helpers/app_state_helpers/app_state_manager.dart';
import 'package:youscribe/core/helpers/app_state_helpers/app_states.dart';
import 'package:youscribe/core/use_cases/configurations/get_user_settings_use_case.dart';
import 'package:youscribe/core/use_cases/configurations/set_user_configurations_usecase.dart';
import 'package:youscribe/core/use_cases/products/check_product_access_rights_use_case.dart';
import 'package:youscribe/presentation/blocs/account/account_bloc.dart';
import 'package:youscribe/presentation/blocs/app/app_bloc_bloc.dart';
import 'package:youscribe/presentation/blocs/app_loading/app_loading_bloc.dart';
import 'package:youscribe/presentation/blocs/app_shell/app_shell_bloc.dart';
import 'package:youscribe/presentation/blocs/auth/welcome/welcome_bloc.dart';
import 'package:youscribe/presentation/blocs/home/home_bloc.dart';
import 'package:youscribe/presentation/blocs/library/first_level/library_bloc.dart';
import 'package:youscribe/presentation/blocs/search/search_bloc.dart';
import 'package:youscribe/styles/youscribe_theme.dart';
import 'package:youscribe/utilities/floating_player_control.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();

  // ignore: library_private_types_in_public_api
  static _AppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_AppState>();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  Locale? locale;
  //Note: This is an anti pattern
  final SetUserConfigurationsUseCase _setUserConfigurationsUseCase = locator();
  final GetUserSettingsUseCase _getUserSettingsUseCase = locator();
  final rxPrefs = RxSharedPreferences(
    SharedPreferences.getInstance(),
    kReleaseMode ? null : const RxSharedPreferencesDefaultLogger(),
    // disable logging when running in release mode.
  );
  late GoRouter _router;

  ///Set the app's default locale. Since setting it in this build method
  ///throws an error.
  Future<void> setLocale(
    Locale locale,
  ) async {
    this.locale = this.locale ?? locale;

    final uSettings = await _getUserSettingsUseCase(null);
    if (uSettings.ok?.preferredLanguageCode.isNullOrEmpty ?? true) {
      await _setUserConfigurationsUseCase(SetUserConfigurationsUseCaseParams(
          countryCode: locale.countryCode, languageCode: locale.languageCode));
    }
  }

  void setDownloadNotificationConfig(AppLocalizations? localizations) {
    // locator<FlutterDownloader>().configureNotification(
    //     running: TaskNotification(localizations!.downloading,
    // '{displayName}'),
    //     complete: TaskNotification(
    //         localizations.downloadingFinished, '{displayName}'),
    //     progressBar: true);
  }

  @override
  void initState() {
    super.initState();
    _router = AppRouter.routerOf(context);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state.name == "paused") {
      AppStateManager.stateController.add(AppStates.paused);
    } else if (state.name == "resumed") {
      AppStateManager.stateController.add(AppStates.active);
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext contextt) => MultiBlocProvider(
          //NOTE: BLOCS PROVIDED HERE ARE ACCESSED NO MATTER THE APP'S STATE
          //THEY'RE TREATED AS SINGLETONS. IF YOU WANT A BLOC TO RELOAD WHEN
          //A NAVIGATION IS MADE TO ITS SCREEN, DEFINE IT IN THE SCREEN ITSELF.
          providers: [
            BlocProvider(create: (context) => AppShellBloc()),
            BlocProvider(
                create: (context) => AccountBloc()..add(InitAccountEvent())),
            BlocProvider(
                create: (context) => AppBloc()
                  //TODO: How do I get the app's language here?
                  ..add(InitAppEvent())
                  ..add(SendAppConfigEvent('', '', ''))),
            BlocProvider(create: (context) => SearchBloc()),
            BlocProvider(
                create: (context) =>
                    WelcomeBloc()..add(const InitWelcomeScreenEvent())),
            BlocProvider(
                create: (context) => HomeBloc()..add(const InitHomeEvent())),
            BlocProvider(
                create: (context) =>
                    LibraryBloc()..add(const LibraryInitEvent())),
            BlocProvider(
                create: (context) =>
                    AppLoadingBloc()..add(AppLoadingInitialEvent())),
          ],
          child: AppProvider(
            child: Provider.value(
              value: rxPrefs,
              child: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
                Locale? locale;

                if (state is AppLanguageSetState) {
                  if (state.languageCode.isNotEmpty) {
                    locale = Locale(state.languageCode, state.countryCode);
                  }
                }

                return RootApp(locale: locale, router: _router);
              }),
            ),
          ));
}

class RootApp extends StatefulWidget {
  const RootApp({
    required this.locale,
    required GoRouter router,
    super.key,
  }) : _router = router;

  final Locale? locale;
  final GoRouter _router;

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  @override
  void initState() {
    super.initState();
    AudioService.notificationClicked.listen((event) async {
      final currentProduct =
          Provider.of<FloatingPlayerControl>(context, listen: false)
              .currentProduct;

      if (currentProduct.id != null) {
        await widget._router.pushNamed(Routes.audioPlayer, extra: {
          'player': locator<AudioPlayer>(),
          'product': currentProduct
        }, queryParameters: {
          Routes.productIdParamName: currentProduct.id.toString(),
          Routes.productAccessTypeParamName:
              ProductAccessState.canStream.toString()
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'YouScribe',
      locale: widget.locale,
      theme: Provider.of<YouScribeTheme>(context).theme,
      routerConfig: widget._router,
    );
  }
}
