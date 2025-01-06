import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/product_download_progress_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/repositories/document_repository.dart';

class GetProductProgress
    extends AsyncUseCase<ProductEntity, ProductDownloadProgressEntity?> {
  GetProductProgress({required DocumentRepository documentRepository})
      : _documentRepository = documentRepository;

  final DocumentRepository _documentRepository;
  @override
  FutureOrResult<ProductDownloadProgressEntity?> execute(
          ProductEntity? params) =>
      Result.tryCatchAsync(
          () => _documentRepository
              .readProductDownloadProgressForProduct(params!.id!),
          (error) => error is AppException
              ? error
              : ClientException(error.toString()));
}
