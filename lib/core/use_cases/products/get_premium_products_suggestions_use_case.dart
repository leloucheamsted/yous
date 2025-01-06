import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/repositories/products_repository.dart';

class GetPremiumProductsSuggestionsUseCase extends AsyncUseCase<
    GetPremiumProductsSuggestionsUseCaseParameters, List<ProductEntity>> {
  GetPremiumProductsSuggestionsUseCase(ProductRepository productReposotiry)
      : _productReposotiry = productReposotiry;

  final ProductRepository _productReposotiry;

  @override
  FutureOrResult<List<ProductEntity>> execute(
      GetPremiumProductsSuggestionsUseCaseParameters? params) async {
    List<ProductEntity> collections = [];
    try {
      collections = await _productReposotiry.getPremiumProductSuggestionsAsync(
          params!.productId,
          take: params.take);
    } catch (e) {
      return Err(e as AppException);
    }
    return Ok(collections);
  }
}

class GetPremiumProductsSuggestionsUseCaseParameters {
  GetPremiumProductsSuggestionsUseCaseParameters(this.productId, this.take);
  int productId;
  int take;
}
