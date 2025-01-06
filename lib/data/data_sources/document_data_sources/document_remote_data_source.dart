import 'package:pointycastle/pointycastle.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';

abstract class DocumentRemoteDataSource extends BaseDataSource {
  Future<String?> getEncryptedDocumentPassword(
    int documentFormatId,
    RSAPublicKey publicKey,
  );
}
