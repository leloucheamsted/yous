import 'package:youscribe/core/entities/product_download_progress_entity.dart';

abstract class ProductDownloadProgressLocalDataSource {
  Future<ProductDownloadProgressEntity> saveProductDownloadProgress(
      ProductDownloadProgressEntity entity);
  Future<ProductDownloadProgressEntity?>
      readProductDownloadProgressForDownloadTask(String downloadTaskId);
  Future<ProductDownloadProgressEntity?> readProductDownloadProgressForProduct(
      int productId);
  Future<List<ProductDownloadProgressEntity>> getAllProductDownloadProgress();
  Future<void> deleteProductDownloadProgressForProduct(int productId);
  Future<void> deleteProductDownloadProgress();
}
