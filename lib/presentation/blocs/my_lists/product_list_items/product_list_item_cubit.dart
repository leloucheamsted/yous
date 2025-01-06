import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/infrastructure/file_service.dart';
import 'package:youscribe/core/use_cases/downloads/download_product_usecase.dart';
import 'package:youscribe/core/use_cases/downloads/get_document_password_use_case.dart';
import 'package:youscribe/core/use_cases/products/add_product_to_favorites_usecase.dart';
import 'package:youscribe/core/use_cases/products/add_product_to_offlines_usecase.dart';
import 'package:youscribe/core/use_cases/products/check_product_access_rights_use_case.dart';
import 'package:youscribe/core/use_cases/products/delete_product_use_case.dart';
import 'package:youscribe/core/use_cases/products/product_read_use_case.dart';
import 'package:youscribe/core/use_cases/products/remove_from_favorites_usecase.dart';
import 'package:youscribe/core/use_cases/products/remove_from_offlines_usecase.dart';
import 'package:youscribe/utilities/view_utilities.dart';
import 'package:youscribe_analytics/youscribe_analytics.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'product_list_item_state.dart';

class ProductListItemCubit extends Cubit<ProductListItemState>
    with Debuggable, Loggable, Trackable {
  ProductListItemCubit(this.product) : super(ProductListItemInitial()) {
    _downloadProgressStreamController =
        StreamController<DownloadProgressWithStatus>.broadcast();
    downloadProductUseCase = locator<DownloadProductUseCase>();
    downloadProductUseCase.downloadProgressStream
        .listen(_onDownloadProgressChanged);
  }

  final CheckProductAccessRightsUseCase checkProductAccessRightsUseCase =
      locator<CheckProductAccessRightsUseCase>();
  late final DownloadProductUseCase downloadProductUseCase;
  //TODO: Checkout what's the best way to handle this.
  late final StreamController<DownloadProgressWithStatus>
      _downloadProgressStreamController;
  Stream<DownloadProgressWithStatus> get downloadProgressStream =>
      _downloadProgressStreamController.stream;
  Sink<DownloadProgressWithStatus> get downloadProgressSink =>
      _downloadProgressStreamController.sink;
  final ProductEntity product;
  final GetDocumentPasswordUseCase _getDocumentPasswordUseCase = locator();
  final FileService _fileService = locator();
  final DeleteProductUseCase deleteProductUseCase = locator();
  final RemoveFromOfflinesUseCase _removeFromOfflinesUseCase = locator();
  final RemoveFromFavoritesUseCase _removeFromFavoritesUseCase = locator();
  final AddProductToOfflinesUseCase _addToOfflineUseCase = locator();
  final AddProductToFavoritesUseCase _addToFavoritesUseCase = locator();
  final ProductReadUseCase _productReadUseCase = locator();

  @override
  String get debugName => 'ProductListItemCubit';

  Future<void> onProductSelected() async {}

  Future<void> onReadProduct() async {
    await _productReadUseCase(ProductReadUseCaseParams(product));
  }

  Future<void> onRemoveFromFavorites() async {
    product.isFavorite = false;
    emit(ProductListItemAttributeChanged(
        isFavorite: product.isFavorite ?? false,
        isOffline: product.isOffline ?? false,
        isLastRead: product.isLastRead ?? false,
        isFileAvailable: product.isFileAvailable ?? false));

    await tracker.trackProductRemovedFromFav(productId: product.id.toString());
    final result = await _removeFromFavoritesUseCase(
        RemoveFromFavoritesUseCaseParameters(product.id!));
    if (result.isErr) {
      logError(
          // ignore: lines_longer_than_80_chars
          'Error removing product ${product.id} from favorites ${result.err!.message}',
          error: result.err);
    }
  }

  Future<void> onAddToFavorites() async {
    logInfo("Adding product ${product.id} to favorites");
    product.isFavorite = true;
    emit(ProductListItemAttributeChanged(
        isFavorite: product.isFavorite ?? false,
        isOffline: product.isOffline ?? false,
        isLastRead: product.isLastRead ?? false,
        isFileAvailable: product.isFileAvailable ?? false));
    await tracker.trackProductAddedToFav(productId: product.id.toString());
    final result = await _addToFavoritesUseCase(
        AddProductToFavoritesUseCaseParameters(product));
    if (result.isErr) {
      logError(
          // ignore: lines_longer_than_80_chars
          'Error adding product ${product.id} to favorites ${result.err!.message}',
          error: result.err);
    }
  }

  Future<void> onAddToOffline() async {
    logInfo("Adding product ${product.id} to offline");
    product.isOffline = true;
    emit(ProductListItemAttributeChanged(
        isFavorite: product.isFavorite ?? false,
        isOffline: product.isOffline ?? false,
        isLastRead: product.isLastRead ?? false,
        isFileAvailable: product.isFileAvailable ?? false));
    await tracker.trackProductAddedToOffline(productId: product.id.toString());

    final r2 = await _addToOfflineUseCase(
        AddProductToOfflinesUseCaseParameters(product));
    if (r2.isErr) {
      //TODO: Handle this properly.
      logError(
          'Error adding product ${product.id}  to offline ${r2.err!.message}',
          error: r2.err);
    }
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

  Future<void> onRemoveFromOffline() async {
    logInfo("removing product ${product.id} to offline");
    product.isOffline = false;
    emit(ProductListItemAttributeChanged(
        isFavorite: product.isFavorite ?? false,
        isOffline: product.isOffline ?? false,
        isLastRead: product.isLastRead ?? false,
        isFileAvailable: product.isFileAvailable ?? false));
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
    }
  }

  Future<bool> downloadProduct() async {
    final result =
        await downloadProductUseCase(DownloadProductUseCaseParameters(
      productId: product.id!,
      extension: product.getProductExtension(),
      productTitle: product.title!,
    ));

    if (result.isErr) {
      logError('Error downloading product ${product.id} ${result.err!.message}',
          error: result.err);
      return false;
    }

    return true;
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

  void _onDownloadCompleted() {
    logInfo("Download completed for product ${product.id}");
    product.isFileAvailable = true;

    emit(ProductListItemAttributeChanged(
        isFavorite: product.isFavorite ?? false,
        isOffline: product.isOffline ?? false,
        isLastRead: product.isLastRead ?? false,
        isFileAvailable: product.isFileAvailable ?? false));
  }

  void _onDownloadFailed(DownloadProgressWithStatus progressData) {
    logError(
        // ignore: lines_longer_than_80_chars
        '### Download failed for product ${progressData.downloadProgress.productId}');
  }

  void _onDownloadCancelled() {}

  @override
  Future<void> close() {
    _downloadProgressStreamController.close();
    return super.close();
  }
}
