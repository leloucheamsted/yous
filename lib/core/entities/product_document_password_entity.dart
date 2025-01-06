import 'package:isar/isar.dart';
import 'package:youscribe/core/entities/base/base_entity.dart';

part 'product_document_password_entity.g.dart';

@collection
class ProductDocumentPasswordEntity extends BaseEntity {
  ProductDocumentPasswordEntity({
    required this.productId,
    required this.password,
  });

  final int productId;
  final String password;
}
