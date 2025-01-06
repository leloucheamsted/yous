import 'package:wyatt_architecture/wyatt_architecture.dart';

abstract class DocumentLocalDataSource extends BaseDataSource {
  Future<String?> getLocalDocumentPassword(int productId);
  Future<void> storeLocalDocumentPassword(
    int productId,
    String password,
  );
}
