import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/product_search_results_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/models/requests/product_search_parameters.dart';
import 'package:youscribe/core/repositories/product_search_repository.dart';
import 'package:youscribe/presentation/blocs/search/shared.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class SearchUseCase
    extends AsyncUseCase<SearchUseCaseParams, ProductSearchResultsEntity>
    with Debuggable, Loggable {
  SearchUseCase();

  final ProductSearchReposotiry _productRepository = locator();

  @override
  String get debugName => 'SearchUseCase';

  @override
  FutureOrResult<ProductSearchResultsEntity> execute(
      SearchUseCaseParams? params) async {
    try {
      logInfo("Searching products.");

      ProductSearchResultsEntity? searchResult;
      final searchParams = ProductSearchParameters()
        ..quicksearch = params!.query
        ..take = params.take
        ..skip = params.skip
        ..includePremium = _getPremiumFlag(params.premiumDisplayOption)
        ..languageId = params.languageId == 0 ? null : params.languageId
        ..categoryId = params.categoryId == 0 ? null : params.categoryId
        ..sort = [_getsortOption(params.sortOption ?? SortOption.relevance)]
        ..requestedFacet = [
          ProductSearchResultsEntity.themeFacet,
          ProductSearchResultsEntity.categoryFacet,
          ProductSearchResultsEntity.languageFacet
        ]
        ..offerType = [
          ProductSearchResultsEntity.productFreeOfferType,
          ProductSearchResultsEntity.productSubscriptionOfferType
        ]
        // ..classificationId = params.themeId
        ..themeId = params.themeId == 0 ? null : params.themeId
        ..languageId = params.languageId == 0 ? null : params.languageId;

      if (params.searchContext == SearchContext.product) {
        searchResult = await _productRepository.searchProducts(
          searchParams,
          params.deviceLanguage,
          (await AuthenticationManager.getCurrentUser())!.classificationTreeId,
        );
      } else if (params.searchContext == SearchContext.collection) {
        searchResult = await _productRepository.searchCollections(
            searchParams, params.deviceLanguage);
      } else if (params.searchContext == SearchContext.author) {
        searchResult = await _productRepository.searchAuthors(
            searchParams, params.deviceLanguage);
      }
      return Ok(searchResult!);
    } on APIRequestException catch (e) {
      logError("API Error while searching products.", error: e);
      return Err(e);
    } catch (e) {
      logError("Error while searching products.", error: e as Exception);
      rethrow;
    }
  }

  SearchPremiumFlag _getPremiumFlag(
      PremiumDisplayOption? premiumDisplayOption) {
    switch (premiumDisplayOption) {
      case PremiumDisplayOption.display:
        return SearchPremiumFlag.yes;
      case PremiumDisplayOption.displayOnly:
        return SearchPremiumFlag.only;
      case PremiumDisplayOption.doNotDisplay:
        return SearchPremiumFlag.no;
      default:
        return SearchPremiumFlag.yes;
    }
  }

  String _getsortOption(SortOption sortOption) {
    switch (sortOption) {
      case SortOption.relevance:
        return ProductSearchResultsEntity.scoreSortOption;
      case SortOption.mostRead:
        return ProductSearchResultsEntity.mostReadSortOption;
      case SortOption.mostRecent:
        return ProductSearchResultsEntity.mostRecentSortOption;
    }
  }
}

class SearchUseCaseParams {
  SearchUseCaseParams(
      {required this.query,
      required this.take,
      required this.skip,
      required this.sortOption,
      required this.deviceLanguage,
      this.premiumDisplayOption,
      this.searchContext = SearchContext.product,
      this.languageId,
      this.subThemeId,
      this.categoryId,
      this.themeOrder,
      this.themeId});

  final int take;
  final int skip;
  final PremiumDisplayOption? premiumDisplayOption;
  final int? languageId;
  final SortOption? sortOption;
  final int? themeId;
  final int? subThemeId;
  final int? categoryId;
  final String? query;
  final List<int>? themeOrder;
  final String deviceLanguage;
  final SearchContext searchContext;
}
