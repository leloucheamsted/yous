import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/repositories/products_repository.dart';
import 'package:youscribe_analytics/youscribe_analytics.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class ProductReadUseCase extends AsyncUseCase<ProductReadUseCaseParams, bool>
    with Debuggable, Loggable, Trackable {
  final ProductRepository _productRepository = locator();

  @override
  String get debugName => 'ProductReadUseCase';

  @override
  FutureOrResult<bool> execute(ProductReadUseCaseParams? params) async {
    try {
      logInfo("Reading product ${params!.product.id}");
      await tracker.trackProductRead(productId: params.product.id.toString());
      final user = await AuthenticationManager.getCurrentUser();
      await _productRepository.addToLastRead(
          params.product, user!.id!, user.trackingId);
    } on APIRequestException catch (e) {
      return Err(e);
    }
    return const Ok(true);
  }
}

class ProductReadUseCaseParams {
  ProductReadUseCaseParams(this.product);
  final ProductEntity product;
}
