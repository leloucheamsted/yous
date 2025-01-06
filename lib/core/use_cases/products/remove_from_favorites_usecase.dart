import 'dart:async';

import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/repositories/products_repository.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class RemoveFromFavoritesUseCase
    extends AsyncUseCase<RemoveFromFavoritesUseCaseParameters, bool> with Debuggable, Loggable {
  final ProductRepository _productReposotiry = locator();

  @override
  String get debugName => 'RemoveFromFavoritesUseCase';

  @override
  FutureOrResult<bool> execute(RemoveFromFavoritesUseCaseParameters? params) {
    try {
      logInfo("Removing product: ${params!.productId} from favorites");
      _productReposotiry.removeFromFavoriteProducts(params.productId);
    } catch (e) {
      logError(
          "Error while removing product: ${params!.productId} from favorites",
          error: e as Exception);
      if (e is AppException) {
        return Err(e);
      }

      rethrow;
    }

    return const Ok(true);
  }

  @override
  FutureOr<void> onStart(RemoveFromFavoritesUseCaseParameters? params) {
    if (params == null) {
      throw ArgumentError('You must provide a productId');
    }
  }
}

class RemoveFromFavoritesUseCaseParameters {
  const RemoveFromFavoritesUseCaseParameters(this.productId);

  final int productId;
}
