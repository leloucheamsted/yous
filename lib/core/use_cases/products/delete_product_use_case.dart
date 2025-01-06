import 'dart:async';

import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/infrastructure/file_service.dart';

class DeleteProductUseCase
    extends AsyncUseCase<DeleteProductUseCaseParameters, void> {
  DeleteProductUseCase(this._fileService);

  final FileService _fileService;

  @override
  FutureOr<void> onStart(DeleteProductUseCaseParameters? params) {
    if (params == null) {
      throw ArgumentError('You must provide arguments');
    }
  }

  @override
  FutureOrResult<void> execute(DeleteProductUseCaseParameters? params) async {
    final currentUser = await AuthenticationManager.getCurrentUser();
    try {
      if (await _fileService.productFileExists(
          currentUser!.id!, params!.productId, params.extension)) {
        await _fileService.deleteProductFile(
            currentUser.id!, params.productId, params.extension);
      }
    } catch (e) {
      rethrow;
    }
    return const Ok(null);
  }
}

class DeleteProductUseCaseParameters {
  DeleteProductUseCaseParameters(this.productId, this.extension);

  final int productId;
  final String extension;
}
