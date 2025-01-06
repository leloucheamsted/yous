import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/page_turned_entity.dart';
import 'package:youscribe/core/use_cases/reader/save_bookmark_use_case.dart';
import 'package:youscribe/infrastructure/service/reader_stats_service.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

abstract class AudioReaderMonitor with Debuggable, Loggable {
  const AudioReaderMonitor();

  static const int _saveBookmarkInterval = 5;
  static const int _sendReadingStatsInterval = 30;

  @override
  String get debugName => 'AudioReaderMonitor';

  /// Initializes the AudioReaderMonitor.
  /// If the monitor is already initialized, it will be re-initialized by
  /// disposing the current instance and creating a new one.
  Future<void> init();

  /// Disposes the AudioReaderMonitor.
  void dispose();

  /// Starts a new book.
  /// [productId] is the id of the product.
  /// [chapterIndex] is the index of the chapter.
  /// [chapterDurations] is a list of the durations of the chapters.
  Future<void> startNewBook(
    int productId,
    int chapterIndex,
    List<int> chapterDurations,
  );
}

class AudioReaderMonitorImpl extends AudioReaderMonitor {
  // Services
  final ReaderStatsService _readerStatsService = locator();
  final SaveBookmarkUseCase _saveBookmarkUseCase = locator();

  // Player
  final AudioPlayer _player = locator();

  int _currentChapterIndex = 0;
  int _currentProductId = 0;
  List<int> _chapterDurations = [];
  int _previousBookmarkSecond = 0;
  int _previousStatsSentSecond = 0;
  bool _isInit = false;

  StreamSubscription<Duration>? _durationSubscription;
  StreamSubscription<PlayerState>? _playerStateSubscription;

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _playerStateSubscription?.cancel();

    _isInit = false;
    _player.stop();

