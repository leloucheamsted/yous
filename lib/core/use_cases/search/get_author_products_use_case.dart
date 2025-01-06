import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/product_search_results_entity.dart';
import 'package:youscribe/core/repositories/product_search_repository.dart';

class GetAuthorProductsUseCase extends AsyncUseCase<
    GetAuthorProductsUseCaseParameters, ProductSearchResultsEntity> {
  GetAuthorProductsUseCase(ProductSearchReposotiry productSearchReposotiry)
      : _productSearchReposotiry = productSearchReposotiry;

  final ProductSearchReposotiry _productSearchReposotiry;

  @override
  FutureOrResult<ProductSearchResultsEntity> execute(
      GetAuthorProductsUseCaseParameters? params) async {
    final ownerResult = await _productSearchReposotiry.getAuthorProducts(
        params!.authorId, params.take, params.skip, params.deviceLang);
    return Ok(ownerResult);
  }
}

class GetAuthorProductsUseCaseParameters {
  GetAuthorProductsUseCaseParameters(
      this.authorId, this.take, this.skip, this.deviceLang);
  int authorId;
  int take;
  int skip;
  String deviceLang;
}
