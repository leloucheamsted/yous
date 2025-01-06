import 'dart:async';
import 'dart:convert';

import 'package:pointycastle/export.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/helpers/rsa_helper.dart';
import 'package:youscribe/core/repositories/document_repository.dart';

class GetDocumentPasswordUseCase
    extends AsyncUseCase<GetDocumentPasswordUseCaseParametters, String?> {
  GetDocumentPasswordUseCase({
    required DocumentRepository documentRepository,
  }) : _documentRepository = documentRepository;

  final DocumentRepository _documentRepository;

  @override
  FutureOr<void> onStart(GetDocumentPasswordUseCaseParametters? params) {
    if (params == null) {
      throw const ClientException('You must provide a Document Format Id');
    }
  }

  @override
  FutureOrResult<String?> execute(
      GetDocumentPasswordUseCaseParametters? params) async {
    // 1. Check if the password is in the cache or not.

    final localPasswordResult =
        await _documentRepository.getLocalDocumentPassword(params!.productId);

    if (localPasswordResult.isOk && localPasswordResult.ok != null) {
      return Ok(localPasswordResult.ok);
    }
    if (params.documentFormatId == null) {
      return const Err(ClientException(
          // ignore: lines_longer_than_80_chars
          'Password not saved in local database. Please provide a document format id to retrieve it from the API.'));
    }

    // 2. If the password is not in the cache, generate an RSA key pair.
    final keyPairResult = await Result.tryCatchAsync(
      () => RsaKeyHelper.computeRSAKeyPair(RsaKeyHelper.getSecureRandom()),
      (error) => ClientException('Unable to generate RSA keys: $error'),
    );

    if (keyPairResult.isErr) {
      return Err(keyPairResult.err!);
    }

    // 3. Retrieve the encrypted password from the API using the RSA public key.
    final encryptedPasswordResult =
        await _documentRepository.getEncryptedDocumentPassword(
      params.documentFormatId!,
      keyPairResult.ok!.publicKey as RSAPublicKey,
    );

    if (encryptedPasswordResult.isErr) {
      return Err(encryptedPasswordResult.err!);
    }

    // If API returns null, no need password to access document.
    if (encryptedPasswordResult.ok.isNull) {
      return const Ok(null);
    }

    // 4. Decrypt the encrypted password using the RSA private key.
    final passwordResult = Result.tryCatch(
      () => RsaKeyHelper.rsaDecrypt(
        keyPairResult.ok!.privateKey as RSAPrivateKey,
        base64Decode(
          encryptedPasswordResult.ok!,
        ),
      ),
      (error) =>
          ClientException('Unable to decrypt encrypted password: $error'),
    );

    if (passwordResult.isErr) {
      return Err(passwordResult.err!);
    }

    // 5. Store the password in the cache for future calls.
    final password = base64Encode(passwordResult.ok!);
    await _documentRepository.storeLocalDocumentPassword(
        params.productId, password);

    return Ok(password);
  }
}

class GetDocumentPasswordUseCaseParametters {
  const GetDocumentPasswordUseCaseParametters(
      this.documentFormatId, this.productId);

  final int? documentFormatId;
  final int productId;
}
