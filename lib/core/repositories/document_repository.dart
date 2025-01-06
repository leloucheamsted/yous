import 'package:pointycastle/export.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:youscribe/core/entities/product_download_progress_entity.dart';

abstract class DocumentRepository extends BaseRepository {
  //TODO: Add product Id
  FutureOrResult<String?> getLocalDocumentPassword(int productId);
  //TODO: Add product Id
  FutureOrResult<String?> getEncryptedDocumentPassword(
    int documentFormatId,
    RSAPublicKey publicKey,
  );
  FutureOrResult<void> storeLocalDocumentPassword(
    int productId,
    String password,
  );
  Future<ProductDownloadProgressEntity> saveProductDownloadProgress(
      ProductDownloadProgressEntity entity);
  Future<ProductDownloadProgressEntity?>
      readProductDownloadProgressForDownloadTask(String downloadTaskId);
  Future<ProductDownloadProgressEntity?> readProductDownloadProgressForProduct(
      int productId);
  Future<List<ProductDownloadProgressEntity>> getAllProductDownloadProgress();
  Future<void> deleteProductDownloadProgressForProduct(int productId);
  Future<void> deleteAllDownloadProgress();
}
