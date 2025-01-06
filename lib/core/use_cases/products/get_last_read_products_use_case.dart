import 'dart:async';

import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/infrastructure/file_service.dart';
import 'package:youscribe/core/repositories/bookmark_repository.dart';
import 'package:youscribe/core/repositories/products_repository.dart';

class GetLastReadProductsUseCase extends AsyncUseCase<
    GetLastReadProductUseCaseParameters, List<ProductEntity>> {
  GetLastReadProductsUseCase(
      ProductRepository productRepository, FileService fileService)
      : _productRepository = productRepository,
        _fileService = fileService;

  final ProductRepository _productRepository;
  final FileService _fileService;
  final BookmarkRepository _bookmarkRepository = locator();

  @override
  FutureOrResult<List<ProductEntity>> execute(
      GetLastReadProductUseCaseParameters? params) async {
    final products = await _productRepository.readLastReadingProducts();
    final currentUser = await AuthenticationManager.getCurrentUser();

    if (products.isNotEmpty) {
      for (int i = 0; i < products.length; i++) {
        products[i].isFileAvailable = await _fileService.productFileExists(
            currentUser!.id!,
            products[i].id!,
            products[i].getProductExtension());
        final bookmark =
            await _bookmarkRepository.getAutoBookmark(products[i].id!);
        if (bookmark != null) {
          products[i].progress = bookmark.progress.toDouble();
        }
      }
    }

    products.sort((a, b) => (b.dateLastRead ?? DateTime(1970))
        .compareTo(a.dateLastRead ?? DateTime(1970)));
    return Ok(products);
  }

  @override
  FutureOr<void> onStart(GetLastReadProductUseCaseParameters? params) {
    if (params == null) {
      throw ArgumentError('You must provide a trackingId');
    }
  }
}

class GetLastReadProductUseCaseParameters {
  const GetLastReadProductUseCaseParameters(this.userId, this.trackingId);

  final int userId;
  final String trackingId;
}
