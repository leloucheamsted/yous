import 'dart:async';

import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/repositories/products_repository.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class RemoveFromOfflinesUseCase
    extends AsyncUseCase<RemoveFromOfflinesUseCaseParameters, bool>
    with Debuggable, Loggable {
  final ProductRepository _productReposotiry = locator();

  @override
  String get debugName => 'RemoveFromOfflinesUseCase';

  @override
  FutureOrResult<bool> execute(RemoveFromOfflinesUseCaseParameters? params) {
    try {
      logInfo("Removing product: ${params!.productId} from offlines");
      _productReposotiry.removeFromOfflineProducts(params.productId);
    } catch (e) {
      logError(
          "Error while removing product: ${params!.productId} from offlines",
          error: e as Exception);
      if (e is AppException) {
        return Err(e);
      }

      rethrow;
    }

    return const Ok(true);
  }

  @override
  FutureOr<void> onStart(RemoveFromOfflinesUseCaseParameters? params) {
    if (params == null) {
      throw ArgumentError('You must provide a productId');
    }
  }
}

class RemoveFromOfflinesUseCaseParameters {
  const RemoveFromOfflinesUseCaseParameters(this.productId);

  final int productId;
}
