import 'dart:convert';
import 'dart:math';

import "package:asn1lib/asn1lib.dart";
import 'package:flutter/foundation.dart';
import "package:pointycastle/export.dart";

/// Helper class to handle RSA key generation and encoding
abstract class RsaKeyHelper {
  /// Generate a [PublicKey] and [PrivateKey] pair
  ///
  /// Returns a [AsymmetricKeyPair] based on the [RSAKeyGenerator]
  /// with custom parameters,
  /// including a [SecureRandom]
  static Future<AsymmetricKeyPair<PublicKey, PrivateKey>> computeRSAKeyPair(
    SecureRandom secureRandom,
  ) async =>
      compute(getRsaKeyPair, secureRandom);

  /// Generates a [SecureRandom]
  ///
  /// Returns [FortunaRandom] to be used in the [AsymmetricKeyPair] generation
  static SecureRandom getSecureRandom() {
    final secureRandom = FortunaRandom();
    final random = Random.secure();
    final List<int> seeds = [];
    for (int i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255));
    }
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));
    return secureRandom;
  }

  /// Encode Private key to PEM Format
  ///
  /// Given [RSAPrivateKey] returns a base64 encoded [String] with standard
  /// PEM headers and footers
  static String encodePrivateKeyToPemPKCS1(RSAPrivateKey privateKey) {
    final topLevel = ASN1Sequence();

    final version = ASN1Integer(BigInt.from(0));
    final modulus = ASN1Integer(privateKey.n!);
    final publicExponent = ASN1Integer(privateKey.exponent!);
    final privateExponent = ASN1Integer(privateKey.privateExponent!);
    final p = ASN1Integer(privateKey.p!);
    final q = ASN1Integer(privateKey.q!);
    final dP = privateKey.privateExponent! % (privateKey.p! - BigInt.from(1));
    final exp1 = ASN1Integer(dP);
    final dQ = privateKey.privateExponent! % (privateKey.q! - BigInt.from(1));
    final exp2 = ASN1Integer(dQ);
    final iQ = privateKey.q!.modInverse(privateKey.p!);
    final co = ASN1Integer(iQ);

    topLevel
      ..add(version)
      ..add(modulus)
      ..add(publicExponent)
      ..add(privateExponent)
      ..add(p)
      ..add(q)
      ..add(exp1)
      ..add(exp2)
      ..add(co);

    final dataBase64 = base64.encode(topLevel.encodedBytes);

    return """-----BEGIN PRIVATE KEY-----\r\n$dataBase64\r\n-----END PRIVATE KEY-----""";
  }

  /// Encode Public key to PEM Format
  ///
  /// Given [RSAPublicKey] returns a base64 encoded [String] with standard PEM
  /// headers and footers
  static String encodePublicKeyToPemPKCS1(RSAPublicKey publicKey) {
    final topLevel = ASN1Sequence()
      ..add(ASN1Integer(publicKey.modulus!))
      ..add(ASN1Integer(publicKey.exponent!));

    final dataBase64 = base64.encode(topLevel.encodedBytes);
    return """-----BEGIN PUBLIC KEY-----\r\n$dataBase64\r\n-----END PUBLIC KEY-----""";
  }

  /// Déchiffre une chaîne de caractères avec la clé privée RSA
  ///
  /// Prend une [PrivateKey] et une chaîne de caractères chiffrée en entrée.
  /// Retourne la chaîne de caractères déchiffrée.
  static Uint8List? rsaDecrypt(RSAPrivateKey myPrivate, Uint8List input) {
    final decryptor = PKCS1Encoding(RSAEngine())
      ..init(
        false,
        PrivateKeyParameter<RSAPrivateKey>(myPrivate),
      );

    return decryptor.process(input);
  }

  /// Generate a [PublicKey] and [PrivateKey] pair
  ///
  /// Returns a [AsymmetricKeyPair] based on the [RSAKeyGenerator] with
  /// custom parameters, including a [SecureRandom]
  static AsymmetricKeyPair<PublicKey, PrivateKey> getRsaKeyPair(
    SecureRandom secureRandom,
  ) {
    final rsapars = RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 5);
    final params = ParametersWithRandom(rsapars, secureRandom);
    final keyGenerator = RSAKeyGenerator()..init(params);
    return keyGenerator.generateKeyPair();
  }
}