    logInfo("AudioReaderMonitor disposed.");
  }

  @override
  Future<void> init() async {
    if (_isInit) {
      dispose();
    }

    _durationSubscription =
        _player.positionStream.listen(_onPlayerPositionChanged);

    _playerStateSubscription =
        _player.playerStateStream.listen(_onPlayerStateChanged);

    _isInit = true;

    logInfo("AudioReaderMonitor initialized.");
  }

  @override
  Future<void> startNewBook(
    int productId,
    int chapterIndex,
    List<int> chapterDurations,
  ) async {
    logInfo("Starting new book with product id $productId.");
    _currentChapterIndex = chapterIndex;
    _currentProductId = productId;
    _chapterDurations = chapterDurations;
    _readerStatsService.startReading(productId, isAudiobook: true);
  }

  /// Handles the player position change event.
  /// [position] is the current position of the player in the audio.
  /// This method is called every time the player position changes.
  /// It saves the bookmark and sends the reading stats to the server.
  /// The bookmark is saved every [AudioReaderMonitor._saveBookmarkInterval]
  /// seconds.
  Future<void> _onPlayerPositionChanged(Duration position) async {
    final bookmarkInterval = position.inSeconds - _previousBookmarkSecond;
    final statsInterval = position.inSeconds - _previousStatsSentSecond;

    if (bookmarkInterval.abs() >= AudioReaderMonitor._saveBookmarkInterval) {
      _previousBookmarkSecond = position.inSeconds;

      if (_isInit &&
          !position.inSeconds.isNaN &&
          position.inSeconds.isFinite &&
          position.inSeconds != 0) {
        logInfo(
          "Saving bookmark at ${position.inSeconds} seconds for "
          "product $_currentProductId.",
        );
        await _saveBookmarkUseCase(
          SaveBookmarkUseCaseParameters(
            productId: _currentProductId,
            pageNumber: _player.currentIndex ?? 0,
            progress: position.inSeconds.toDouble(),
          ),
        );
      }
    }

    if (statsInterval.abs() >= AudioReaderMonitor._sendReadingStatsInterval) {
      _previousStatsSentSecond = position.inSeconds;

      if (_isInit &&
          !position.inSeconds.isNaN &&
          position.inSeconds.isFinite &&
          position.inSeconds != 0) {
        logInfo("Sending reading stats at ${position.inSeconds} seconds.");
        final percent = _getPercentageBookRead(
          _player.position,
          _currentChapterIndex,
          _chapterDurations,
        );
        await _readerStatsService.pageChanged(
          PageTurnedEntity(
            percent: percent,
            pageSize: _chapterDurations[_currentChapterIndex].toDouble(),
            pagePosition: _player.position.inSeconds.toDouble(),
            currentPage: _currentChapterIndex,
          ),
        );
      }
    }
  }

  /// Returns the percentage of the book read.
  /// [currentPosition] is the current position of the player in the audio.
  /// [currentChapter] is the index of the current chapter.
  /// [chapterDurations] is a list of the durations of the chapters.
  double _getPercentageBookRead(
    Duration currentPosition,
    int currentChapter,
    List<int> chapterDurations,
  ) {
    if (chapterDurations.isEmpty) {
      return 0;
    }

    double durationSum = 0;
    bool doesEveryChapterHaveEqualDuration = false;

    if (chapterDurations.length > 1) {
      for (int i = 0; i < currentChapter; i++) {
        durationSum += chapterDurations[i];
      }

      doesEveryChapterHaveEqualDuration = durationSum == currentChapter - 1;
    }

    if (doesEveryChapterHaveEqualDuration) {
      durationSum += 1;
    } else {
      durationSum += currentPosition.inSeconds.toDouble();
    }

    final percentageOverall =
        (durationSum / chapterDurations.reduce((a, b) => a + b)) * 100.0;

    return percentageOverall.isFinite ? percentageOverall : 0.0;
  }

  /// Handles the player state change event.
  /// [playerState] is the current state of the player.
  /// This method is called every time the player state changes.
  /// It saves the bookmark and sends the reading stats to the server.
  Future<void> _onPlayerStateChanged(PlayerState playerState) async {
    logInfo("Player state changed: $playerState");
    if (playerState.processingState == ProcessingState.ready &&
        !playerState.playing) {
      logInfo("Player is ready but not playing.");
      // The user paused the player.
      await _readerStatsService.stopReading();
      final prefs = await SharedPreferences.getInstance();
      final productId = prefs.getInt(PreferenceKey.currentPlayerId);
      if (productId == _currentProductId) {
        await _saveBookmarkUseCase(
          SaveBookmarkUseCaseParameters(
            productId: _currentProductId,
            pageNumber: _player.currentIndex ?? 0,
            progress: _player.position.inSeconds.toDouble(),
          ),
        );
      }
    }

    if (playerState.processingState == ProcessingState.idle &&
        !playerState.playing) {
      logInfo("Player is idle.");
      // The user stopped the player.
      await _readerStatsService.stopReading();
      await _saveBookmarkUseCase(
        SaveBookmarkUseCaseParameters(
          productId: _currentProductId,
          pageNumber: _player.currentIndex ?? 0,
          progress: _player.position.inSeconds.toDouble(),
        ),
      );
    }

    if (playerState.processingState == ProcessingState.ready &&
        _currentChapterIndex != _player.currentIndex) {
      logInfo("Chapter changed.");
      // The chapter changed.
      _currentChapterIndex = _player.currentIndex ?? 0;
      final percent = _getPercentageBookRead(
        _player.position,
        _currentChapterIndex,
        _chapterDurations,
      );
      await _readerStatsService.pageChanged(
        PageTurnedEntity(
          percent: percent,
          pageSize: _chapterDurations[_currentChapterIndex].toDouble(),
          pagePosition: _player.position.inSeconds.toDouble(),
          currentPage: _currentChapterIndex,
        ),
      );
    }

    if (playerState.playing &&
        playerState.processingState == ProcessingState.ready) {
      logInfo("Player is playing.");
      // The player is playing.
      _readerStatsService.resumeReading();
    }

    if (playerState.processingState == ProcessingState.completed &&
        !playerState.playing) {
      logInfo("Player completed.");
      // The book ended.
      await _readerStatsService.stopReading();
    }
  }
}
