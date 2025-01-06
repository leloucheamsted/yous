import 'dart:math';

import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/page_turned_entity.dart';
import 'package:youscribe/core/entities/reading_stats_entity.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/data/data_sources/product_data_sources/product_remote_data_source.dart';
import 'package:youscribe/data/data_sources/product_data_sources/reading_stat_local_data_source.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class ReaderStatsService with Debuggable, Loggable {
  ReaderStatsService();

  static const int bookParts = 200;
  static const int unitOfTime = 3;

  final ProductRemoteDataSource _productService = locator();
  final ReadingStatsLocalDataSource _readerStatsCacheService = locator();
  int? _productId;
  PageTurnedEntity? _nextState;
  PageTurnedEntity? _previousState;
  final ConnectivityService _connectivityService = locator();
  DateTime? _previousTimeOnPage;
  bool _isAudiobook = false;

  @override
  String get debugName => "ReaderStatsService";

  Future<void> sendReadStatsAsync(ReadingStatsEntity model) async {
    try {
      if (await _connectivityService.isInternetAvailable) {
        if (model.trackingId.isNullOrEmpty) {
          logInfo("Reading stats issues.");
          logError("The tracking id has a default value.",
              error: Exception("Tracking id was default."),
              methodName: "sendReadStatsAsync");
        }

        await _productService.sendReadingStats(model);
      } else {
        await _readerStatsCacheService.saveStat(model.productId!, model);
      }

      _previousTimeOnPage = DateTime.now();
    } on Exception catch (e) {
      logError("Error occurred while sending reading state to API", error: e);
    } catch (err) {
      logError("Error occurred while sending reading state to API. Error: $err",
          error: Exception(e));
    }
  }

  void startReading(int productId, {bool isAudiobook = false}) {
    _isAudiobook = isAudiobook;
    logInfo("Started reading: $productId");
    _productId = productId;
    _previousState = null;
    _previousTimeOnPage = DateTime.now();
  }

  Future<void> pageChanged(PageTurnedEntity currentTurnModel,
      {PageTurnedEntity? nextTurnModel}) async {
    logInfo("Page turned: $_productId");
    _nextState = currentTurnModel;
    _previousTimeOnPage ??= DateTime.now();

    await sendState();
    if (nextTurnModel != null) {
      _previousState = nextTurnModel;
    }
  }

  void resumeReading() {
    logInfo("Resuming reading: $_productId");
    if (_previousState != null) {
      _previousTimeOnPage = DateTime.now();
    }
  }

  Future<void> stopReading() async {
    logInfo("Stopping reading: $_productId");
    await sendState();
    _previousTimeOnPage = null;
    _previousState = null;
  }

  Future<void> sendState() async {
    if (_previousState != null) {
      final timeOnPage = DateTime.now().difference(_previousTimeOnPage!);
      logInfo(
          "TimeOnPage: ${timeOnPage.inSeconds} previous: $_previousTimeOnPage");

      if (timeOnPage.inSeconds >= unitOfTime) {
        const partIndexCount = bookParts - 1;
        int fromPart = 0;
        int toPart = 0;
        int seconds = 0;

        if (!_isAudiobook) {
          fromPart = max(0, (_previousState!.percent * 2).floor());
          toPart = min(
              partIndexCount,
              ((_previousState!.percent + (_previousState!.pageSize)) * 2)
                  .floor());
          seconds = timeOnPage.inSeconds;
        } else {
          final nextPercentage = (_nextState?.percent ?? 0) * 2;
          fromPart = max(0, (_previousState!.percent * 2).floor());
          toPart = min(partIndexCount, nextPercentage.floor());

          final toDivide = (toPart - fromPart).abs() + 1;
          seconds = (timeOnPage.inSeconds / toDivide).ceil();
        }

        var count = (timeOnPage.inSeconds / unitOfTime).floor();
        count = max(1, count);

        await sendReadStatsAsync(ReadingStatsEntity.fromParams(
          fromPart: fromPart,
          toPart: toPart,
          count: count,
          second: seconds,
          eventDate: DateTime.now(),
          trackingId:
              Auth.instance.session?.currentUserAccountEntity?.trackingId,
          userId: Auth.instance.session?.currentUserAccountEntity?.id,
          productId: _productId,
        ));
      } else {
        logInfo(
            // ignore: lines_longer_than_80_chars
            "### Skipped turning page, totalTimeSpent: ${timeOnPage.inSeconds} TimeNow: ${DateTime.now()}");
      }
    }

    _previousState = _nextState;
  }
}
