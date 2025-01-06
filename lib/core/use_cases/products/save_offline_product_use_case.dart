import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/repositories/products_repository.dart';

class SaveOfflineProductUseCase
    extends AsyncUseCase<SaveOfflineProductUseCaseParameters, void> {
  SaveOfflineProductUseCase(ProductRepository productRepository)
      : _productRepository = productRepository;

  final ProductRepository _productRepository;

  @override
  FutureOrResult<void> execute(
      SaveOfflineProductUseCaseParameters? params) async {
    final response = await _productRepository.saveOfflineProduct(
      params!.offline,
      params.addedLocally,
    );
    return Ok(response);
  }
}

class SaveOfflineProductUseCaseParameters {
  SaveOfflineProductUseCaseParameters(
      this.offline, this.addedLocally, this.setDate, this.synchronized);

  ProductEntity offline;
  bool addedLocally;
  bool setDate = true;
  bool synchronized = false;
}
