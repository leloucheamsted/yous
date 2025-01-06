import 'dart:async';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class UnzipEpubUseCase
    extends AsyncUseCase<({String zipPath, String? password}), File> {
  @override
  FutureOr<void> onStart(({String zipPath, String? password})? params) {
    if (params == null) {
      throw const ClientException('You must provide a file');
    }
  }

  @override
  FutureOrResult<File> execute(
    ({
      String zipPath,
      String? password,
    })? params,
  ) async {
    final File sourceFile = File(params!.zipPath);

    if (!sourceFile.existsSync()) {
      throw const ClientException('No file existe with this path');
    }

    final fileNameWithoutExtension =
        sourceFile.path.split('.').first.split('/').last;
    final outFolder = '${(await getTemporaryDirectory()).path}'
        '$fileNameWithoutExtension';
    final outPath = params.zipPath.replaceAll('.zip', '.epub');

    await extractFileToDisk(sourceFile.path, outFolder,
        password: params.password);

    try {
      final archive = createArchiveFromDirectory(
        Directory(outFolder),
        includeDirName: false,
      );

      // Create epub file
      final output = OutputFileStream("$outPath.temp"); //temp, then rename

      ZipEncoder()
        ..startEncode(output)
        ..encode(archive, output: output)
        ..endEncode();

      await output.close();
      await sourceFile.delete();

      final finalFile = File("$outPath.temp");
      await finalFile.rename(outPath);
    } catch (e) {
      throw ClientException('Unzip failed: epub creation failed Exception: $e');
    }

    return Ok(File(outPath));
  }
}
