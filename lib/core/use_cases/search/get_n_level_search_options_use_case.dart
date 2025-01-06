import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

import 'package:youscribe/core/entities/product_facet_entity.dart';
import 'package:youscribe/core/repositories/product_search_repository.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';

class GetNLevelSearchOptionUseCase extends AsyncUseCase<
    GetNLevelSearchOptionUseCaseParams, List<BaseProductFacetEntity>> {
  GetNLevelSearchOptionUseCase(ProductSearchReposotiry productSearchReposotiry,
      UserAccountRepository userAccountRepository)
      : _productSearchReposotiry = productSearchReposotiry,
        _userAccountRepository = userAccountRepository;

  final UserAccountRepository _userAccountRepository;
  final ProductSearchReposotiry _productSearchReposotiry;

  @override
  FutureOrResult<List<BaseProductFacetEntity>> execute(
      GetNLevelSearchOptionUseCaseParams? params) async {
    final settings = await _userAccountRepository.getUserSettings();
    final themes = await _productSearchReposotiry.getThemes(params!.facetId,
        settings.preferredLanguageCode, params.isFromFirstLevel);

    return Ok(themes);
  }
}

class GetNLevelSearchOptionUseCaseParams {
  GetNLevelSearchOptionUseCaseParams({
    required this.isFromFirstLevel,
    required this.facetId,
  });

  final bool isFromFirstLevel;
  final int facetId;
}
