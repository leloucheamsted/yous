import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/use_cases/downloads/download_product_usecase.dart';
import 'package:youscribe/utilities/view_utilities.dart';

abstract class BaseProductListBloc<Event, State> extends Bloc<Event, State> {
  BaseProductListBloc(super.initialState) {
    _downloadProgressStreamController =
        StreamController<DownloadProgressWithStatus>.broadcast();
    downloadProductUseCase = locator<DownloadProductUseCase>();
  }

  late final DownloadProductUseCase downloadProductUseCase;
  //TODO: Checkout what's the best way to handle this.
  late final StreamController<DownloadProgressWithStatus>
      _downloadProgressStreamController;
  Stream<DownloadProgressWithStatus> get downloadProgressStream =>
      _downloadProgressStreamController.stream;
  Sink<DownloadProgressWithStatus> get downloadProgressSink =>
      _downloadProgressStreamController.sink;

  Future<void> init() async {
    downloadProductUseCase.downloadProgressStream
        .listen(_onDownloadProgressChanged);
  }

  void onDownloadFailed(DownloadProgressWithStatus progressData) {}
  void onDownloadCancelled(DownloadProgressWithStatus progressData) {}
  void onDownloadPaused(DownloadProgressWithStatus progressData) {}
  void onDownloadCompleted(DownloadProgressWithStatus progressData) {}

  void _onDownloadProgressChanged(DownloadProgressWithStatus progressData) {
    _downloadProgressStreamController.addWithCheck(progressData);

    if (progressData.state == DownloadProgressState.failed) {
      onDownloadFailed(progressData);
    } else if (progressData.state == DownloadProgressState.cancelled) {
      onDownloadCancelled(progressData);
    } else if (progressData.state == DownloadProgressState.paused) {
      onDownloadPaused(progressData);
    } else if (progressData.state == DownloadProgressState.completed) {
      onDownloadCompleted(progressData);
    }
  }

  @override
  Future<void> close() {
    _downloadProgressStreamController.close();
    return super.close();
  }
}
