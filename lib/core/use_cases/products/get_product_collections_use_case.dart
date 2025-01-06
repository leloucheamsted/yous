import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/base/base_entity.dart';
import 'package:youscribe/core/repositories/product_search_repository.dart';

class GetProductCollectionsUseCase extends AsyncUseCase<
    GetProductCollectionsUseCaseParameters, List<BaseEntity>> {
  GetProductCollectionsUseCase(ProductSearchReposotiry productSearchReposotiry)
      : _productSearchReposotiry = productSearchReposotiry;

  final ProductSearchReposotiry _productSearchReposotiry;

  @override
  FutureOrResult<List<BaseEntity>> execute(
      GetProductCollectionsUseCaseParameters? params) async {
    List<BaseEntity> collections = [];
    collections = await _productSearchReposotiry.getProductCollection(
        params!.collectionId, params.take, params.language);
    return Ok(collections);
  }
}

class GetProductCollectionsUseCaseParameters {
  GetProductCollectionsUseCaseParameters(
      this.collectionId, this.take, this.language);
  int collectionId;
  int take;
  String language;
}
