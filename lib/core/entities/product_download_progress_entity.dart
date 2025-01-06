import 'package:youscribe/core/entities/base/base_entity.dart';

class ProductDownloadProgressEntity extends BaseEntity {
  ProductDownloadProgressEntity({
    required this.productId,
    required this.documentFormatId,
    required this.downloadTaskId,
    required this.productExtension,
    required this.progress,
    required this.password,
    required this.path,
    required this.isUnzip,
  });

  final int productId;
  final int documentFormatId;
  final String productExtension;
  final String downloadTaskId;
  bool isUnzip;
  double progress;
  String path;
  String password;
}
