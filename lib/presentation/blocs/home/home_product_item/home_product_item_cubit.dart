import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/use_cases/downloads/download_product_usecase.dart';
import 'package:youscribe/utilities/view_utilities.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'home_product_item_state.dart';

class HomeProductListItemCubit extends Cubit<HomeProductListItemState>
    with Debuggable, Loggable {
  HomeProductListItemCubit(this.product) : super(HomeProductListItemInitial()) {
    _downloadProgressStreamController =
        StreamController<DownloadProgressWithStatus>.broadcast();
    downloadProductUseCase = locator<DownloadProductUseCase>();
    downloadProductUseCase.downloadProgressStream
        .listen(_onDownloadProgressChanged);
  }

  late final DownloadProductUseCase downloadProductUseCase;
  //TODO: Checkout what's the best way to handle this.
  late final StreamController<DownloadProgressWithStatus>
      _downloadProgressStreamController;
  Stream<DownloadProgressWithStatus> get downloadProgressStream =>
      _downloadProgressStreamController.stream;
  Sink<DownloadProgressWithStatus> get downloadProgressSink =>
      _downloadProgressStreamController.sink;
  final ProductEntity product;

  @override
  String get debugName => 'HomeProductListItemCubit';

  Future<void> onProductSelected() async {}

  Future<bool> downloadProduct() async {
    final result =
        await downloadProductUseCase(DownloadProductUseCaseParameters(
      productId: product.id!,
      extension: product.getProductExtension(),
      productTitle: product.title!,
    ));

    if (result.isErr) {
      logError('Error downloading product ${product.id} ${result.err!.message}',
          error: Exception(result.err));
      return false;
    }

    return true;
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
  }

  void _onDownloadFailed(DownloadProgressWithStatus progressData) {
    logError(
      // ignore: lines_longer_than_80_chars
      '### Download failed for product ${progressData.downloadProgress.productId}',
    );
  }

  void _onDownloadCancelled() {}

  @override
  Future<void> close() {
    _downloadProgressStreamController.close();
    return super.close();
  }
}
