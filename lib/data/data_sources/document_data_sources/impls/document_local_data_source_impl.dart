import 'package:isar/isar.dart';
import 'package:youscribe/core/entities/product_document_password_entity.dart';
import 'package:youscribe/data/data_sources/base_local_data_source.dart';
import 'package:youscribe/data/data_sources/document_data_sources/document_local_data_source.dart';

class DocumentLocalDataSourceImpl
    extends BaseLocalDataSource<ProductDocumentPasswordEntity>
    implements DocumentLocalDataSource {
  DocumentLocalDataSourceImpl(super.isar);

  @override
  Future<String?> getLocalDocumentPassword(int productId) async {
    final pass = await currentCollection
        .filter()
        .productIdEqualTo(productId)
        .findFirst();

    return pass?.password;
  }

  @override
  Future<void> storeLocalDocumentPassword(
    int productId,
    String password,
  ) async {
    return isar.writeTxn(() {
      return currentCollection.put(ProductDocumentPasswordEntity(
        productId: productId,
        password: password,
      ));
    });
  }
}
