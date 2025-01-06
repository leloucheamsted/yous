import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/product_facet_entity.dart';
import 'package:youscribe/core/models/responses/category_type.dart';
import 'package:youscribe/core/repositories/product_search_repository.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';

class GetFirstLevelSearchOptionsUseCase
    extends AsyncUseCase<void, List<BaseProductFacetEntity>> {
  GetFirstLevelSearchOptionsUseCase(
      ProductSearchReposotiry productSearchReposotiry,
      UserAccountRepository userAccountRepository)
      : _productSearchReposotiry = productSearchReposotiry,
        _userAccountRepository = userAccountRepository;

  final UserAccountRepository _userAccountRepository;
  final ProductSearchReposotiry _productSearchReposotiry;

  @override
  FutureOrResult<List<BaseProductFacetEntity>> execute(void params) async {
    final currentUser = await Auth.getCurrentUser();
    final settings = await _userAccountRepository.getUserSettings();
    final categories = await _productSearchReposotiry
        .getSearchFirstLevelOptions(settings.preferredLanguageCode);

    if (currentUser != null && currentUser.isYSClassificationSettings) {
      return Ok([
        ...categories
            .where((element) => element.categoryType != CategoryType.document)
      ]);
    } else {
      await _userAccountRepository.setClassificationTree(categories);
      return Ok(categories);
    }
  }
}
