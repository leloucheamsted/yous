import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/repositories/products_repository.dart';

class GetProductsUseCase extends AsyncUseCase<List<int>, List<ProductEntity>> {
  GetProductsUseCase(ProductRepository cmsRepository)
      : _productRepository = cmsRepository;

  final ProductRepository _productRepository;

  @override
  FutureOrResult<List<ProductEntity>> execute(List<int>? params) async {
    final products = await _productRepository.getProducts(params!);
    return Ok(products);
  }
}
