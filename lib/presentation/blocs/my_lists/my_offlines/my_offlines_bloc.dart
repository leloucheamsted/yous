// ignore: depend_on_referenced_packages
// ignore_for_file: cascade_invocations

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe/core/use_cases/configurations/set_user_configurations_usecase.dart';
import 'package:youscribe/core/use_cases/products/get_offline_products_use_case.dart';
import 'package:youscribe/core/use_cases/products/sync_offline_products_usecase.dart';
import 'package:youscribe/presentation/blocs/my_lists/base_product_list_bloc.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'my_offlines_event.dart';
part 'my_offlines_state.dart';

class MyOfflinesBloc
    extends BaseProductListBloc<MyOfflinesEvent, MyOfflinesState>
    with Debuggable, Loggable {
  MyOfflinesBloc() : super(MyOfflinesInitialState()) {
    on<InitMyOfflinesEvent>(_init);
    on<RefreshMyOfflinesEvent>(_refresh);
    on<RemoveOfflineBookFromOfflinesEvent>(_removeFromOffline);
    on<LoadNewOfflineBooksPageEvent>(_loadNewPage);

    _getOfflineProductsUseCase = locator<GetOfflineProductsUseCase>();
    _syncOfflineProductsUsecase = locator();
  }

  late final GetOfflineProductsUseCase _getOfflineProductsUseCase;
  late final SyncOfflineProductsUsecase _syncOfflineProductsUsecase;
  late final ConnectivityService _connectivityService = locator();
  final UserAccountRepository userAccountRepository = locator();
  final SetUserConfigurationsUseCase _setUserConfigurationsUseCase = locator();

  bool _dontDisplaySwipeProductsListHelp = false;

  @override
  String get debugName => 'MyOfflinesBloc';

  Future<void> _loadNewPage(LoadNewOfflineBooksPageEvent event,
      Emitter<MyOfflinesState> emitter) async {
    if (await _connectivityService.isInternetAvailable) {
      logInfo("Loading new offline products page $pageSize");
      await _syncOfflineProductsUsecase(null);

      final results = await _getOfflineProductsUseCase.call(
          GetOfflineProductUseCaseParameters(pageSize, event.productsCount));

      if (results.isErr) {
        logError('Error loading new offline products page: ${results.err}',
            error: results.err);
        //TODO: Handle error in UI ?
        return;
      }

      final products = results.ok!.products;
      products.sort((a, b) => a.dateAddedToOfflines!
          .compareTo(b.dateAddedToOfflines ?? DateTime.now()));
      emitter(MyOfflinesLoadedState(
          products: [...(state as MyOfflinesLoadedState).products, ...products],
          hasNextPage: results.ok!.hasNextPage,
          dontDisplaySwipeProductsListHelp: _dontDisplaySwipeProductsListHelp,
          isRefreshedData: false));
    }
  }

  Future<void> _refresh(
      RefreshMyOfflinesEvent event, Emitter<MyOfflinesState> emitter) async {
    if (await _connectivityService.isInternetAvailable) {
      logInfo("Refreshing offline products page $pageSize");

      await _syncOfflineProductsUsecase(null);
      final results = await _getOfflineProductsUseCase
          .call(const GetOfflineProductUseCaseParameters(pageSize, 0));

      if (results.isErr) {
        logError('Refreshing offline products page: ${results.err}',
            error: results.err);
        //TODO: Handle error in UI ?
        return;
      }

      final products = results.ok!.products;
      products.sort((a, b) => a.dateAddedToOfflines!
          .compareTo(b.dateAddedToOfflines ?? DateTime.now()));
      emitter(MyOfflinesLoadedState(
          products: products,
          hasNextPage: results.ok!.hasNextPage,
          dontDisplaySwipeProductsListHelp: _dontDisplaySwipeProductsListHelp,
          isRefreshedData: false));
    }
  }

  Future<void> _removeFromOffline(RemoveOfflineBookFromOfflinesEvent event,
      Emitter<MyOfflinesState> emit) async {}

  Future<void> _loadOfflines(Emitter<MyOfflinesState> emitter) async {
    logInfo("Initializing favorite products page $pageSize");
    final settings = await userAccountRepository.getUserSettings();
    _dontDisplaySwipeProductsListHelp =
        settings.dontDisplaySwipeProductsListHelp ?? false;
    await super.init();
    await _syncOfflineProductsUsecase(null);
    final results = await _getOfflineProductsUseCase
        .call(const GetOfflineProductUseCaseParameters(pageSize, 0));

    if (results.isErr) {
      logError('Error initializing favorite products page: ${results.err}',
          error: results.err);
      //TODO: Handle error in UI ?
      return;
    }

    final products = results.ok!.products;
    if (products.isNullOrEmpty) {
      emitter(const MyOfflinesEmptyState());
      return;
    }
    products.sort((a, b) => a.dateAddedToOfflines!
        .compareTo(b.dateAddedToOfflines ?? DateTime.now()));
    emitter(MyOfflinesLoadedState(
        products: products,
        dontDisplaySwipeProductsListHelp: _dontDisplaySwipeProductsListHelp,
        hasNextPage: results
            .ok!.hasNextPage, //NOTE: sync might cause the number of products
        //to be less than that of a full page //results.ok!.hasNextPage,
        isRefreshedData: false));
  }

  Future<void> _init(
      InitMyOfflinesEvent event, Emitter<MyOfflinesState> emitter) {
    return _loadOfflines(emitter);
  }

  Future<void> onSetAccountDisplayHelpHint(bool displayed) async {
    final result = await _setUserConfigurationsUseCase.execute(
        SetUserConfigurationsUseCaseParams(displayHelpHint: displayed));
    if (result.isErr) {
      logError("Error setting account display help hint:", error: result.err);
      return;
    }
  }
}
