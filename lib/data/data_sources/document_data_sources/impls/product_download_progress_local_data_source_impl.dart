import 'package:youscribe/core/entities/product_download_progress_entity.dart';
import 'package:youscribe/data/data_sources/document_data_sources/product_download_progress_local_data_source.dart';

class ProductDownloadProgressLocalDataSourceImpl
    implements ProductDownloadProgressLocalDataSource {
  //TODO: Later make this compatible with hive
  final List<ProductDownloadProgressEntity> _downloadProgressList = [];

  @override
  Future<ProductDownloadProgressEntity?>
      readProductDownloadProgressForDownloadTask(String downloadTaskId) {
    // TODO: implement readProductDownloadProgressForDownloadTask
    final result = _downloadProgressList
        .where((element) => element.downloadTaskId == downloadTaskId);

    if (result.isNotEmpty) {
      return Future.value(result.first);
    }

    return Future(() => null);
  }

  @override
  Future<ProductDownloadProgressEntity?> readProductDownloadProgressForProduct(
      int productId) {
    // TODO: implement readProductDownloadProgressForProduct

    if (_downloadProgressList.isEmpty) {
      return Future(() => null);
    }

    final result = _downloadProgressList
        .where((element) => element.productId == productId);

    if (result.isNotEmpty) {
      return Future.value(result.first);
    }

    return Future(() => null);
  }

  @override
  Future<ProductDownloadProgressEntity> saveProductDownloadProgress(
      ProductDownloadProgressEntity entity) {
    // TODO: implement saveProductDownloadProgress
    if (_downloadProgressList.any((element) =>
        element.downloadTaskId == entity.downloadTaskId ||
        element.productId == entity.productId)) {
      _downloadProgressList.removeWhere((element) =>
          element.downloadTaskId == entity.downloadTaskId ||
          element.productId == entity.productId);
    }

    _downloadProgressList.add(entity);
    return Future.value(entity);
  }

  @override
  Future<void> deleteProductDownloadProgressForProduct(int productId) {
    // TODO: implement deleteProductDownloadProgressForProduct
    if (_downloadProgressList
        .any((element) => element.productId == productId)) {
      _downloadProgressList
          .removeWhere((element) => element.productId == productId);
    }

    return Future.value();
  }

  @override
  Future<void> deleteProductDownloadProgress() {
    _downloadProgressList.clear();

    return Future.value();
  }

  @override
  Future<List<ProductDownloadProgressEntity>> getAllProductDownloadProgress() =>
      Future.value(_downloadProgressList);
}
