import 'package:dio/dio.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/multitype_search_output_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/models/requests/product_search_parameters.dart';
import 'package:youscribe/core/repositories/product_search_repository.dart';

class GetSearchSuggestionsUseCase extends AsyncUseCase<
    GetSuggestionsUseCaseParameters, MultiTypeSearchOutPutEntity> {
  GetSearchSuggestionsUseCase(ProductSearchReposotiry productSearchReposotiry)
      : _productSearchReposotiry = productSearchReposotiry;

  final ProductSearchReposotiry _productSearchReposotiry;

  @override
  FutureOrResult<MultiTypeSearchOutPutEntity> execute(
      GetSuggestionsUseCaseParameters? params) async {
    try {
      final result = await _productSearchReposotiry.getSearchSuggestions(
          params!.searchParameters, params.deviceLanguage);
      return Ok(result);
    } on APIRequestException catch (e) {
      return Err(e);
    }
  }
}

class GetSuggestionsUseCaseParameters {
  GetSuggestionsUseCaseParameters(
      this.searchParameters, this.deviceLanguage, this.cancellationToken);
  ProductSearchParameters searchParameters;
  String deviceLanguage;
  CancelToken cancellationToken;
}
