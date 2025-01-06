import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/use_cases/products/product_read_use_case.dart';

enum EpubReaderEnum {
  nativeReader,
  flutterReader,
}

abstract final class EpubReaderHelper {
  static final ProductReadUseCase _productReadUseCase = locator();
  static Future<void> showDocument(BuildContext context, String documentPath,
      String? password, ProductEntity product) async {
    await _productReadUseCase(ProductReadUseCaseParams(product));
    if (context.mounted) {
      await context.pushNamed(Routes.epubReader, queryParameters: {
        Routes.pathParamName: documentPath,
        Routes.productIdParamName: product.id.toString()
      }

          //extra: onPageChanged,
          );
    }
  }
}
