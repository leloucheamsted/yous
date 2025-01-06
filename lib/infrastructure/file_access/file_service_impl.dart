import 'dart:io';

import 'package:path/path.dart' as path_helper;
import 'package:path_provider/path_provider.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/infrastructure/file_service.dart';

class FileServiceImpl implements FileService {
  @override
  late String basePath;
  late Directory _baseDirectory;

  @override
  Future<void> initialize() async {
    if (Platform.isIOS) {
      _baseDirectory = await getApplicationDocumentsDirectory();
    } else {
      _baseDirectory = (await getExternalStorageDirectory())!;
    }
    basePath = _baseDirectory.path;
  }

  @override
  Future<String> getProductFilePath(
      int userId, int productId, String extension) async {
    await _ensureFolderPathsExist(userId);
    final ext = extension.replaceAll(".", "");
    final path = '$basePath/$userId/$ext/$productId.$ext';
    return path;
  }

  @override
  Future<String> getProductRelativeFolderPath(
      int userId, String extension) async {
    await _ensureFolderPathsExist(userId);
    final ext = extension.replaceAll(".", "");
    final path = '$userId/$ext';
    return path;
  }

  @override
  Future<String> getProductFilePathWithoutExtension(
      int userId, int productId) async {
    await _ensureFolderPathsExist(userId);

    final epubPath = await getProductFilePath(userId, productId, "epub");
    if (File(epubPath).existsSync()) {
      return epubPath;
    }

    final pdfPath = await getProductFilePath(userId, productId, "pdf");
    if (File(pdfPath).existsSync()) {
      return pdfPath;
    }

    final mp3Path = await getProductFilePath(userId, productId, "mp3");
    if (File(mp3Path).existsSync()) {
      return mp3Path;
    } else if (Directory(mp3Path).existsSync()) {
      return mp3Path;
    }

    return '';
  }

