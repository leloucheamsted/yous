// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/app_settings.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/audio_chapter_entity.dart';
import 'package:youscribe/core/entities/bookmark_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/infrastructure/file_service.dart';
import 'package:youscribe/core/repositories/bookmark_repository.dart';
import 'package:youscribe/core/repositories/products_repository.dart';
import 'package:youscribe/core/use_cases/products/check_product_access_rights_use_case.dart';
import 'package:youscribe/data/data_sources/product_data_sources/product_chapters_local_data_source.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class InitAudioPlayerUseCase
    extends AsyncUseCase<InitAudioPlayerUseCaseParams, AudioInitResult>
    with Debuggable, Loggable {
  final ProductRepository _productRepository = locator();
  final ProductChaptersLocalDataSource _chaptersLocalDataSource = locator();
  final BookmarkRepository _bookmarkRepository = locator();
  final AppSettings _appSettings = locator();
  final FileService _fileService = locator();
  final ConnectivityService _connectivityService =
      locator<ConnectivityService>();

  @override
  String get debugName => 'InitAudioPlayerUseCase';

  @override
  FutureOrResult<AudioInitResult> execute(
      InitAudioPlayerUseCaseParams? params) async {
    try {
      var chapters = await _chaptersLocalDataSource
          .readAudioChaptersForProduct(params!.productId);
      final user = await AuthenticationManager.getCurrentUser();
      List<String> audioFilePaths = [];

      if (chapters.isNullOrEmpty &&
          params.productAccessState == ProductAccessState.canStream) {
        logWarning(
            // ignore: lines_longer_than_80_chars
            "Local chapters for product: ${params.productId} Not found in local database");
        final audioInfo = await _productRepository
            .getAudioBookInfoFromStreamingAPI(params.productId);
        await _chaptersLocalDataSource.saveAudioChaptersForProduct(
            params.productId, chapters);
        chapters = audioInfo.playlistModel!;
      } else {
        audioFilePaths = await _fileService.getAudioChapterPaths(
            user!.id!, params.productId);
      }

      int index = 0;
      int? extractIndex;
      bool hasExtract = false;
      for (final element in chapters) {
        if (params.productAccessState == ProductAccessState.canStream) {
          element.mediaUrl =
              "${_appSettings.apiStreamingURL}${params.productId}/documents/${element.documentId}/audio/stream";

          final dur = element.chapterDuration == null
              ? 0
              : double.parse(element.chapterDuration!.toStringAsFixed(2));
          final realDur = element.chapterRealDuration == null
              ? 0
              : double.parse(element.chapterRealDuration!.toStringAsFixed(2));
          element.isExtract = dur < realDur || element.chapterDuration == 0;
          if (element.isExtract! && !hasExtract) {
            extractIndex = index;
            hasExtract = true;
          }
        } else {
          if (index >= audioFilePaths.length) {
            logError(
                // ignore: lines_longer_than_80_chars
                "More online chapters for product ${params.productId} than local chapters.");
            break;
          }
          element.mediaRealPath = audioFilePaths[index];
        }

        element.orderId = index;
        index++;
      }

      BookmarkEntity? bookmark;
      if (await _connectivityService.isInternetAvailable) {
        final books = await _bookmarkRepository.getBookmarkAsync();
        final boks =
            books.where((element) => element.productId == params.productId);

        if (boks.isNotEmpty) {
          final booksOf = await _bookmarkRepository
              .retrieveValidBookmarks(params.productId);
          final boksOff = booksOf
              ?.where((element) => element.productId == params.productId);
          if (boksOff!.isNotEmpty) {
            final off = boksOff
                .firstWhere((element) => element.productId == params.productId);
            final on = boks
                .firstWhere((element) => element.productId == params.productId);
            if (off.pageNumber > on.pageNumber) {
              bookmark = off;
            } else if (off.pageNumber < on.pageNumber) {
              bookmark = on;
            } else {
              if (off.progress > on.progress) {
                bookmark = off;
              } else {
                bookmark = on;
              }
            }
          } else {
            bookmark = boks
                .firstWhere((element) => element.productId == params.productId);
          }
        }
      } else {
        final books =
            await _bookmarkRepository.retrieveValidBookmarks(params.productId);
        final boks =
            books?.where((element) => element.productId == params.productId);

        if (boks!.isNotEmpty) {
          bookmark = boks
              .firstWhere((element) => element.productId == params.productId);
        }
      }

      if (params.productAccessState == ProductAccessState.canStream) {
        final result = AudioInitResult(
            chapters: chapters,
            bookmark: bookmark,
            extractChapterIndex: extractIndex,
            chapterStopSeconds: extractIndex == null
                ? null
                : chapters[extractIndex].chapterDuration ?? 0,
            hasExtractRestrictions: hasExtract);
        return Ok(result);
      }

      return Ok(AudioInitResult(chapters: chapters, bookmark: bookmark));
    } on APIRequestException catch (e) {
      return Err(e);
    } catch (e, s) {
      logError(
        // ignore: lines_longer_than_80_chars
        "Fatal error while initializing audio player for product: $params",
        error: Exception(e), stackTrace: s,
      );
      rethrow;
    }
  }
}

class InitAudioPlayerUseCaseParams {
  InitAudioPlayerUseCaseParams({
    required this.productAccessState,
    required this.productId,
  });

  ProductAccessState productAccessState;
  int productId;

  @override
  String toString() {
    return "Product:$productId, state:$productAccessState";
  }
}

class AudioInitResult {
  AudioInitResult({
    required this.chapters,
    this.hasExtractRestrictions = false,
    this.isPremium = false,
    this.extractChapterIndex = 0,
    this.chapterStopSeconds = 0,
    this.bookmark,
  });

  bool hasExtractRestrictions;
  bool isPremium;
  int? extractChapterIndex;
  List<AudioChapterEntity> chapters;
  double? chapterStopSeconds;
  BookmarkEntity? bookmark;
}
