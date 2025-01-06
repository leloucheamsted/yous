import 'dart:async';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class UnzipMp3UseCase
    extends AsyncUseCase<({String zipPath, String? password}), File> {
  // FileService _fileService = locator();

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
    //NOTE: Find out why the freelancers delayed for 5 seconds here.
    // ignore: inference_failure_on_instance_creation
    await Future.delayed(const Duration(seconds: 5));
    final File sourceFile = File(params!.zipPath);
    if (!sourceFile.existsSync()) {
      throw const ClientException('No file exists with this path');
    }

    final outPath = sourceFile.path.replaceAll('.zip', '.mp3');
    final temporaryFolderPath = '${sourceFile.parent.path}/temp';
    await extractFileToDisk(sourceFile.path, temporaryFolderPath,
        password: params.password);

    Directory(temporaryFolderPath).renameSync(outPath);
    await sourceFile.delete();
    return Ok(File(outPath));
  }
}
