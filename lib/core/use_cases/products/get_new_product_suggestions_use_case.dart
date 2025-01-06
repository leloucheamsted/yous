import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/base/base_entity.dart';
import 'package:youscribe/core/repositories/products_repository.dart';

class GetNewProductSuggestionsUseCase extends AsyncUseCase<
    GetNewSuggesstionsUseCaseParameters, List<BaseEntity>> {
  GetNewProductSuggestionsUseCase(ProductRepository productRepository)
      : _productRepository = productRepository;

  final ProductRepository _productRepository;

  @override
  FutureOrResult<List<BaseEntity>> execute(
      GetNewSuggesstionsUseCaseParameters? params) async {
    List<BaseEntity> suggestions = [];

    suggestions = await _productRepository.getNewProductSuggestions(
        params!.productId,
        take: params.numberOfSuggestions);

    return Ok(suggestions);
  }
}

class GetNewSuggesstionsUseCaseParameters {
  const GetNewSuggesstionsUseCaseParameters(
      this.productId, this.numberOfSuggestions);
  final int productId;
  final int numberOfSuggestions;
}