  Future<void> _ensureFolderPathsExist(int userId) async {
    // ignore: unnecessary_null_comparison
    if (basePath == null) {
      await initialize();
    }
    final mp3Path = '$basePath/$userId/mp3';
    final pdfPath = '$basePath/$userId/pdf';
    final epubPath = '$basePath/$userId/epub';
    for (final path in [mp3Path, pdfPath, epubPath]) {
      final directory = Directory(path);
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }
    }
  }

  @override
  Future<List<String>> getFilesInDirectory(
      String directory, String fileType) async {
    final dir = Directory(directory);
    if (dir.existsSync()) {
      return dir
          .listSync()
          .whereType<File>()
          .where((file) {
            return file.path.endsWith(fileType);
          })
          .map((file) => file.path)
          .toList();
    } else {
      return <String>[];
    }
  }

  @override
  Future<String> getProductTempFilePath(
      int userId, int productId, String extension) async {
    final path = await getProductFilePath(userId, productId, extension);
    return '$path.tmp';
  }

  @override
  Future<bool> productFileExists(
      int userId, int productId, String extension) async {
    final path = await getProductFilePath(userId, productId, extension);
    final file = File(path);
    final directory = Directory(path);

    return file.existsSync() || directory.existsSync();
  }

  @override
  Future<void> deleteProductFiles(int userId, Iterable<int> productIds) async {
    for (final productId in productIds) {
      await deleteProductFile(userId, productId);
    }
  }

  @override
  Future<void> moveFile(String sourcePath, String destinationPath) async {
    final sourceFile = File(sourcePath);

    if (sourceFile.existsSync()) {
      sourceFile.renameSync(destinationPath);
    }
  }

  @override
  Future<void> deleteProductFile(int userId, int productId,
      [String? extension]) async {
    String path;

    if (extension != null) {
      path = await getProductFilePath(userId, productId, extension);
    } else {
      path = await getProductFilePathWithoutExtension(userId, productId);
    }

    final file = File(path);
    final extensionType = path_helper.extension(path).replaceAll(".", "");

    if (file.existsSync()) {
      file.deleteSync();
    }

    if (extensionType.contains("mp3")) {
      final zipFile = File(path.replaceAll(".mp3", ".zip"));
      if (zipFile.existsSync()) {
        zipFile.deleteSync();
      }
      final mp3File = File(path);
      if (mp3File.existsSync()) {
        mp3File.deleteSync();
      }

      final mp3Directory = Directory(path);
      if (mp3Directory.existsSync()) {
        mp3Directory.deleteSync(recursive: true);
      }
    }

    if (extensionType.contains("epub")) {
      final newPath = path.replaceAll(".epub", ".json");
      final newFile = File(newPath);
      final epubFile = File(path);
      final zipFile = File(path.replaceAll(".epub", ".zip"));
      if (zipFile.existsSync()) {
        zipFile.deleteSync();
      }
      if (newFile.existsSync()) {
        newFile.deleteSync();
      }
      if (epubFile.existsSync()) {
        epubFile.deleteSync();
      }
    }
  }

  String getLogsPath() {
    return '${Directory.systemTemp.path}/Logs/';
  }

  @override
  Future<void> deleteEveryBook(int userId) async {
    final mp3Path = '$basePath/$userId/mp3';
    final pdfPath = '$basePath/$userId/pdf';
    final epubPath = '$basePath/$userId/epub';
    for (final path in [mp3Path, pdfPath, epubPath]) {
      final directory = Directory(path);
      if (directory.existsSync()) {
        directory.deleteSync(recursive: true);
      }
    }
  }

  DateTime getFileCreationDate(String path) {
    final file = File(path);
    return file.statSync().changed;
  }

  @override
  Future<List<LocalBook>> getEveryDownloadedBook(int userId) async {
    final List<LocalBook> pathList = [];

    final mp3Path = '$basePath/$userId/mp3';
    if (Directory(mp3Path).existsSync()) {
      final dirs =
          Directory(mp3Path).listSync().whereType<Directory>().toList();
      final files = Directory(mp3Path).listSync().whereType<File>().toList();

      if (dirs.isNotEmpty) {
        for (final dir in dirs) {
          final productId = int.tryParse(dir.uri.pathSegments.last) ?? 0;
          pathList.add(LocalBook(productId, "mp3", dir.statSync().changed));
        }
      }

      if (files.isNotEmpty) {
        for (final file in files) {
          if (path_helper.extension(file.path).toLowerCase().contains("tmp")) {
            file.deleteSync();
            continue;
          }

          final productId =
              int.tryParse(path_helper.basenameWithoutExtension(file.path)) ??
                  0;
          pathList
              .add(LocalBook(productId, "mp3", getFileCreationDate(file.path)));
        }
      }
    }

    final pdfPath = '$basePath/$userId/pdf';
    if (Directory(pdfPath).existsSync()) {
      final files = Directory(pdfPath).listSync().whereType<File>().toList();
      if (files.isNotEmpty) {
        for (final file in files) {
          if (path_helper.extension(file.path).toLowerCase().contains("tmp")) {
            file.deleteSync();
            continue;
          }
          final productId =
              int.tryParse(path_helper.basenameWithoutExtension(file.path)) ??
                  0;
          pathList
              .add(LocalBook(productId, "pdf", getFileCreationDate(file.path)));
        }
      }
    }

    final epubPath = '$basePath/$userId/epub';
    if (Directory(epubPath).existsSync()) {
      final files = Directory(epubPath).listSync().whereType<File>().toList();
      if (files.isNotEmpty) {
        for (final file in files) {
          if (path_helper.extension(file.path).toLowerCase().contains("tmp")) {
            file.deleteSync();
            continue;
          }
          final productId =
              int.tryParse(path_helper.basenameWithoutExtension(file.path)) ??
                  0;
          pathList.add(
              LocalBook(productId, "epub", getFileCreationDate(file.path)));
        }
      }
    }

    return pathList;
  }

  @override
  Future<String> getProductFileName(int productId, String extension) async {
    return '$productId.$extension';
  }

  @override
  Future<String?> getProductZipPath(
    int userId,
    int productId,
    String type,
  ) async {
    await _ensureFolderPathsExist(userId);
    final path = '$basePath/$userId/$type/$productId.zip';

    if (File(path).existsSync()) {
      return path;
    }

    return null;
  }

  @override
  Future<bool> productFileZipExists(
      int userId, int productId, String type) async {
    final path = '$basePath/$userId/$type/$productId.zip';

    final file = File(path);
    final directory = Directory(path);

    return file.existsSync() || directory.existsSync();
  }

  @override
  String getDatabasePath() {
    final dbPath = "$basePath/db";

    final dir = Directory(dbPath);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }

    return dbPath;
  }

  @override
  Future<List<String>> getAudioChapterPaths(int userId, int productId) async {
    final folderPath =
        await getProductFilePath(userId, productId, ProductEntity.mp3Extension);
    final dir = Directory(folderPath);
    final items = dir.listSync();

    return items.map((element) => element.path).toList();
  }
}
