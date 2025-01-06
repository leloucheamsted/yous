import 'dart:async';

import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/product_catalog_presentation_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/repositories/products_repository.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class GetYsSelectionProductsUseCase extends AsyncUseCase<
        GetYsSelectionProductsUseCaseParams,
        (ProductCatalogPresentationEntity catalog, bool hasNext)>
    with Debuggable, Loggable {
  GetYsSelectionProductsUseCase(ProductRepository prodRepo)
      : _productRepository = prodRepo;

  final ProductRepository _productRepository;

  @override
  String get debugName => 'GetYsSelectionProductsUseCase';

  @override
  FutureOr<void> onStart(GetYsSelectionProductsUseCaseParams? params) {
    if (params == null) {
      throw ArgumentError('You must provide arguments');
    }
  }

  @override
  FutureOrResult<(ProductCatalogPresentationEntity catalog, bool hasNext)>
      execute(GetYsSelectionProductsUseCaseParams? params) async {
    try {
      final catalog = await _productRepository.getProductsForSelection(
          params!.selectionId, params.take, params.skip);
      final hasNext = (catalog.totalResults ?? 0) >
          (params.skip + (catalog.products?.length ?? 0));

      return Ok(
        (catalog, hasNext),
      );
    } on APIRequestException catch (e) {
      logError('Error getting products for selection: ${params!.selectionId}',
          error: Exception(e));
      return Err(e);
    } catch (e, s) {
      logError(
        // ignore: lines_longer_than_80_chars
        'Error getting products for selection ${params!.selectionId}',
        error: Exception(e), stackTrace: s,
      );
      rethrow;
    }
  }
}

class GetYsSelectionProductsUseCaseParams {
  GetYsSelectionProductsUseCaseParams(
      {required this.selectionId, required this.take, required this.skip});

  final String selectionId;
  final int skip;
  final int take;
}
