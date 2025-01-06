import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/product_search_results_entity.dart';
import 'package:youscribe/core/repositories/product_search_repository.dart';

class GetPublisherProductsUseCase extends AsyncUseCase<
    GetPublisherProductsUseCaseParameters, ProductSearchResultsEntity> {
  GetPublisherProductsUseCase(ProductSearchReposotiry productSearchReposotiry)
      : _productSearchReposotiry = productSearchReposotiry;

  final ProductSearchReposotiry _productSearchReposotiry;

  @override
  FutureOrResult<ProductSearchResultsEntity> execute(
      GetPublisherProductsUseCaseParameters? params) async {
    final ownerResult = await _productSearchReposotiry.getPublisherProducts(
        params!.publisherId, params.take, params.skip, params.deviceLang);
    return Ok(ownerResult);
  }
}

class GetPublisherProductsUseCaseParameters {
  GetPublisherProductsUseCaseParameters(
      this.publisherId, this.take, this.skip, this.deviceLang);
  int publisherId;
  int take;
  int skip;
  String deviceLang;
}
