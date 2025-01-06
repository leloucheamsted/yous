import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';

import 'package:youscribe/data/data_sources/document_data_sources/document_remote_data_source.dart';

// TODO(devs): Use & Implement Youscribe Client
const _protocole = 'http://';
const _baseUrl = 'services.youscribe.com';
const _prefixPath = '/api/v1';

class DocumentRemoteDataSourceImpl extends DocumentRemoteDataSource {
  DocumentRemoteDataSourceImpl({
    required Dio dio,
  }) : _dio = dio;

  final Dio _dio;

  @override
  Future<String?> getEncryptedDocumentPassword(
    int documentFormatId,
    RSAPublicKey publicKey,
  ) async {
    const url = '$_protocole$_baseUrl$_prefixPath/products/files/newkey';

    final headers = {
      'YS-AUTH': await AuthenticationManager.getAuthToken(),
      // 'YS-AUTH': AuthenticationManager
      //     .instance.session?.currentUserAccountEntity?.token,
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final body = {
      "DocumentFormatId": documentFormatId,
      "Modulus": publicKey.modulus.toString(),
      "Exponent": publicKey.exponent.toString(),
    };

    final response = await _dio.post<Map<String, Object?>>(
      url,
      data: jsonEncode(body),
      options: Options(
        headers: headers,
      ),
    );

    if (response.statusCode != 200) {
      throw ServerException(
        'API Error on getEncryptedDocumentPassword : ${response.data}',
      );
    }

    final data = response.data!;

    return data["EncryptedKey"] as String?;
  }
}
