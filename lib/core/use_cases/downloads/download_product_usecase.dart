import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path/path.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:watcher/watcher.dart';
import 'package:workmanager/workmanager.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/current_user_account_entity.dart';
import 'package:youscribe/core/entities/product_download_progress_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/infrastructure/file_service.dart';
import 'package:youscribe/core/repositories/document_repository.dart';
import 'package:youscribe/core/repositories/products_repository.dart';
import 'package:youscribe/core/repositories/repository_constants.dart';
import 'package:youscribe/core/use_cases/downloads/get_document_password_use_case.dart';
import 'package:youscribe/data/data_sources/product_data_sources/product_chapters_local_data_source.dart';
import 'package:youscribe/infrastructure/background_service/service_name.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe/utilities/view_utilities.dart';
import 'package:youscribe_analytics/youscribe_analytics.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class DownloadProductUseCase extends AsyncUseCase<
    DownloadProductUseCaseParameters,
    DownloadProductUseCaseResult> with Debuggable, Loggable, Trackable {
  DownloadProductUseCase(
    this._fileService,
    this._productRepository,
    this._fileDownloader,
    this._documentRepository,
  ) : _getDocumentPasswordUseCase = locator();

  final ProductChaptersLocalDataSource _chaptersLocalDataSource = locator();
  final FileService _fileService;
  final ProductRepository _productRepository;
  final DocumentRepository _documentRepository;
  final GetDocumentPasswordUseCase _getDocumentPasswordUseCase;
  // ignore: unused_field
  final FlutterDownloader _fileDownloader;
  final List<TaskInfo> _downloadTasks = [];
  final StreamController<DownloadProgressWithStatus> _downloadController =
      StreamController<DownloadProgressWithStatus>.broadcast();
  Stream<DownloadProgressWithStatus> get downloadProgressStream =>
      _downloadController.stream;
  late CurrentUserAccountEntity? currentUser;

  @override
  String get debugName => "DownloadProductUseCase";

  Future<void> _downloadStatesListener(TaskInfo event) async {
    ProductDownloadProgressEntity? savedDownloadProgress;

    currentUser ??= await AuthenticationManager.getCurrentUser();

    try {
      // _logger.logInfo(

      savedDownloadProgress = await _documentRepository
          .readProductDownloadProgressForDownloadTask(event.taskId ?? '');

      if (savedDownloadProgress == null) {
        logWarning(
          '''No saved download progress for task listened to ${event.taskId}''',
        );
        return;
      }
      savedDownloadProgress.progress = event.progress!.toDouble();
      switch (event.status) {
        case DownloadTaskStatus.complete:
          logInfo('Task ${event.taskId} success!');
          final zipPath = await _fileService.getProductZipPath(
            currentUser!.id!,
            savedDownloadProgress.productId,
            savedDownloadProgress.productExtension,
          );
          logInfo('Unzipping file at $zipPath');
          if (zipPath != null) {
            //Unzip the file in background.

            await Workmanager().registerOneOffTask(
              ServiceName.unzip, //savedDownloadProgress.productId.toString(),
              ServiceName.unzip,
              tag: ServiceName.unzip,
              initialDelay: const Duration(seconds: 1),
              inputData: {
                'productId': savedDownloadProgress.productId,
                'password': savedDownloadProgress.password,
                'filePath': zipPath,
                'productExtension': savedDownloadProgress.productExtension,
              },
            );
          }

          final productPath = await _fileService.getProductFilePath(
              currentUser!.id!,
              savedDownloadProgress.productId,
              savedDownloadProgress.productExtension);

          logInfo('Waiting for file at $productPath');

          await waitForFile(
                  File(productPath).parent.path,
                  basename(productPath),
                  savedDownloadProgress.productId,
                  savedDownloadProgress.productExtension)
              .then((value) async {
            logInfo('File at $productPath is ready');
            final RxSharedPreferences rx = locator();
            final List<String> downloadedFiles =
                await rx.getStringList(PreferenceKey.isDownloaded) ?? [];
            // ignore: cascade_invocations
            downloadedFiles.remove(savedDownloadProgress!.productId.toString());
            await rx.setStringList(
                PreferenceKey.isDownloaded, [...downloadedFiles]);
          });

          savedDownloadProgress.path = productPath;
          savedDownloadProgress.progress = 100;
          _downloadController.addWithCheck(DownloadProgressWithStatus(
              savedDownloadProgress, DownloadProgressState.completed));
          await _documentRepository.deleteProductDownloadProgressForProduct(
              savedDownloadProgress.productId);
        // await _delete(event);
        case DownloadTaskStatus.canceled:
          logInfo(
              // ignore: lines_longer_than_80_chars
              'Task ${event.taskId} For Product: ${savedDownloadProgress.productId} canceled!');
          _downloadController.addWithCheck(DownloadProgressWithStatus(
              savedDownloadProgress, DownloadProgressState.cancelled));
          await _documentRepository.deleteProductDownloadProgressForProduct(
              savedDownloadProgress.productId);
        // await _delete(event);
        case DownloadTaskStatus.paused:
          logWarning(
              // ignore: lines_longer_than_80_chars
              'Task ${event.taskId}  For Product: ${savedDownloadProgress.productId} paused!');
          _downloadController.addWithCheck(DownloadProgressWithStatus(
              savedDownloadProgress, DownloadProgressState.paused));
          await tracker.trackDownloadPaused(
            productId: savedDownloadProgress.productId.toString(),
          );
        // await _resumeDownload(event);
        case DownloadTaskStatus.enqueued:
          logInfo(
              // ignore: lines_longer_than_80_chars
              'Task ${event.taskId}  For Product: ${savedDownloadProgress.productId} enqueued!');
          savedDownloadProgress.progress = event.progress?.toDouble() ?? 0;
          if (savedDownloadProgress.progress != 100) {
            await _documentRepository
                .saveProductDownloadProgress(savedDownloadProgress);
          } else if (savedDownloadProgress.progress == 100) {
            //Wait at 99% to ensure the file is extracted if necessary.
            savedDownloadProgress.progress = 97;
          }
          final returnedValue = DownloadProgressWithStatus(
              savedDownloadProgress, DownloadProgressState.downloading);
          _downloadController.addWithCheck(returnedValue);
        case DownloadTaskStatus.undefined:
          logInfo(
              // ignore: lines_longer_than_80_chars
              'Task ${event.taskId}  For Product: ${savedDownloadProgress.productId} undefined!');
        case DownloadTaskStatus.failed:
          logWarning(
              // ignore: lines_longer_than_80_chars
              'Task ${event.taskId}  For Product: ${savedDownloadProgress.productId} waiting to retry!');
          final returnedValue = DownloadProgressWithStatus(
              savedDownloadProgress, DownloadProgressState.failed);
          _downloadController.addWithCheck(returnedValue);
        case DownloadTaskStatus.running:
          savedDownloadProgress.progress = event.progress?.toDouble() ?? 0;

          if (savedDownloadProgress.progress != 100) {
            await _documentRepository
                .saveProductDownloadProgress(savedDownloadProgress);
          } else if (savedDownloadProgress.progress == 100) {
            //Wait at 99% to ensure the file is extracted if necessary.
            savedDownloadProgress.progress = 97;
          }
          final returnedValue = DownloadProgressWithStatus(
              savedDownloadProgress, DownloadProgressState.downloading);
          _downloadController.addWithCheck(returnedValue);
        default:
          logWarning(
              // ignore: lines_longer_than_80_chars
              'Task ${event.taskId} For Product: ${savedDownloadProgress.productId} failed! With Status: ${event.status}');
          await tracker.trackDownloadFailed(
            productId: savedDownloadProgress.productId.toString(),
          );
      }
    } catch (exception, stackTrace) {
      logError(
        '''Unexpected Error while monitoring download progress. Percentage Failed At: ${savedDownloadProgress?.progress ?? 0}''',
        error: exception as Exception?,
        stackTrace: stackTrace,
        methodName: '_downloadStatesListener',
      );

      if (savedDownloadProgress != null) {
        savedDownloadProgress.progress = 0;
        final returnedValue = DownloadProgressWithStatus(
            savedDownloadProgress, DownloadProgressState.failed);
        _downloadController.addWithCheck(returnedValue); //
        await _documentRepository.deleteProductDownloadProgressForProduct(
            savedDownloadProgress.productId);
      }
    }
  }

  void listenToDownloadStates() {
    locator<ReceivePort>().listen((data) async {
      final taskId = (data as List<dynamic>)[0] as String;
      final status = DownloadTaskStatus.fromInt(data[1] as int);
      final progress = data[2] as int;
      final task = TaskInfo()
        ..taskId = taskId
        ..status = status
        ..progress = progress;

      if (_downloadTasks.isNotEmpty) {
        final task = _downloadTasks.firstWhere((task) => task.taskId == taskId);
        task
          ..status = status
          ..progress = progress;
      }
      ProductDownloadProgressEntity? savedDownloadProgress;
      savedDownloadProgress = await _documentRepository
          .readProductDownloadProgressForDownloadTask(taskId);

      if (savedDownloadProgress == null) {
        logWarning("No saved download progress for task listened to $taskId");
        return;
      }
      savedDownloadProgress.progress = progress.toDouble();
      await _downloadStatesListener(task);
    });
  }

  @override
  FutureOr<void> onStart(DownloadProductUseCaseParameters? params) {
    if (params == null) {
      throw ArgumentError.notNull(
          'You must provide a DownloadProductParameters');
    }
  }

  Future<void> _saveAudioBookChapters(int productId) async {
    try {
      final audioInfo =
          await _productRepository.getAudioBookInfoFromStreamingAPI(productId);
      await _chaptersLocalDataSource.deleteAudioChaptersForProduct(productId);
      await _chaptersLocalDataSource.saveAudioChaptersForProduct(
          productId, audioInfo.playlistModel ?? []);
    } catch (e, s) {
      logError(
        '''Error while loading and saving audio chapters for product: $productId''',
        error: Exception(e),
        stackTrace: s,
      );
    }
  }

  @override
  FutureOrResult<DownloadProductUseCaseResult> execute(
      DownloadProductUseCaseParameters? params) async {
    currentUser = await AuthenticationManager.getCurrentUser();
    logInfo(
        "Downloading product ${params!.productId} for user ${currentUser?.id}");

    final productFileName = await _fileService.getProductFileName(
      params.productId,
      params.extension,
    );

    final zipProductFileName = switch (params.extension) {
      ProductEntity.epubExtension =>
        productFileName.replaceAll('.epub', '.zip'),
      ProductEntity.mp3Extension => productFileName.replaceAll('.mp3', '.zip'),
      _ => productFileName,
    };

    final productDir = await _fileService.getProductRelativeFolderPath(
        currentUser!.id!, params.extension);

    final productFinalPath = await _fileService.getProductFilePath(
        currentUser!.id!, params.productId, params.extension);
    final savedDir = Directory("${_fileService.basePath}/$productDir");
    if (!savedDir.existsSync()) {
      await savedDir.create();
    }
    //We make sure we delete the file if it exists.
    //This is for pure precaution, as the file should not exist at this point.
    await _fileService.deleteProductFile(currentUser!.id!, params.productId);

    var result = await _documentRepository.saveProductDownloadProgress(
        ProductDownloadProgressEntity(
            productId: params.productId,
            documentFormatId: 0,
            downloadTaskId: '',
            productExtension: params.extension,
            progress: 1,
            password: '',
            isUnzip: params.extension == ProductEntity.pdfExtension,
            path: productFinalPath));

    if (params.extension == ProductEntity.mp3Extension) {
      await _saveAudioBookChapters(params.productId);
    }

    //We send an initial download to the UI,
    //so that  it can display the download progress.
    _downloadController.addWithCheck(
        DownloadProgressWithStatus(result, DownloadProgressState.downloading));

    final (downloadUrl, documentFormatId) =
        await _productRepository.getProductDownloadURL(params.productId);

    final passResult = await _getDocumentPasswordUseCase(
        GetDocumentPasswordUseCaseParametters(
            documentFormatId, params.productId));

    if (passResult.isErr) {
      await _documentRepository
          .deleteProductDownloadProgressForProduct(params.productId);
      _downloadController.addWithCheck(DownloadProgressWithStatus(
          result..progress = 0, DownloadProgressState.failed));
      throw Exception("Unable to get password for product ${params.productId}");
    }

    final task = TaskInfo(name: params.productTitle, link: downloadUrl);
    try {
      task.taskId = await FlutterDownloader.enqueue(
          url: downloadUrl ?? '',
          headers: {RepositoryConstants.ysAuthHeader: currentUser!.token!},
          savedDir: "${_fileService.basePath}/$productDir",
          fileName: zipProductFileName);
      if (!task.taskId.isNotNullOrEmpty) {
        throw Exception(
            "Unable to enqueue download task for product ${params.productId}");
      }
    } catch (e) {
      logError(
        "an exception occurred while downloading the product",
        error: Exception(e),
      );
    }

    _downloadTasks.add(task);
    result = await _documentRepository.saveProductDownloadProgress(
      ProductDownloadProgressEntity(
        documentFormatId: documentFormatId!,
        path: productFinalPath,
        password: passResult.ok!,
        productId: params.productId,
        productExtension: params.extension,
        downloadTaskId: task.taskId ?? "",
        progress: 0,
        isUnzip: params.extension == ProductEntity.pdfExtension,
      ),
    );

    return Ok(DownloadProductUseCaseResult(result, documentFormatId));
  }

  void dispose() {
    _downloadController.close();
  }
}

