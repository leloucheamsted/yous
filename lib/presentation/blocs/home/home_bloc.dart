// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/editorial_entity.dart';
import 'package:youscribe/core/entities/home_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/entities/selection_model.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/infrastructure/in_app_purchase_service.dart';
import 'package:youscribe/core/infrastructure/service.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe/core/use_cases/configurations/get_user_settings_use_case.dart';
import 'package:youscribe/core/use_cases/home/get_home_use_case.dart';
import 'package:youscribe/core/use_cases/user/is_user_subscribe_use_case.dart';
import 'package:youscribe/infrastructure/background_service/service_name.dart';
import 'package:youscribe/presentation/blocs/my_lists/base_product_list_bloc.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe/utilities/ys_timer.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends BaseProductListBloc<HomeEvent, HomeState>
    with Debuggable, Loggable {
  HomeBloc() : super(HomeInitial()) {
    on<InitHomeEvent>(_init);
    on<RefreshHomeEvent>(_refresh);
    on<DialogsDisplayedEvent>(_dialogsDisplayed);

    _getHomeUseCase = locator<GetHomeUseCase>();
    _subscribeUseCase = locator<IsUserSubscribeUseCase>();
    _connectivityService = locator<ConnectivityService>();
    _service = locator<Service>();
  }

  late final GetHomeUseCase _getHomeUseCase;
  final GetUserSettingsUseCase _getUserSettingsUseCase = locator();
  late final ConnectivityService _connectivityService;
  late final IsUserSubscribeUseCase _subscribeUseCase;
  late final InAppPurchaseService inAppPurchaseService;
  final UserAccountRepository _userAccountRepository =
      locator<UserAccountRepository>();
  late final Service _service;
  bool _shouldShowSubscriptionBanner = false;
  late HomeLoadedState previousState;

  @override
  String get debugName => 'HomeBloc';

  Future<void> _launchBackgroundTasks() async {
    try {
      await Workmanager().registerOneOffTask(
        ServiceName.setupBackgroundActions,
        ServiceName.setupBackgroundActions,
        tag: ServiceName.setupBackgroundActions,
        initialDelay: const Duration(seconds: 1),
      );
      await Workmanager().registerOneOffTask(
        ServiceName.syncBookListsActions,
        ServiceName.syncBookListsActions,
        tag: ServiceName.syncBookListsActions,
        initialDelay: const Duration(seconds: 1),
      );
    } catch (e) {
      logError("Error while launching background Tasks.", error: Exception(e));
    }
  }

  Future<void> _init(InitHomeEvent event, Emitter<HomeState> emitter) async {
    logInfo("Intializing home page with language: ${event.language}");

    await super.init();

    try {
      await _launchBackgroundTasks();
      await locator<YsTimer>().monitorInActiveSessionReadOnStart();
      final SharedPreferences _prefs = await prefs;
      final bool isGARUserConnected =
          _prefs.getBool(PreferenceKey.isGarUserConnected) ?? false;
      if (isGARUserConnected) {
        await locator<YsTimer>().logoutGARUser();
      }
      final currentUser = await AuthenticationManager.getCurrentUser();
      final results = await _getHomeUseCase(
        GetHomeUseCaseParameters(await _getLang(event.language), false,
            (localHome) => _handleHomePreloaded(localHome, emitter)),
      );
      if (results.isErr) {
        logError('Error initializing home page: ${results.err}',
            error: results.err);
        if (state is HomeLoadedState) {
          if ((state as HomeLoadedState).editorials.isNotEmpty ||
              (state as HomeLoadedState).selections.isNotEmpty) {
            return;
          }
        }
        emitter(HomeExceptionState(HomeLoadedState(
            editorials: const [],
            selections: const [],
            gleephSeggestions: const [],
            shouldShowSubscriptionBanner: false,
            isRefreshedData: false)));
        return;
      }

      final editorials = results.ok!.editorials;
      final selections = results.ok!.selections;

      final isUserSubscribed = await _subscribeUseCase(null);
      if (isUserSubscribed.isErr) {
        logError(
            // ignore: lines_longer_than_80_chars
            'Error occured while checking if user is subscribed: ${isUserSubscribed.err}',
            error: isUserSubscribed.err);
      }

      _shouldShowSubscriptionBanner =
          !(isUserSubscribed.ok ?? currentUser!.isSubscriber ?? false);

      emitter(HomeLoadedState(
          editorials: editorials,
          selections: selections,
          gleephSeggestions: const [],
          shouldShowSubscriptionBanner: _shouldShowSubscriptionBanner,
          isRefreshedData: false));
      previousState = HomeLoadedState(
          editorials: editorials,
          selections: selections,
          gleephSeggestions: const [],
          shouldShowSubscriptionBanner: _shouldShowSubscriptionBanner,
          isRefreshedData: false);
    } on APIRequestException catch (ex) {
      logError('API Error occured while initializing home data screen ',
          error: ex);
      emitter(HomeExceptionState(HomeLoadedState(
          editorials: const [],
          selections: const [],
          gleephSeggestions: const [],
          shouldShowSubscriptionBanner: false,
          isRefreshedData: false)));
    } finally {
      if (!_shouldShowSubscriptionBanner) {
        final showRate = await _service.requestAppRating(false);
        if (showRate) {
          emitter(HomeShowRateState(previousState));
        }
      }
      await validateSubscription(checkSettingsForPendingSubscription: true);
    }
  }

  Future<void> _handleHomePreloaded(
      HomeEntity? home, Emitter<HomeState> emitter) async {
    if (home == null) {
      return;
    }

    final currentUser = await AuthenticationManager.getCurrentUser();

    emitter(HomeLoadedState(
        editorials: home.editorials,
        selections: home.selections,
        gleephSeggestions: const [],
        shouldShowSubscriptionBanner: !(currentUser!.isSubscriber ?? false),
        isRefreshedData: false));
  }

  Future<void> _dialogsDisplayed(
      DialogsDisplayedEvent event, Emitter<HomeState> emitter) async {
    if (state is HomeExceptionState) {
      emitter((state as HomeExceptionState).previousState);
    }
    if (state is HomeShowRateState) {
      emitter((state as HomeShowRateState).previousState);
    }
  }

  Future<String> _getLang(String givenLang) async {
    final userSettings = await _getUserSettingsUseCase(null);
    String lang = '';
    if (userSettings.isOk &&
        (userSettings.ok?.preferredLanguageCode.isNotNullOrEmpty ?? false)) {
      lang = userSettings.ok!.preferredLanguageCode;
    } else {
      lang = givenLang;
    }

    return lang;
  }

  Future<void> _refresh(
      RefreshHomeEvent event, Emitter<HomeState> emitter) async {
    if (await _connectivityService.isInternetAvailable) {
      logInfo("Refreshing home page with language: ${event.language}");

      try {
        final results = await _getHomeUseCase.call(
            GetHomeUseCaseParameters(await _getLang(event.language), false));

        emitter(HomeLoadedState(
            editorials: results.ok!.editorials,
            selections: results.ok!.selections,
            gleephSeggestions: const [],
            shouldShowSubscriptionBanner: _shouldShowSubscriptionBanner,
            isRefreshedData: false));
      } catch (e) {
        logError("Error occured while refreshing the home page",
            error: Exception(e));
      }
    }
  }

  Future<void> validateSubscription(
      {bool checkSettingsForPendingSubscription = false}) async {
    try {
      final currentUser = await AuthenticationManager.getCurrentUser();
      if (!await _connectivityService.isInternetAvailable &&
          !currentUser!.isSubscriber!) {
        try {
          final result = await inAppPurchaseService.wasSubscriptionPurchased();
          if (result) {
            logInfo("Subscription successfully made.");
            await _setUserAsSubscriber();
          }
        } catch (ex) {
          logError(
              "Could not validate subscription at startup. CheckSettings ? $checkSettingsForPendingSubscription",
              error: Exception(ex));
        }
      }
    } catch (e) {
      logError("Error while validating user's subscription.",
          error: Exception(e));
    }
  }

  Future<void> _setUserAsSubscriber() async {
    final userAccount = await AuthenticationManager.getCurrentUser();
    userAccount!.isSubscriber = true;
    await _userAccountRepository.saveUserAccount(userAccount);
  }
}
