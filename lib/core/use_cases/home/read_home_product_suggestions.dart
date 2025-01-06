import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/repositories/products_repository.dart';

class ReadHomeProductSuggestionsUseCase
    extends AsyncUseCase<void, List<ProductEntity>> {
  ReadHomeProductSuggestionsUseCase(ProductRepository productRepository)
      : _productRepository = productRepository;

  final ProductRepository _productRepository;

  @override
  FutureOrResult<List<ProductEntity>> execute(void params) async {
    try {
      final homeProducts =
          await _productRepository.readHomeProductSuggestions();
      return Ok(homeProducts);
    } catch (e) {
      if (e is AppException) {
        return Err(e);
      }
      rethrow;
    }
  }
}
