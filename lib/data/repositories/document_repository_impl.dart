import 'package:pointycastle/asymmetric/api.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/product_download_progress_entity.dart';
import 'package:youscribe/core/repositories/document_repository.dart';
import 'package:youscribe/data/data_sources/document_data_sources/document_local_data_source.dart';
import 'package:youscribe/data/data_sources/document_data_sources/document_remote_data_source.dart';
import 'package:youscribe/data/data_sources/document_data_sources/product_download_progress_local_data_source.dart';

class DocumentRepositoryImpl extends DocumentRepository {
  DocumentRepositoryImpl({
    required DocumentRemoteDataSource documentRemoteDataSource,
    required DocumentLocalDataSource documentLocalDataSource,
    required ProductDownloadProgressLocalDataSource productDownloadDataSource,
  })  : _documentRemoteDataSource = documentRemoteDataSource,
        _productDownloadDataSource = productDownloadDataSource,
        _documentLocalDataSource = documentLocalDataSource;

  final DocumentRemoteDataSource _documentRemoteDataSource;
  final DocumentLocalDataSource _documentLocalDataSource;
  final ProductDownloadProgressLocalDataSource _productDownloadDataSource;

  @override
  FutureOrResult<String?> getEncryptedDocumentPassword(
    int documentFormatId,
    RSAPublicKey publicKey,
  ) =>
      Result.tryCatchAsync(
        () => _documentRemoteDataSource.getEncryptedDocumentPassword(
          documentFormatId,
          publicKey,
        ),
        (error) =>
            error is AppException ? error : ServerException(error.toString()),
      );

  @override
  FutureOrResult<String?> getLocalDocumentPassword(int productId) =>
      //TRY CATCHING
      Result.tryCatchAsync(
        () => _documentLocalDataSource.getLocalDocumentPassword(productId),
        (error) =>
            error is AppException ? error : ServerException(error.toString()),
      );

  @override
  FutureOrResult<void> storeLocalDocumentPassword(
    int productId,
    String password,
  ) =>
      Result.tryCatchAsync(
        () => _documentLocalDataSource.storeLocalDocumentPassword(
          productId,
          password,
        ),
        (error) =>
            error is AppException ? error : ServerException(error.toString()),
      );

  @override
  Future<ProductDownloadProgressEntity?>
      readProductDownloadProgressForDownloadTask(String downloadTaskId) {
    // TODO: implement readProductDownloadProgressForDownloadTask
    return _productDownloadDataSource
        .readProductDownloadProgressForDownloadTask(downloadTaskId);
  }

  @override
  Future<ProductDownloadProgressEntity?> readProductDownloadProgressForProduct(
      int productId) {
    // TODO: implement readProductDownloadProgressForProduct
    return _productDownloadDataSource
        .readProductDownloadProgressForProduct(productId);
  }

  @override
  Future<ProductDownloadProgressEntity> saveProductDownloadProgress(
      ProductDownloadProgressEntity entity) {
    // TODO: implement saveProductDownloadProgress
    return _productDownloadDataSource.saveProductDownloadProgress(entity);
  }

  @override
  Future<void> deleteProductDownloadProgressForProduct(int productId) {
    // TODO: implement deleteProductDownloadProgressForProduct
    return _productDownloadDataSource
        .deleteProductDownloadProgressForProduct(productId);
  }

  @override
  Future<void> deleteAllDownloadProgress() {
    return _productDownloadDataSource.deleteProductDownloadProgress();
  }

  @override
  Future<List<ProductDownloadProgressEntity>> getAllProductDownloadProgress() =>
      _productDownloadDataSource.getAllProductDownloadProgress();
}
