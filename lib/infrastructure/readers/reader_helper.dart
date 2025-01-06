// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/use_cases/reader/get_latest_bookmark_use_case.dart';
import 'package:youscribe/infrastructure/readers/epub_reader_helper.dart';
import 'package:youscribe/infrastructure/readers/pdf_reader_helper.dart';

abstract class ReaderHelper {
  static int currentProductId = 0;
  static int totalPages = 0;

  static Future<void> showDocument(
    BuildContext context,
    ProductEntity product,
    String productExtension,
    String documentPath,
    String? password,
  ) async {
    currentProductId = product.id!;
    return switch (productExtension) {
      ProductEntity.epubExtension =>
        await EpubReaderHelper.showDocument(context, documentPath, 
        password, product),
      ProductEntity.pdfExtension => await _showPdf(
          context, product, productExtension, documentPath, password),
      _ => null,
    };
  }

  static Future<void> _showPdf(
    BuildContext context,
    ProductEntity product,
    String productExtension,
    String documentPath,
    String? password,
  ) async {
    final GetBookmarkUseCase getBookmarkUseCase = locator();
    final bookmark = await getBookmarkUseCase(product.id);
    var startPage = 0;

    if (bookmark.isOk && bookmark.ok != null) {
      startPage = bookmark.ok!.pageNumber;
    }

    return PdfReaderHelper.showDocument(
        context, product, documentPath, password,
        startPage: startPage);
  }
}

