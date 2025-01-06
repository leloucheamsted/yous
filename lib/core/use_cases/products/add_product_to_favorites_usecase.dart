import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/repositories/products_repository.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class AddProductToFavoritesUseCase
    extends AsyncUseCase<AddProductToFavoritesUseCaseParameters, bool>
    with Debuggable, Loggable {
  AddProductToFavoritesUseCase();
  final ProductRepository productRepository = locator();

  @override
  String get debugName => 'AddProductToFavoritesUseCase';

  @override
  FutureOrResult<bool> execute(AddProductToFavoritesUseCaseParameters? params) {
    try {
      logInfo("Adding product ${params!.product.id} to offlines");
      productRepository.saveFavoriteProduct(params.product, true);
    } catch (e) {
      logError(
        "Error while adding product ${params!.product.id} to offlines",
        error: e as Exception,
      );
      if (e is AppException) {
        return Err(e);
      }

      rethrow;
    }

    return const Ok(true);
  }
}

class AddProductToFavoritesUseCaseParameters {
  AddProductToFavoritesUseCaseParameters(this.product);
  final ProductEntity product;
}
