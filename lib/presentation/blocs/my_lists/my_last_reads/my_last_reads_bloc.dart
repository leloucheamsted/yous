// ignore: depend_on_referenced_packages
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe/core/use_cases/configurations/set_user_configurations_usecase.dart';
import 'package:youscribe/core/use_cases/downloads/download_product_usecase.dart';
import 'package:youscribe/core/use_cases/products/get_last_read_products_use_case.dart';
import 'package:youscribe/core/use_cases/products/sync_book_mark_use_case.dart';
import 'package:youscribe/core/use_cases/products/sync_last_read_products_usecase.dart';
import 'package:youscribe/presentation/blocs/my_lists/base_product_list_bloc.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'my_last_reads_event.dart';
part 'my_last_reads_state.dart';

class MyLastReadsBloc
    extends BaseProductListBloc<MyLastReadsEvent, MyLastReadsState>
    with Debuggable, Loggable {
  MyLastReadsBloc() : super(MyLastReadsInitialState()) {
    on<InitMyLastReadsEvent>(_init);
    on<RefreshMyLastReadsEvent>(_refresh);
    on<RemoveLastReadBookFromFavoritesEvent>(_removeFromFavorites);
    on<LastReadBookDownloadCompletedEvent>(_downloadCompleted);

    _getLastReadProductsUseCase = locator<GetLastReadProductsUseCase>();
    _syncLastReadProductsUsecase = locator();
  }

  late final GetLastReadProductsUseCase _getLastReadProductsUseCase;
  late final SyncLastReadProductsUsecase _syncLastReadProductsUsecase;
  final ConnectivityService _connectivityService = locator();
  final UserAccountRepository userAccountRepository = locator();
  final SetUserConfigurationsUseCase _setUserConfigurationsUseCase = locator();

  final SyncBookMarkUsecase _syncBookMarkUsecase = locator();
  bool _dontDisplaySwipeProductsListHelp = false;

  @override
  String get debugName => 'MyLastReadsBloc';

  Future<void> _refresh(
      RefreshMyLastReadsEvent event, Emitter<MyLastReadsState> emit) async {
    if (await _connectivityService.isInternetAvailable) {
      final currentUser = await AuthenticationManager.getCurrentUser();

      await _syncLastReadProductsUsecase(null);
      final result = await _getLastReadProductsUseCase.call(
          GetLastReadProductUseCaseParameters(
              currentUser!.id!, currentUser.trackingId));

      //TODO: Handle empty view
      //TODO: Handle when the user loads offline data first, then api data
      if (result.isErr) {
        logError('Error refreshing ${result.err!.message}', error: result.err);
        //TODO: Handle error
        return;
      }

      final products = result.ok!;
      emit(MyLastReadsLoadedState(
          products: products,
          isRefreshedData: true,
          hasNextPage: false,
          dontDisplaySwipeProductsListHelp: _dontDisplaySwipeProductsListHelp));

      final syncRes = await _syncBookMarkUsecase(null);
      if (syncRes.isErr) {
        logError('Error syncing bookmarks ${syncRes.err!.message}',
            error: syncRes.err);
        //TODO: Handle error
        return;
      }
    }
  }

  Future<void> _init(
      InitMyLastReadsEvent event, Emitter<MyLastReadsState> emit) {
    return _loadLastReads(emit);
  }

  Future<void> _loadLastReads(Emitter<MyLastReadsState> emit) async {
    logInfo("Initializing last read screen");
    final currentUser = await AuthenticationManager.getCurrentUser();
    final settings = await userAccountRepository.getUserSettings();
    _dontDisplaySwipeProductsListHelp =
        settings.dontDisplaySwipeProductsListHelp ?? false;
    await super.init();

    await _syncLastReadProductsUsecase(null);

    final result = await _getLastReadProductsUseCase.call(
        GetLastReadProductUseCaseParameters(
            currentUser!.id!, currentUser.trackingId));

    //TODO: Handle empty view
    if (result.isErr) {
      logError('Error init last read products ${result.err!.message}',
          error: result.err);
      //TODO: Handle error
      return;
    }

    final products = result.ok!;
    if (products.isNullOrEmpty) {
      emit(const MyLastReadsEmptyState());
      return;
    }
    products.sort(
        (a, b) => b.dateLastRead!.compareTo(a.dateLastRead ?? DateTime.now()));

    emit(MyLastReadsLoadedState(
        products: products,
        isRefreshedData: false,
        hasNextPage: false,
        dontDisplaySwipeProductsListHelp: _dontDisplaySwipeProductsListHelp));
  }

  Future<void> _removeFromFavorites(RemoveLastReadBookFromFavoritesEvent event,
      Emitter<MyLastReadsState> emitter) async {}

  Future<void> _downloadCompleted(LastReadBookDownloadCompletedEvent event,
      Emitter<MyLastReadsState> emitter) async {
    //TODO: Just notify the UI that the download was completed.
  }

  @override
  void onDownloadCompleted(DownloadProgressWithStatus progressData) {
    //NOTE: we call the event here because we want to update the UI as soon as
    //the download completed (The emmiter is called only available in the event)
    add(LastReadBookDownloadCompletedEvent(
        progressData.downloadProgress.productId));
  }

  @override
  void onDownloadFailed(DownloadProgressWithStatus progressData) {
    // TODO: implement onDownloadFailed
    super.onDownloadFailed(progressData);
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
