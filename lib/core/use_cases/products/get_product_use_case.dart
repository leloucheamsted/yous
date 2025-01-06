import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/infrastructure/file_service.dart';
import 'package:youscribe/core/repositories/products_repository.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class GetProductUseCase
    extends AsyncUseCase<GetProductUseCaseParameters, ProductEntity>
    with Debuggable, Loggable {
  GetProductUseCase(ProductRepository cmsRepository)
      : _productRepository = cmsRepository;

  final ProductRepository _productRepository;
  final FileService _fileService = locator();

  @override
  String get debugName => 'GetProductUseCase';

  @override
  FutureOrResult<ProductEntity> execute(
      GetProductUseCaseParameters? params) async {
    try {
      logInfo('Getting product ${params!.productId}');
      final product = await _productRepository.getProduct(params.productId,
          (product) async {
        if (params.onPreloaded != null && product != null) {
          final isFileAvailable = await isProductFileAvailable(
              params.productId, product.getProductExtension());
          product.isFileAvailable = isFileAvailable;
          // ignore: prefer_null_aware_method_calls
          params.onPreloaded!(product);
        }
      }, params.checkInternetCo);

      final isFileAvailable = await isProductFileAvailable(
          params.productId, product.getProductExtension());
      product.isFileAvailable = isFileAvailable;

      return Ok(product);
    } on APIRequestException catch (e) {
      logError('Error getting product ${params!.productId}',
          error: Exception(e));
      return Err(e);
    } catch (e, s) {
      logError(
        'Error getting product ${params!.productId}',
        error: Exception(e),
        stackTrace: s,
      );
      rethrow;
    }
  }

  Future<bool> isProductFileAvailable(
      int productId, String productExtension) async {
    final currentUser = await AuthenticationManager.getCurrentUser();
    return _fileService.productFileExists(
        currentUser!.id!, productId, productExtension);
  }
}

class GetProductUseCaseParameters {
  GetProductUseCaseParameters(this.productId,
      {this.onPreloaded, this.checkInternetCo = false});

  final int productId;
  final bool checkInternetCo;
  final void Function(ProductEntity?)? onPreloaded;
}