class DownloadProductUseCaseParameters {
  DownloadProductUseCaseParameters({
    required this.productId,
    required this.productTitle,
    required this.extension,
  });

  final int productId;
  final String productTitle;
  final String extension;
}

class DownloadProductUseCaseResult {
  DownloadProductUseCaseResult(this.downloadProgress, this.documentFormatId);

  final ProductDownloadProgressEntity downloadProgress;
  final int? documentFormatId;
}

class DownloadProgressWithStatus {
  DownloadProgressWithStatus(this.downloadProgress, this.state);

  final ProductDownloadProgressEntity downloadProgress;
  final DownloadProgressState state;
}

Future<void> waitForFile(
    String folderPath, String fileName, int productId, String extension) async {
  final folder = Directory(folderPath);
  final RxSharedPreferences rx = locator();
  final List<String> downloadedFiles =
      await rx.getStringList(PreferenceKey.isDownloaded) ?? [];
  if (extension == ProductEntity.epubExtension ||
      extension == ProductEntity.mp3Extension) {
    await rx.setStringList(
        PreferenceKey.isDownloaded, [...downloadedFiles, productId.toString()]);
  }
  //TODO: when mp3s finish downloading, the watcher doesn't work.
  final file = File('${folder.path}/$fileName');
  final dir = Directory('${folder.path}/$fileName');

  if (file.existsSync() || dir.existsSync()) {
    return;
  }

  final completer = Completer<void>();

  if (Platform.isAndroid) {
    final watcher = folder.watch();

    // ignore: strict_raw_type
    StreamSubscription? watcherSub;

    Future<void> handleFolderChange(FileSystemEvent event) async {
      if ((event is FileSystemCreateEvent && event.path == file.path) ||
          (event is FileSystemMoveEvent && event.destination == file.path)) {
        completer.complete();
        await watcherSub?.cancel();
      }
    }

    watcherSub = watcher.listen(handleFolderChange);
  } else if (Platform.isIOS) {
    final watcher = DirectoryWatcher(folderPath);
    StreamSubscription<WatchEvent>? streamSub;

    Future<void> handleFolderChange(WatchEvent event) async {
      if (extension != ProductEntity.mp3Extension) {
        if ((event.type == ChangeType.ADD && event.path == file.path) ||
            (event.type == ChangeType.MODIFY && event.path == file.path)) {
          completer.complete();
          await streamSub?.cancel();
        }
      } else {
        if ((event.type == ChangeType.ADD) ||
            (event.type == ChangeType.MODIFY)) {
          completer.complete();
          await streamSub?.cancel();
        }
      }
    }

    streamSub = watcher.events.listen(handleFolderChange);
  }
  return completer.future;
}

class TaskInfo {
  TaskInfo({this.name, this.link});

  final String? name;
  final String? link;

  String? taskId;
  int? progress = 0;
  DownloadTaskStatus? status = DownloadTaskStatus.undefined;
}

class ItemHolder {
  ItemHolder({this.name, this.task});

  final String? name;
  final TaskInfo? task;
}
