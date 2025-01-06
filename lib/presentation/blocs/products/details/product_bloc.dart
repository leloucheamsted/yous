import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/base/base_entity.dart';
import 'package:youscribe/core/entities/helpers/product_extensions.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/entities/simple_library_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/infrastructure/file_service.dart';
import 'package:youscribe/core/repositories/document_repository.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe/core/use_cases/configurations/get_country_configuration_use_case.dart';
import 'package:youscribe/core/use_cases/downloads/download_product_usecase.dart';
import 'package:youscribe/core/use_cases/downloads/get_document_password_use_case.dart';
import 'package:youscribe/core/use_cases/my_selections/add_product_to_selection_use_case.dart';
import 'package:youscribe/core/use_cases/my_selections/create_new_selection_use_case.dart';
import 'package:youscribe/core/use_cases/my_selections/get_my_selection_use_case.dart';
import 'package:youscribe/core/use_cases/products/add_product_to_favorites_usecase.dart';
import 'package:youscribe/core/use_cases/products/add_product_to_offlines_usecase.dart';
import 'package:youscribe/core/use_cases/products/check_product_access_rights_use_case.dart';
import 'package:youscribe/core/use_cases/products/delete_product_use_case.dart';
import 'package:youscribe/core/use_cases/products/get_new_product_suggestions_use_case.dart';
import 'package:youscribe/core/use_cases/products/get_product_collections_use_case.dart';
import 'package:youscribe/core/use_cases/products/get_product_use_case.dart';
import 'package:youscribe/core/use_cases/products/remove_from_favorites_usecase.dart';
import 'package:youscribe/core/use_cases/products/remove_from_offlines_usecase.dart';
import 'package:youscribe/core/use_cases/products/save_offline_product_use_case.dart';
import 'package:youscribe/core/use_cases/user/follow_author_by_product_use_case.dart';
import 'package:youscribe/core/use_cases/user/follow_editor_by_product_use_case.dart';
import 'package:youscribe/core/use_cases/user/follow_sub_theme_by_product_use_case.dart';
import 'package:youscribe/core/use_cases/user/get_followers_by_product_use_case.dart';
import 'package:youscribe/core/use_cases/user/unfollow_author_by_product_use_case.dart';
import 'package:youscribe/core/use_cases/user/unfollow_editor_by_product_use_case.dart';
import 'package:youscribe/core/use_cases/user/unfollow_sub_theme_by_product_use_case.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe/utilities/view_utilities.dart';
import 'package:youscribe_analytics/youscribe_analytics.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductDetailsBloc extends Bloc<ProductEvent, ProductState>
    with Debuggable, Loggable, Trackable {
  ProductDetailsBloc() : super(ProductInitialState()) {
    on<InitProductEvent>(_init);
    on<RefreshProductEvent>(_refresh);
    on<IsOfflineEvent>(_setIsOffline);
    on<FollowEvent>(_follow);
    on<FavoriteEvent>(_favorite);
    on<ErrorDisplayedEvent>(_errorDisplayed);
    on<SyncEvent>(_syncProduct);
    on<SelectionDisplayedEvent>(_selectionDisplayed);
    on<RetreiveSelectionsEvent>(_retreiveSelections);
    on<AddToSelectionEvent>(_addToSelection);
    on<AddToSelectionDisplayedEvent>(_addToSelectionDisplayed);
    on<RequestSyncDisplayedEvent>(_requestSyncDisplayed);

    _downloadProgressStreamController =
        StreamController<DownloadProgressWithStatus>.broadcast();
    downloadProductUseCase = locator<DownloadProductUseCase>();
    _connectivityService = locator<ConnectivityService>();
    _getFollowersByProductUseCase = locator<GetFollowersByProductUseCase>();
    _getNewProductSuggestionsUseCase =
        locator<GetNewProductSuggestionsUseCase>();
    _getProductCollectionsUseCase = locator<GetProductCollectionsUseCase>();
    _getProductUseCase = locator<GetProductUseCase>();
    _getCountryConfigurationUseCase = locator<GetCountryConfigurationUseCase>();
    downloadProductUseCase.downloadProgressStream
        .listen(_onDownloadProgressChanged);
  }

  final FileService _fileService = locator();
  final GetDocumentPasswordUseCase _getDocumentPasswordUseCase = locator();
  final CheckProductAccessRightsUseCase checkProductAccessRightsUseCase =
      locator<CheckProductAccessRightsUseCase>();
  late final DownloadProductUseCase downloadProductUseCase;
  late final StreamController<DownloadProgressWithStatus>
      _downloadProgressStreamController;
  Stream<DownloadProgressWithStatus> get downloadProgressStream =>
      _downloadProgressStreamController.stream;
  Sink<DownloadProgressWithStatus> get downloadProgressSink =>
      _downloadProgressStreamController.sink;
  late ProductEntity product;
  late final ConnectivityService _connectivityService;

  late final GetCountryConfigurationUseCase _getCountryConfigurationUseCase;
  late final GetNewProductSuggestionsUseCase _getNewProductSuggestionsUseCase;
  late final GetProductCollectionsUseCase _getProductCollectionsUseCase;
  late final GetFollowersByProductUseCase _getFollowersByProductUseCase;

  final RemoveFromOfflinesUseCase _removeFromOfflinesUseCase = locator();
  final RemoveFromFavoritesUseCase _removeFromFavoritesUseCase = locator();
  final SaveOfflineProductUseCase _saveOfflineProductUseCase = locator();
  final AddProductToOfflinesUseCase _addToOfflineUseCase = locator();
  final AddProductToFavoritesUseCase _addToFavoritesUseCase = locator();
  final AddProductToSelectionUseCase _addProductToSelectionUseCase = locator();
  final CreateNewSelectionUseCase _createNewSelectionUseCase = locator();
  late final GetProductUseCase _getProductUseCase;

  late final FollowAuthorByProductUseCase _followAuthorByProductUseCase =
      locator();
  late final FollowEditorByProductUseCase _followEditorByProductUseCase =
      locator();
  late final FollowSubThemeByProductUseCase _followSubThemeByProductUseCase =
      locator();
  late final UnFollowAuthorByProductUseCase _unFollowAuthorByProductUseCase =
      locator();
  late final UnFollowEditorByProductUseCase _unFollowEditorByProductUseCase =
      locator();
  late final GetMySelectionsUseCase _getMySelectionsUseCase = locator();

  late final UnFollowSubThemeByProductUseCase
      _unFollowSubThemeByProductUseCase = locator();
  late final DocumentRepository _documentRepository = locator();

  DeleteProductUseCase deleteProductUseCase = locator();

  static const int numberOfSuggestions = 6;
  List<BaseEntity> _suggestions = [];
  List<BaseEntity> _collections = [];
  bool _shouldSetPriceInfo = false;
  bool _canShowCollections = false;
  bool _isAudio = false;
  //TODO: Manage the logic to display price info
  //TODO: Manage the initialization of Follow
  //TODO: Manage the initialization of Collections
  //TODO: Manage Product publish scenario.
  //TODO: Manage suggestions
  //TODO: Manage product synchronization
  //TODO: On the UI, add comments to product details.

  @override
  String get debugName => 'ProductDetailsBloc';

  Future<void> _init(
      InitProductEvent event, Emitter<ProductState> emitter) async {
    bool isInternetKo = false;
    if (!await _connectivityService.isInternetAvailable) {
      isInternetKo = true;
      //  emitter(ProductErrorState(state, ErrorType.noInternet, false));
      // return;
    }
    final response = await _getProductUseCase(
        GetProductUseCaseParameters(event.productId, onPreloaded: (product) {
      _preloadedProduct(emitter, product);
    }, checkInternetCo: isInternetKo));
    if (response.isErr) {
      logError(
          // ignore: lines_longer_than_80_chars
          'Error getting product ${event.productId} ${response.err!.message} Error: ${response.err}',
          error: response.err);

      if (response.err is APIRequestException) {
        if (!await _connectivityService.isInternetAvailable) {
          emitter(ProductErrorState(state, ErrorType.noInternet, false));
        } else {
          emitter(ProductErrorState(state, ErrorType.serverError));
        }
      } else {
        emitter(ProductErrorState(state, ErrorType.unknownError));
      }
      return;
    }

    product = response.ok!;
    _isAudio = product.productType == ProductType.audioBook ||
        product.productType == ProductType.podcast ||
        product.productType == ProductType.partition;
    emitter(ProductLoadedState(product: product, isAudio: _isAudio));

    await _loadSuggestions(emitter);
    if (product.collectionId != null) {
      await _loadCollections(emitter, event.language);
    }
    final countryConfig = await _getCountryConfigurationUseCase(
        GetCountryConfigurationUseCaseParams(offlineFirst: true));
    if (countryConfig.isOk && countryConfig.ok != null) {
      _shouldSetPriceInfo = countryConfig.ok!.countryCode!.contains('fr') &&
          product.rentalPrice > 0;
    }
    if (_shouldSetPriceInfo) {
      emitter(
        ProductLoadedState(
            priceInfo: product.rentalPrice.toString(),
            shouldSetPriceInfo: _shouldSetPriceInfo,
            collections: _collections,
            canShowCollections: _canShowCollections,
            suggestions: _suggestions,
            isAudio: _isAudio,
            product: product),
      );
    }

    await _requestSync(emitter);
    await _initFollowing(emitter);
  }

  void _preloadedProduct(
      Emitter<ProductState> emitter, ProductEntity? product) {
    if (product.isNull) {
      return;
    }
    this.product = product!;

    emitter(ProductLoadedState(product: product, isPreloadedData: true));
  }

  Future<void> _loadSuggestions(Emitter<ProductState> emitter) async {
    final parameters =
        GetNewSuggesstionsUseCaseParameters(product.id!, numberOfSuggestions);
    final resultSuggestions =
        await _getNewProductSuggestionsUseCase(parameters);
    if (resultSuggestions.isErr) {
      logError("Error while setting user suggestions.",
          error: Exception(resultSuggestions.err));
    }
    _suggestions = resultSuggestions.ok ?? [];
    emitter(ProductLoadedState(
        suggestions: _suggestions, product: product, isAudio: _isAudio));
  }

  Future<void> _loadCollections(
      Emitter<ProductState> emitter, String language) async {
    final parameters = GetProductCollectionsUseCaseParameters(
        product.collectionId!, numberOfSuggestions, language);
    final response = await _getProductCollectionsUseCase(parameters);
    if (response.isErr) {
      logError("Error while setting user collections.",
          error: Exception(response.err));
      return;
    }

    _collections = response.ok ?? [];
    if (_collections.isNotEmpty) {
      _canShowCollections = true;
    }
    emitter(ProductLoadedState(
        collections: _collections,
        suggestions: _suggestions,
        canShowCollections: _canShowCollections,
        isAudio: _isAudio,
        product: product));
  }

  Future<void> _retreiveSelections(
      RetreiveSelectionsEvent event, Emitter<ProductState> emitter) async {
    emitter(
        (state as ProductLoadedState).copyWith(product: product, isBusy: true));
    final UserAccountRepository user = locator();

    final selectionsResult = await _getMySelectionsUseCase(null);
    if (selectionsResult.isErr) {
      logError(
          'Error getting list of selection   ${selectionsResult.err!.message}',
          error: selectionsResult.err);

      if (selectionsResult.err is APIRequestException) {
        if (!await _connectivityService.isInternetAvailable) {
          emitter(ProductErrorState(
              (state as ProductLoadedState)
                  .copyWith(product: product, isBusy: false),
              ErrorType.noInternet));
        } else {
          emitter(ProductErrorState(
              (state as ProductLoadedState)
                  .copyWith(product: product, isBusy: false),
              ErrorType.serverError));
        }
      } else {
        emitter(ProductErrorState(
            (state as ProductLoadedState)
                .copyWith(product: product, isBusy: false),
            ErrorType.unknownError));
      }
      return;
    }
    emitter((state as ProductLoadedState).copyWith(product: product));
    emitter(ProductAddedSelectionState(
        selectionsResult.ok ?? [],
        (state as ProductLoadedState)
            .copyWith(product: product, isBusy: false)));
  }

  Future<void> _addToSelection(
      AddToSelectionEvent event, Emitter<ProductState> emitter) async {
    String name;
    final int productId = event.productId;
    int libraryId = 0;
    emitter(
      ProductLoadedState(
          priceInfo: product.rentalPrice.toString(),
          shouldSetPriceInfo: _shouldSetPriceInfo,
          collections: _collections,
          canShowCollections: _canShowCollections,
          suggestions: _suggestions,
          isBusy: true,
          product: product),
    );
    if (!event.isSelectionExist) {
      final createSelection = await _createNewSelectionUseCase(
          CreateNewSelectionsUseCaseParameters(
              event.name, event.isPublic ?? false));
      if (createSelection.isErr) {
        logError("Error of selection creation",
            error: Exception(createSelection.err));
        if (createSelection.err is APIRequestException) {
          if (!await _connectivityService.isInternetAvailable) {
            emitter(ProductErrorState(
                (state as ProductLoadedState)
                    .copyWith(product: product, isBusy: false),
                ErrorType.noInternet));
          } else {
            emitter(ProductErrorState(
                (state as ProductLoadedState)
                    .copyWith(product: product, isBusy: false),
                ErrorType.serverError));
          }
        } else {
          emitter(ProductErrorState(
              (state as ProductLoadedState)
                  .copyWith(product: product, isBusy: false),
              ErrorType.unknownError));
        }
        return;
      }
      name = createSelection.ok!.label!;
      libraryId = createSelection.ok!.id!;
    } else {
      name = event.name;
      libraryId = event.libraryId!;
    }
    final addToSelectionResult = await _addProductToSelectionUseCase(
        AddProductToSelectioneUseCaseParameters(productId, libraryId));
    if (addToSelectionResult.isErr) {
      // Exception(addToSelectionResult.err);
      logError(
          // ignore: lines_longer_than_80_chars
          'Error getting product ${event.productId} ${addToSelectionResult.err!.message} Error: ${addToSelectionResult.err}',
          error: addToSelectionResult.err);

      if (addToSelectionResult.err is APIRequestException) {
        if (!await _connectivityService.isInternetAvailable) {
          emitter(ProductErrorState(
              (state as ProductLoadedState)
                  .copyWith(product: product, isBusy: false),
              ErrorType.noInternet));
        } else {
          emitter(ProductErrorState(
              (state as ProductLoadedState)
                  .copyWith(product: product, isBusy: false),
              ErrorType.serverError));
        }
      } else {
        emitter(ProductErrorState(
            (state as ProductLoadedState)
                .copyWith(product: product, isBusy: false),
            ErrorType.unknownError));
      }
      return;
    }
    emitter(
      ProductLoadedState(
          priceInfo: product.rentalPrice.toString(),
          shouldSetPriceInfo: _shouldSetPriceInfo,
          collections: _collections,
          canShowCollections: _canShowCollections,
          suggestions: _suggestions,
          product: product),
    );
    await Future.delayed(const Duration(seconds: 1), () {
      emitter(ProductSuccessSelectionAddState(state, name: name));
    });
  }

  Future<void> _refresh(
      RefreshProductEvent event, Emitter<ProductState> emitter) async {
    final response =
        await _getProductUseCase(GetProductUseCaseParameters(event.productId));

    if (response.isErr) {
      logError(
          // ignore: lines_longer_than_80_chars
          'Error getting product ${event.productId} ${response.err!.message}',
          error: response.err);

      if (response.err is APIRequestException) {
        emitter(ProductErrorState(
            (state as ProductLoadedState)
                .copyWith(product: product, isBusy: false),
            ErrorType.serverError));
      } else if (!await _connectivityService.isInternetAvailable) {
        emitter(ProductErrorState(
            (state as ProductLoadedState)
                .copyWith(product: product, isBusy: false),
            ErrorType.noInternet));
      } else {
        emitter(ProductErrorState(
            ProductLoadedState(product: product)
                .copyWith(product: product, isBusy: false),
            ErrorType.unknownError));
      }
      return;
    }

    product = response.ok!;
    emitter(
      ProductLoadedState(
          priceInfo: product.rentalPrice.toString(),
          shouldSetPriceInfo: _shouldSetPriceInfo,
          collections: _collections,
          canShowCollections: _canShowCollections,
          suggestions: _suggestions,
          product: product),
    );
  }

  Future<void> onAddToOffline(Emitter<ProductState> emitter) async {
    logInfo("Adding product ${product.id} to offline");

    await tracker.trackProductAddedToOffline(productId: product.id.toString());

    final r2 = await _addToOfflineUseCase(
        AddProductToOfflinesUseCaseParameters(product));

    if (r2.isErr) {
      //TODO: Handle this properly.
      logError(
          'Error adding product ${product.id}  to offline ${r2.err!.message}',
          error: r2.err);
      return;
    }
    product.isOffline = true;
    emitter((state as ProductLoadedState)
        .copyWith(product: product, isBusy: false));
  }

  Future<void> onRemoveFromOffline(Emitter<ProductState> emitter) async {
    logInfo("Adding product ${product.id} to offline");

    await tracker.trackProductRemovedFromOffline(
        productId: product.id.toString());

    deleteProductUseCase(DeleteProductUseCaseParameters(
        product.id!, product.getProductExtension()));
    final result = await _removeFromOfflinesUseCase(
        RemoveFromOfflinesUseCaseParameters(product.id!));
    if (result.isErr) {
      logError(
          // ignore: lines_longer_than_80_chars
          'Error removing product ${product.id} from offlines ${result.err!.message}',
          error: result.err);
      return;
    }
    product.isOffline = false;
    emitter((state as ProductLoadedState)
        .copyWith(product: product, isBusy: false));
  }

  Future<void> _follow(FollowEvent event, Emitter<ProductState> emitter) async {
    if (!await _connectivityService.isInternetAvailable) {
      emitter(ProductErrorState(state, ErrorType.noInternet));
      return;
    }
    emitter(
        (state as ProductLoadedState).copyWith(product: product, isBusy: true));
    if (state is ProductLoadedState) {
      final currentState = state as ProductLoadedState;

      if (event.followType == FollowType.followAuthor) {
        final res = await _followAuthorByProductUseCase(product.id);
        if (res.isErr) {
          logError(
              // ignore: lines_longer_than_80_chars
              'Error following author for product ${product.id} ${res.err!.message}',
              error: res.err);
          return;
        }
        emitter(currentState.copyWith(
            product: product, isFollowingAuthor: true, isBusy: false));
      }

      if (event.followType == FollowType.unFollowAuthor) {
        final res = await _unFollowAuthorByProductUseCase(product.id);
        if (res.isErr) {
          logError(
              // ignore: lines_longer_than_80_chars
              'Error unfollowing author for product ${product.id} ${res.err!.message}',
              error: res.err);
          return;
        }
        emitter(currentState.copyWith(
            product: product, isFollowingAuthor: false, isBusy: false));
      }
      if (event.followType == FollowType.followEditor) {
        final res = await _followEditorByProductUseCase(product.id);
        if (res.isErr) {
          logError(
              // ignore: lines_longer_than_80_chars
              'Error following editor for product ${product.id} ${res.err!.message}',
              error: res.err);
          return;
        }
        emitter(currentState.copyWith(
            product: product, isFollowingEditor: true, isBusy: false));
      }
      if (event.followType == FollowType.unFollowEditor) {
        final res = await _unFollowEditorByProductUseCase(product.id);
        if (res.isErr) {
          logError(
              // ignore: lines_longer_than_80_chars
              'Error unfollowing editor for product ${product.id} ${res.err!.message}',
              error: res.err);
          return;
        }
        emitter(currentState.copyWith(
            product: product, isFollowingEditor: false, isBusy: false));
      }
      if (event.followType == FollowType.followTheme) {
        final res = await _followSubThemeByProductUseCase(product.id);
        if (res.isErr) {
          logError(
              // ignore: lines_longer_than_80_chars
              'Error following theme for product ${product.id} ${res.err!.message}',
              error: res.err);
          return;
        }
        emitter(currentState.copyWith(
            product: product, isFollowingTheme: true, isBusy: false));
      }
      if (event.followType == FollowType.unfollowTheme) {
        final res = await _unFollowSubThemeByProductUseCase(product.id);
        if (res.isErr) {
          logError(
              // ignore: lines_longer_than_80_chars
              'Error unfollowing theme for product ${product.id} ${res.err!.message}',
              error: res.err);
          return;
        }
        emitter(currentState.copyWith(
            product: product, isFollowingTheme: false, isBusy: false));
      }
    }
  }

  void _errorDisplayed(
      ErrorDisplayedEvent event, Emitter<ProductState> emitter) {
    if (state is ProductErrorState) {
      emitter((state as ProductErrorState).previousState);
    }
  }

  void _selectionDisplayed(
      SelectionDisplayedEvent event, Emitter<ProductState> emitter) {
    if (state is ProductAddedSelectionState) {
      emitter((state as ProductAddedSelectionState).previousState);
    }
  }

  void _addToSelectionDisplayed(
      AddToSelectionDisplayedEvent event, Emitter<ProductState> emitter) {
    if (state is ProductSuccessSelectionAddState) {
      emitter((state as ProductSuccessSelectionAddState).previousState);
    }
  }

  void _requestSyncDisplayed(
      RequestSyncDisplayedEvent event, Emitter<ProductState> emitter) {
    if (state is RequestSyncState) {
      emitter((state as RequestSyncState).previousState);
    }
  }

  Future<void> _syncProduct(
      SyncEvent event, Emitter<ProductState> emitter) async {
    logInfo("Syncing product ${product.id}");

    await downloadProduct(true);
  }

  Future<void> _favorite(
      FavoriteEvent event, Emitter<ProductState> emitter) async {
    logInfo("Adding product ${product.id} to favorites");
    emitter(
        (state as ProductLoadedState).copyWith(product: product, isBusy: true));

    if (event.isFavorite) {
      await tracker.trackProductAddedToFav(productId: product.id.toString());
      final result = await _addToFavoritesUseCase(
          AddProductToFavoritesUseCaseParameters(product));
      if (result.isErr) {
        logError(
            // ignore: lines_longer_than_80_chars
            'Error adding product ${product.id} to favorites ${result.err!.message}',
            error: result.err);
        return;
      }
      product.isFavorite = event.isFavorite;
      emitter((state as ProductLoadedState)
          .copyWith(product: product, isBusy: false));
    } else {
      await tracker.trackProductRemovedFromFav(
          productId: product.id.toString());
      final result = await _removeFromFavoritesUseCase(
          RemoveFromFavoritesUseCaseParameters(product.id!));
      if (result.isErr) {
        logError(
            // ignore: lines_longer_than_80_chars
            'Error removing product ${product.id} from favorites ${result.err!.message}',
            error: result.err);
        return;
      }
      product.isFavorite = event.isFavorite;
      emitter((state as ProductLoadedState)
          .copyWith(product: product, isBusy: false));
    }
  }

  Future<void> _setIsOffline(
      IsOfflineEvent event, Emitter<ProductState> emitter) async {
    emitter(
        (state as ProductLoadedState).copyWith(product: product, isBusy: true));
    if (event.isOffline) {
      await onRemoveFromOffline(emitter);
    } else {
      await onAddToOffline(emitter);
    }
  }

  // void setProductDisplayProperties(Emitter<ProductState> emitter) {
  //   try {
  //     // if (product.languagesIsoCode.isNotNull &&
  //     //     product.languagesIsoCode.isNotEmpty) {
  //     //   logInfo("Setting iso language code.");
  //     //   var isoLang = product.languagesIsoCode.first;
  //     //   var culture = isoLang.From3LetterISOName();
  //     //   if (culture.isNotNull)
  //     //     product.languageCode = culture.NativeName;
  //     //   else
  //     //     product.languageCode = isoLang;
  //     // }

  //     _isAudio = product.productType == ProductType.audioBook ||
  //         product.productType == ProductType.podcast ||
  //         product.productType == ProductType.partition;
  //     emitter(state.copyWith(isAudio: isAudio));
  //   } catch (e) {
  //     logError(
  //         "Error occured while setting product display properties.",
  //         error: Exception(e));
  //   }
  // }

  Future<void> _requestSync(Emitter<ProductState> emitter) async {
    final internetIsAvailable = await _connectivityService.isInternetAvailable;
    if (product.isOffline! &&
        !product.isFileAvailable! &&
        internetIsAvailable) {
      emitter(RequestSyncState(state));
    }
  }

  Future<void> _initFollowing(Emitter<ProductState> emitter) async {
    try {
      if (state is ProductLoadedState) {
        final followed = await _getFollowersByProductUseCase(product.id);

        if (followed.isErr) {
          logError(
              // ignore: lines_longer_than_80_chars
              'Error getting Follow items for product ${product.id} message: ${followed.err!.message} Error: ${followed.err}',
              error: followed.err);
          return;
        }

        final currentState = state as ProductLoadedState;

        emitter((state as ProductLoadedState).copyWith(
            product: currentState.product,
            canFollowTheme: product.canFollowTheme(),
            isFollowingAuthor: followed.ok?.isAuthorFollowed,
            isFollowingEditor: followed.ok?.isEditorFollowed,
            isFollowingTheme: followed.ok?.isSubthemeFollowed));
      }
    } catch (e) {
      logError("Error $e while setting following items for user.",
          error: Exception(e));
    }
  }

  Future<ProductAccessState?> canReadProduct(bool shouldRead) async {
    final result = await checkProductAccessRightsUseCase(
        CheckProductAccessRightsUseCaseParameters(
            product: product, shouldRead: shouldRead));
    if (result.isErr) {
      logError(
          'Error checking product: ${product.id} access rights ${result.err}',
          error: result.err);
      return null;
    }

    return result.ok!;
  }

  Future<(String? password, String path)> getProductReadData() async {
    final currentUser = await AuthenticationManager.getCurrentUser();
    final result = await _getDocumentPasswordUseCase(
        GetDocumentPasswordUseCaseParametters(null, product.id!));
    final filePath = await _fileService.getProductFilePath(
        currentUser!.id!, product.id!, product.getProductExtension());

    if (result.isErr) {
      logError('Error getting product password ${result.err!.message}',
          error: result.err);
      return (null, filePath);
    }

    return (result.ok, filePath);
  }

  void _onDownloadProgressChanged(DownloadProgressWithStatus progressData) {
    if (progressData.downloadProgress.productId != product.id) {
      return;
    }

    _downloadProgressStreamController.addWithCheck(progressData);
    if (progressData.state == DownloadProgressState.failed) {
      progressData.downloadProgress.progress = 0;
      _downloadProgressStreamController.addWithCheck(progressData);
      _onDownloadFailed(progressData);
    } else if (progressData.state == DownloadProgressState.cancelled) {
      _onDownloadCancelled();
    } else if (progressData.state == DownloadProgressState.paused) {
      //_onDownloadPaused();
    } else if (progressData.state == DownloadProgressState.completed) {
      _onDownloadCompleted();
    }
  }

  Future<bool> downloadProduct(bool isSavedOffline) async {
    // check permission before
    final platform =
        Platform.isIOS ? TargetPlatform.iOS : TargetPlatform.android;
    if (!await _checkPermission(platform)) {
      return false;
    }
    try {
      final result =
          await downloadProductUseCase(DownloadProductUseCaseParameters(
        productId: product.id!,
        extension: product.getProductExtension(),
        productTitle: product.title!,
      ));

      if (result.isErr) {
        logError(
            'Error downloading product ${product.id} ${result.err!.message}',
            error: result.err);
        return false;
      }
      if (isSavedOffline) {
        _saveOfflineProductUseCase(
            SaveOfflineProductUseCaseParameters(product, true, true, true));
      }
    } catch (e) {
      logError('Error downloading product ${product.id} $e',
          error: Exception(e));
    }
    return true;
  }

  void _onDownloadCompleted() {
    logInfo("Download completed for product ${product.id}");
    product.isFileAvailable = true;
  }

  void _onDownloadFailed(DownloadProgressWithStatus progressData) {
    logError(
        // ignore: lines_longer_than_80_chars
        '### Download failed for product ${progressData.downloadProgress.productId}');
    _documentRepository.deleteProductDownloadProgressForProduct(
        progressData.downloadProgress.productId);
  }

  Future<bool> _checkPermission(TargetPlatform platform) async {
    if (Platform.isIOS) {
      return true;
    }
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (platform == TargetPlatform.android &&
        androidInfo.version.sdkInt <= 28) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  void _onDownloadCancelled() {}
}
