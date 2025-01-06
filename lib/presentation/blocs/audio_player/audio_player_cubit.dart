import 'dart:async';
import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/app_settings.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/audio_chapter_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/entities/product_search_results_entity.dart';
import 'package:youscribe/core/models/requests/product_search_parameters.dart';
import 'package:youscribe/core/repositories/product_search_repository.dart';
import 'package:youscribe/core/use_cases/products/check_product_access_rights_use_case.dart';
import 'package:youscribe/core/use_cases/products/get_product_use_case.dart';
import 'package:youscribe/core/use_cases/products/init_audio_player_usecase.dart';
import 'package:youscribe/core/use_cases/products/product_read_use_case.dart';
import 'package:youscribe/infrastructure/readers/audio_reader_monitor.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState>
    with Debuggable, Loggable {
  AudioPlayerCubit() : super(AudioPlayerInitialState());

  // Use cases and services
  final GetProductUseCase _getProductUseCase = locator();
  final InitAudioPlayerUseCase _initAudioPlayerUseCase = locator();
  final ProductReadUseCase _productReadUseCase = locator();
  final ProductSearchReposotiry productSearchRepository =
      locator(); // TODO: fix typo
  final AudioReaderMonitor _audioMonitor = locator();

  // Player
  final AudioPlayer _player = locator();

  // Settings
  final AppSettings _appSettings = locator();

  // Variables
  List<ProductEntity> _collection = [];
  StreamSubscription<Duration>? _durationSubscription;

  @override
  String get debugName => 'AudioPlayerCubit';

  FutureOr<void> init({
    required int productId,
    required ProductAccessState productAccessState,
  }) async {
    // Set preferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        PreferenceKey.productAccessState, productAccessState.toString());
    await prefs.setInt(PreferenceKey.currentPlayerId, productId);

    // Dispose previous monitor
    _audioMonitor.dispose();

    // Get product
    final productResult = await _getProductUseCase(
      GetProductUseCaseParameters(
        productId,
        checkInternetCo: true,
      ),
    );

    if (productResult.isErr || productResult.ok == null) {
      emit(AudioPlayerErrorState(
        productResult.err ?? const ServerException("Product not found"),
      ));
      return;
    }

    final product = productResult.ok!;

    // Check if product is a collection
    if (product.collectionId != null) {
      try {
        final collectionProducts =
            await _loadCollectionProducts(product.collectionId!);

        // Assume that the collection is sorted by id
        collectionProducts.sort((a, b) => a.id!.compareTo(b.id!));
        _collection = collectionProducts;
      } catch (e) {
        logError('Error while loading collection products: $e', error: e);
      }
    }

    // Init audio player
    final initResults = await _initAudioPlayerUseCase(
      InitAudioPlayerUseCaseParams(
        productAccessState: productAccessState,
        productId: productId,
      ),
    );

    if (initResults.isErr || initResults.ok == null) {
      emit(AudioPlayerErrorState(
        initResults.err ?? const ClientException("Error while initializing"),
      ));
      return;
    }

    final initializations = initResults.ok!;

    final authToken = await Auth.getAuthToken();

    // Construct playlist
    List<AudioChapterEntity> chapters = initializations.chapters;
    List<AudioSource> playlistItems = [];
    if (productAccessState == ProductAccessState.canStream) {
      logInfo('canStream | ${chapters.first.mediaUrl}');
      playlistItems = chapters
          .map(
            (e) => AudioSource.uri(
              Uri.parse(e.mediaUrl),
              headers: {
                _appSettings.ysAuthHeaderKey: authToken,
              },
              tag: MediaItem(
                  id: e.orderId.toString(),
                  title: e.title ?? '',
                  album: product.title,
                  artUri: product.imageUrl.isNotNullOrEmpty
                      ? Uri.parse(product.imageUrl!)
                      : null),
            ),
          )
          .toList();
    } else {
      logInfo('canDownload');
      chapters = await _orderPlayerSequences(initializations.chapters);

      chapters.asMap().forEach((index, e) {
        // Check if file exists or is available
        if (e.mediaRealPath.isNotNullOrEmpty) {
          final file = File(e.mediaRealPath!);
          if (!file.existsSync()) {
            logError(
                "File does not exist: ${e.mediaRealPath} for chapter ${e.orderId}");
          }
        }

        playlistItems.add(
          AudioSource.file(
            e.mediaRealPath ?? "",
            tag: MediaItem(
              id: e.orderId.toString(),
              title: e.title ?? '',
              album: product.title,
              artUri: product.imageUrl.isNotNullOrEmpty
                  ? Uri.parse(product.imageUrl!)
                  : null,
              artHeaders: {
                _appSettings.ysAuthHeaderKey: authToken,
              },
            ),
          ),
        );
      });
    }

    // Set playlist
    final playlist = ConcatenatingAudioSource(
      shuffleOrder: DefaultShuffleOrder(),
      children: playlistItems,
    );

    try {
      await _player.setAudioSource(
        playlist,
        initialIndex: initializations.bookmark == null
            ? 0
            : initializations.bookmark!.pageNumber,
        initialPosition: initializations.bookmark == null
            ? Duration.zero
            : initializations.bookmark!.progressDuration,
      );

      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.speech());

      // Subscribe to player events
      _durationSubscription =
          _player.positionStream.listen((position) => _onPlayerPositionChanged(
                position,
                initializations: initializations,
              ));

      emit(
        AudioPlayerLoadedState(
          chapters: chapters,
          product: product,
          currentChapterIndex: initializations.bookmark?.pageNumber ?? 0,
          chapterStopSeconds: initializations.chapterStopSeconds?.toInt() ?? 0,
          extractChapterIndex: initializations.extractChapterIndex ?? 0,
          hasExtractRestrictions: initializations.hasExtractRestrictions,
          collection: _collection,
          isProductCollection: _collection.isNotNullOrEmpty,
        ),
      );

      // Save last read
      await _productReadUseCase(ProductReadUseCaseParams(product));

      // Start audio monitor
      await _audioMonitor.startNewBook(
        product.id!,
        initializations.bookmark?.pageNumber ?? 0,
        chapters.map((e) => e.chapterDuration?.toInt() ?? 0).toList(),
      );
      await _audioMonitor.init();

      // Start audio player
      await _player.play();
    } on PlayerException catch (e) {
      // iOS/macOS: maps to NSError.code
      // Android: maps to ExoPlayerException.type
      // Web: maps to MediaError.code
      // Linux/Windows: maps to PlayerErrorCode.index

      logError("Audio player Error code: ${e.code} error $e",
          error: Exception(e));
      emit(AudioPlayerErrorState(ClientException("Error in Audio Player: $e")));

      // iOS/macOS: maps to NSError.localizedDescription
      // Android: maps to ExoPlaybackException.getMessage()
      // Web/Linux: a generic message
      // Windows: MediaPlayerError.message
    } on PlayerInterruptedException catch (e) {
      // This call was interrupted since another audio source was loaded or the
      // player was stopped or disposed before this audio source could complete
      // loading.
      logError("Player interrupted, Connection aborted: ${e.message} Error: $e",
          error: Exception(e));

      emit(AudioPlayerErrorState(ClientException("Error while playing: $e")));
    } catch (e) {
      logError(
          '''Fatal error while setting audio player source for product: ${product.id}, Error:$e''',
          error: Exception(e));

      emit(AudioPlayerErrorState(ClientException("Error while playing: $e")));
    }
  }

  Future<List<ProductEntity>> _loadCollectionProducts(int collectionId) async {
    final ProductSearchParameters searchParams = ProductSearchParameters()
      ..offerType = [
        ProductSearchResultsEntity.productFreeOfferType,
        ProductSearchResultsEntity.productSubscriptionOfferType,
      ]
      ..requestedFacet = [
        ProductSearchResultsEntity.themeFacet,
        ProductSearchResultsEntity.languageFacet,
      ]
      ..isAdultContent = false
      ..collectionId = collectionId;
    // ..sort = [ProductSearchResultsEntity.];
    final searchResultLength =
        await productSearchRepository.searchProducts(searchParams, '', 0);
    final ProductSearchParameters searchParams2 = ProductSearchParameters()
      ..offerType = [
        ProductSearchResultsEntity.productFreeOfferType,
        ProductSearchResultsEntity.productSubscriptionOfferType,
      ]
      ..take = searchResultLength.totalResults
      ..requestedFacet = [
        ProductSearchResultsEntity.themeFacet,
        ProductSearchResultsEntity.languageFacet,
      ]
      ..isAdultContent = false
      ..collectionId = collectionId;

    final searchResult =
        await productSearchRepository.searchProducts(searchParams2, '', 0);

    return searchResult.products!;
  }

  // Order player sequences by renaming the files
  Future<List<AudioChapterEntity>> _orderPlayerSequences(
      List<AudioChapterEntity> playlistItems) async {
    if (!Platform.isIOS) {
      // Do nothing if the platform is not iOS
      return playlistItems;
    }

    try {
      final list = playlistItems
          .sorted(
            (a, b) => a.mediaRealPath?.compareTo(b.mediaRealPath ?? '') ?? 0,
          )
          .indexed
          .map(
        (chapterIndexed) {
          // Update order id
          chapterIndexed.$2.orderId = chapterIndexed.$1;
          return chapterIndexed.$2;
        },
      ).toList();

      return list;
    } catch (e) {
      logError('Error while reordering player sequences: $e', error: e);
      return playlistItems;
    }
  }

  Future<void> _onPlayerPositionChanged(Duration position,
      {required AudioInitResult initializations}) async {
    const secondsBeforeStoppingExtract = 5;

    if (initializations.hasExtractRestrictions) {
      if (_player.currentIndex == initializations.extractChapterIndex) {
        if (position.inSeconds >=
            ((initializations.chapterStopSeconds?.toInt() ?? 0) -
                secondsBeforeStoppingExtract)) {
          await _player.stop();

          if (state is AudioPlayerLoadedState) {
            final currentState = state as AudioPlayerLoadedState;
            emit(
              AudioExtractStopTimeReachedState(
                chapters: currentState.chapters,
                product: currentState.product,
                collection: currentState.collection,
                isProductCollection: currentState.isProductCollection,
                hasExtractRestrictions: currentState.hasExtractRestrictions,
                isPremium: currentState.isPremium,
                extractChapterIndex: currentState.extractChapterIndex,
                chapterStopSeconds: currentState.chapterStopSeconds,
                currentChapterIndex: currentState.currentChapterIndex,
              ),
            );
          }

          return;
        }
      }
    }
  }

  @override
  Future<void> close() {
    _durationSubscription?.cancel();

    return super.close();
  }
}
