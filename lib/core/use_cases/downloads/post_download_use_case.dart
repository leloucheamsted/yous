import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/use_cases/products/unzip_epub_use_case.dart';
import 'package:youscribe/core/use_cases/products/unzip_mp3_use_case.dart';

class PostDownloadUseCase
    extends AsyncUseCase<PostDownloadUseCaseParameters, void> {
  PostDownloadUseCase({
    required UnzipEpubUseCase unzipEpubUseCase,
    required UnzipMp3UseCase unzipMp3UseCase,
  })  : _unzipEpubUseCase = unzipEpubUseCase,
        _unzipMp3UseCase = unzipMp3UseCase;

  final UnzipEpubUseCase _unzipEpubUseCase;
  final UnzipMp3UseCase _unzipMp3UseCase;

  @override
  FutureOrResult<void> execute(PostDownloadUseCaseParameters? params) async {
    if (params!.extension == ProductEntity.epubExtension) {
      await _unzipEpubUseCase(
        (
          zipPath: params.filePath,
          password: params.password,
        ),
      );
    } else if (params.extension == ProductEntity.mp3Extension) {
      await _unzipMp3UseCase(
        (zipPath: params.filePath, password: params.password),
      );
    }

    return const Ok(null);
  }
}

class PostDownloadUseCaseParameters {
  PostDownloadUseCaseParameters(
      this.productId, this.password, this.filePath, this.extension);

  int productId;
  String password;
  String filePath;
  String extension;
}
