import 'dart:async';

import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/infrastructure/file_service.dart';
import 'package:youscribe/core/repositories/bookmark_repository.dart';
import 'package:youscribe/core/repositories/products_repository.dart';

class GetOfflineProductsUseCase extends AsyncUseCase<
    GetOfflineProductUseCaseParameters, GetOfflinePoductUseCaseResults> {
  GetOfflineProductsUseCase(
      ProductRepository productRepository, FileService fileService)
      : _productRepository = productRepository,
        _fileService = fileService;

  final ProductRepository _productRepository;
  final FileService _fileService;
  final BookmarkRepository _bookmarkRepository = locator();

  @override
  FutureOrResult<GetOfflinePoductUseCaseResults> execute(
      GetOfflineProductUseCaseParameters? params) async {
    //TODO: read bookmarks and set the progress on products.

    final currentUser = await AuthenticationManager.getCurrentUser();
    final products = await _productRepository.readOfflineProducts(
        currentUser!.id!, 
        take: params!.take,
        skip: params.skip);

    if (products.isNotEmpty) {
      for (int i = 0; i < products.length; i++) {
        products[i].isFileAvailable = await _fileService.productFileExists(
            currentUser.id!,
            products[i].id!,
            products[i].getProductExtension());
        final bookmark =
            await _bookmarkRepository.getAutoBookmark(products[i].id!);
        if (bookmark != null) {
          products[i].progress = bookmark.progress.toDouble();
        }
      }
    }

    products.sort((a, b) => (b.dateAddedToOfflines ?? DateTime(1970))
        .compareTo(a.dateAddedToOfflines ?? DateTime(1970)));
    return Ok(GetOfflinePoductUseCaseResults(
        products, products.length == params.take));
  }

  @override
  FutureOr<void> onStart(GetOfflineProductUseCaseParameters? params) {
    if (params == null) {
      throw ArgumentError('You must provide a trackingId');
    }
  }
}

class GetOfflinePoductUseCaseResults {
  const GetOfflinePoductUseCaseResults(this.products, this.hasNextPage);

  final List<ProductEntity> products;
  final bool hasNextPage;
}

class GetOfflineProductUseCaseParameters {
  const GetOfflineProductUseCaseParameters(this.take, this.skip);

  final int take;
  final int skip;
}
