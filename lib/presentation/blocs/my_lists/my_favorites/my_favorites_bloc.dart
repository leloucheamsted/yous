// ignore: depend_on_referenced_packages
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe/core/use_cases/configurations/set_user_configurations_usecase.dart';
import 'package:youscribe/core/use_cases/downloads/download_product_usecase.dart';
import 'package:youscribe/core/use_cases/products/get_favorite_products_use_case.dart';
import 'package:youscribe/core/use_cases/products/sync_fav_products_usecase.dart';
import 'package:youscribe/presentation/blocs/my_lists/base_product_list_bloc.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'my_favorites_event.dart';
part 'my_favorites_state.dart';

class MyFavoritesBloc
    extends BaseProductListBloc<MyFavoritesEvent, MyFavoritesState>
    with Debuggable, Loggable {
  MyFavoritesBloc() : super(MyFavoritesInitialState()) {
    on<InitMyFavoritesEvent>(_init);
    on<RefreshMyFavoritesEvent>(_refresh);
    on<RemoveFavoriteBookFromFavoritesEvent>(_removeFromFavorites);
    on<LoadNewFavoriteBooksPageEvent>(_loadNewPage);
    on<FavoriteBookDownloadCompletedEvent>(_downloadCompleted);

    _getFavoriteProductsUseCase = locator<GetFavoriteProductsUseCase>();
    _syncFavoriteProductsUsecase = locator<SyncFavoriteProductsUsecase>();
    _connectivityService = locator<ConnectivityService>();
  }
  final SetUserConfigurationsUseCase _setUserConfigurationsUseCase = locator();
  late final GetFavoriteProductsUseCase _getFavoriteProductsUseCase;
  late final SyncFavoriteProductsUsecase _syncFavoriteProductsUsecase;
  late final ConnectivityService _connectivityService;
  final UserAccountRepository userAccountRepository = locator();

  bool _dontDisplaySwipeProductsListHelp = false;

  @override
  String get debugName => 'MyFavoritesBloc';

  Future<void> _loadNewPage(LoadNewFavoriteBooksPageEvent event,
      Emitter<MyFavoritesState> emitter) async {
    if (await _connectivityService.isInternetAvailable) {
      logInfo("Loading new favorite products page $pageSize");
      final results = await _getFavoriteProductsUseCase.call(
          GetFavoritePoductUseCaseParameters(pageSize, event.productsCount));

      if (results.isErr) {
        logError('Error loading new favorite products page: ${results.err}',
            error: results.err);
        //TODO: Handle error in UI ?
        return;
      }

      final products = results.ok!.products;
      if (products.isNullOrEmpty) {
        emitter(const MyFavoritesEmptyState());
        return;
      }
      emitter(MyFavoritesLoadedState(
          products: [
            ...(state as MyFavoritesLoadedState).products,
            ...products
          ],
          hasNextPage: results.ok!.hasNextPage,
          isRefreshedData: false,
          dontDisplaySwipeProductsListHelp: _dontDisplaySwipeProductsListHelp));
    }
  }

  Future<void> _refresh(
      RefreshMyFavoritesEvent event, Emitter<MyFavoritesState> emitter) async {
    if (await _connectivityService.isInternetAvailable) {
      logInfo("Refreshing favorite products page $pageSize");
      await _syncFavoriteProductsUsecase(null);
      final results = await _getFavoriteProductsUseCase
          .call(const GetFavoritePoductUseCaseParameters(pageSize, 0));

      if (results.isErr) {
        logError('Refreshing favorite products page: ${results.err}',
            error: results.err);
        //TODO: Handle error in UI ?
        return;
      }

      final products = results.ok!.products;
      emitter(MyFavoritesLoadedState(
          products: products,
          hasNextPage: results.ok!.hasNextPage,
          dontDisplaySwipeProductsListHelp: _dontDisplaySwipeProductsListHelp,
          isRefreshedData: false));
    }
  }

  Future<void> _removeFromFavorites(RemoveFavoriteBookFromFavoritesEvent event,
      Emitter<MyFavoritesState> emit) async {
    //TODO: Make sure the product with the given id
    // is in the list before removing it.
  }

  Future<void> _loadFavorites(Emitter<MyFavoritesState> emitter) async {
    logInfo("Initializing favorite products page $pageSize");

    await super.init();
    await _syncFavoriteProductsUsecase(null);
    //if (await _connectivityService.isInternetAvailable) {
    final results = await _getFavoriteProductsUseCase
        .call(const GetFavoritePoductUseCaseParameters(pageSize, 0));
    final settings = await userAccountRepository.getUserSettings();
    _dontDisplaySwipeProductsListHelp =
        settings.dontDisplaySwipeProductsListHelp ?? false;
    if (results.isErr) {
      logError('Error initializing favorite products page: ${results.err}',
          error: results.err);
      //TODO: Handle error in UI ?
      return;
    }

    final products = results.ok!.products;
    if (products.isNullOrEmpty) {
      emitter(const MyFavoritesEmptyState());
      return;
    }
    emitter(MyFavoritesLoadedState(
        products: products,
        dontDisplaySwipeProductsListHelp: _dontDisplaySwipeProductsListHelp,
        hasNextPage: results
            .ok!.hasNextPage, //NOTE: sync might cause the number of products
        //to be less than that of a full page //results.ok!.hasNextPage,
        isRefreshedData: false));
    //  }
  }

  Future<void> _init(
      InitMyFavoritesEvent event, Emitter<MyFavoritesState> emitter) {
    return _loadFavorites(emitter);
  }

  Future<void> _downloadCompleted(FavoriteBookDownloadCompletedEvent event,
      Emitter<MyFavoritesState> emitter) async {
    final currentState = state as MyFavoritesLoadedState;
    final newProducts = currentState.products.map((element) {
      if (element.id == event.productId) {
        element.isFileAvailable = true;
      }

      return element;
    });

    emitter(MyFavoritesLoadedState(
        products: List.from(newProducts),
        hasNextPage: true,
        dontDisplaySwipeProductsListHelp: _dontDisplaySwipeProductsListHelp,
        isRefreshedData: false));

    //TODO: Save this in database.
  }

  @override
  void onDownloadCompleted(DownloadProgressWithStatus progressData) {
    //NOTE: we call the event here because we want to update the UI as soon as
    //the download completed (The emmiter is called only available in the event)
    add(FavoriteBookDownloadCompletedEvent(
        progressData.downloadProgress.productId));
  }

  @override
  void onDownloadFailed(DownloadProgressWithStatus progressData) {
    // TODO: implement onDownloadFailed
    super.onDownloadFailed(progressData);

    // ProductEntity? product;
    // if (state is MyFavoritesLoadedState) {
    //   final currentState = state as MyFavoritesLoadedState;
    //   product = currentState.products.firstWhere(
    //       (p) => p.id == progressData.downloadProgress.productId.id!);
    //   logError(
    //       // ignore: lines_longer_than_80_chars
    //       '### Download failed for product ${progressData
    // .downloadProgress.productId.id}');
    //   final progress = ProgressData(
    //     0,
    //     progressData.downloadProgress.productId.id!,
    //     DownloadProgressState.failed,
    //     product.title,
    //   );
    //   downloadProgressSink.add(progress);
    // }
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
