import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/collection_search_output_item_entity.dart';
import 'package:youscribe/core/entities/collection_search_results_presentation_entity.dart';
import 'package:youscribe/core/entities/language_entity.dart';
import 'package:youscribe/core/entities/people_search_output_item_entity.dart';
import 'package:youscribe/core/entities/people_search_results_entity.dart';
import 'package:youscribe/core/entities/product_category_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/entities/product_facet_entity.dart';
import 'package:youscribe/core/entities/selection_model.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/use_cases/configurations/get_user_settings_use_case.dart';
import 'package:youscribe/core/use_cases/search/can_follow_search_theme_use_case.dart';
import 'package:youscribe/core/use_cases/search/follow_sub_theme_use_case.dart';
import 'package:youscribe/core/use_cases/search/get_n_level_search_options_use_case.dart';
import 'package:youscribe/core/use_cases/search/search_product_usecase.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe/presentation/blocs/search/shared.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'search_results_event.dart';
part 'search_results_state.dart';

class SearchResultsBloc extends Bloc<SearchResultsEvent, SearchResultsState>
    with Debuggable, Loggable {
  SearchResultsBloc() : super(SearchResultsInitialState()) {
    on<InitizeSearchResultsEvent>(initializeSearchResults);
    on<SearchOptionChangedEvent>(onSearchOptionChanged);
    on<SearchResultsErrorDisplayedEvent>(_onErrorDisplayedChanged);
    on<FollowSelectedEvent>(_onFollowSelected);
  }

  String _title = '';
  final SearchUseCase _searchProductUseCase = locator();
  final CanFollowSearchThemeUseCase _canFollowUseCase = locator();
  final GetNLevelSearchOptionUseCase _getNLevelSearchOptionUseCase = locator();

  final FollowSubthemeUseCase _followSubthemeUseCase = locator();
  final GetUserSettingsUseCase _userSettingsUseCase = locator();
  final ConnectivityService _connectivityService = locator();
  List<SelectionEntity> _selections = [];

  @override
  String get debugName => 'SearchResultsBloc';

  Future<void> initializeSearchResults(
      InitizeSearchResultsEvent event, Emitter<SearchResultsState> emit) async {
    if (!await _connectivityService.isInternetAvailable) {
      emit(SearchResultsErrorState(
          previousState: SearchResultsLoadedState(
              products: const [],
              authors: const [],
              collections: const [],
              selections: _selections,
              searchContext: event.searchContext,
              hasNextPage: false,
              title: _title,
              query: event.query,
              categories: const [],
              facets: const [],
              languages: const []),
          error: ErrorType.noInternet));
      return;
    }

    //TODO: implement
    _title = event.categoryTtitle ?? '';

    final uSettingsResult = await _userSettingsUseCase(null);

    final result = await _searchProductUseCase(SearchUseCaseParams(
        query: event.query,
        take: event.pageSize ?? pageSize,
        skip: 0,
        sortOption: event.query.isNotNullOrEmpty
            ? SortOption.relevance
            : SortOption.mostRead,
        searchContext: event.searchContext ?? SearchContext.product,
        deviceLanguage: uSettingsResult.isOk
            ? (uSettingsResult.ok?.preferredLanguageCode ?? '')
            : '',
        premiumDisplayOption: PremiumDisplayOption.display,
        themeId: event.themeId,
        categoryId: event.categoryId ?? 0));

    final followResult = await _canFollowUseCase(
        CanFollowSearchThemeUseCaseParams(
            themeId: event.currentThemeId, categoryId: event.categoryId));

    final prods = result.ok?.products ?? [];
    final collections =
        result.ok != null && result.ok is CollectionSearchResultsEntity
            ? (result.ok! as CollectionSearchResultsEntity).collections ?? []
            : <CollectionSearchOutputItemEntity>[];
    final authors = result.ok != null && result.ok is PeopleSearchResultsEntity
        ? (result.ok! as PeopleSearchResultsEntity).people ?? []
        : <PeopleSearchOutputItemEntity>[];
    if (result.isErr) {
      logError("Error while searching products.", error: result.err);
    }
    if (followResult.isErr) {
      logError(
          // ignore: lines_longer_than_80_chars
          "Error while getting follow results for Theme: ${event.currentThemeId} and category: ${event.categoryId}.",
          error: result.err);
    }
    // if (event.isFromFirstFacet ?? false) {
    _selections = [];
    // final res = await _getNLevelSearchOptionUseCase(
    //     GetNLevelSearchOptionUseCaseParams(
    //         isFromFirstLevel: false, facetId: event.currentThemeId ?? 0));
    // print(res);
    //  sortProductBySelection(prods, event.themeId ?? 0);
    //  }

    emit(SearchResultsLoadedState(
        products: prods,
        authors: authors,
        collections: collections,
        searchContext: event.searchContext,
        hasNextPage: prods.length >= pageSize,
        title: _title,
        canFollow: followResult.ok?.canFollow ?? false,
        isFollowed: followResult.ok?.isFollowed ?? false,
        query: event.query,
        selections: _selections,
        categoryId: event.categoryId,
        themeId: event.currentThemeId,
        categories: result.ok?.categories ?? [],
        facets: result.ok?.themes ?? [],
        languages: result.ok?.languages ?? []));
  }

  // function tu order product by selection category
  void sortProductBySelection(List<ProductEntity> products, int categoryId) {
    // remove produc if id is equal to categoryId
    final productsFiltered =
        products.where((element) => element.theme?.id != categoryId).toList();
    void recursive() {
      final restList = <dynamic>[];
      if (productsFiltered.isNotEmpty) {
        _selections.add(SelectionEntity(
            id: productsFiltered[0].theme?.id.toString() ?? '',
            order: 0,
            title: productsFiltered[0].theme?.label ?? "",
            products: [productsFiltered[0]]));
        for (final element in productsFiltered) {
          if (element.theme?.id.toString() ==
              productsFiltered[0].theme?.id.toString()) {
            // find index of selection
            final index = _selections.indexWhere((element) =>
                element.id == productsFiltered[0].theme?.id.toString());
            if (index != -1) {
              _selections[index].products.add(element);
              restList.add(element);
            } else {}
          }
        }
        // remove product from list
        for (int i = 0; i < restList.length; i++) {
          final element = restList[i];
          productsFiltered.remove(element);
        }
        recursive();
      } else {
        return;
      }
    }

    recursive();
  }

  Future<void> _onErrorDisplayedChanged(SearchResultsErrorDisplayedEvent event,
      Emitter<SearchResultsState> emitter) async {
    emitter((state as SearchResultsErrorState).previousState);
  }

  Future<void> _onFollowSelected(
      FollowSelectedEvent event, Emitter<SearchResultsState> emitter) async {
    Result<bool, AppException>? result;
    if (state is SearchResultsLoadedState) {
      try {
        final currentState = state as SearchResultsLoadedState;
        if ((state as SearchResultsLoadedState).isFollowed) {
          emitter(
              (state as SearchResultsLoadedState).copyWith(isFollowed: false));
          result = await _followSubthemeUseCase(FollowSubthemeUseCaseParams(
              categoryId: currentState.categoryId!,
              shouldFollow: false,
              themeId: currentState.themeId!));
        } else {
          emitter(
              (state as SearchResultsLoadedState).copyWith(isFollowed: true));
          result = await _followSubthemeUseCase(FollowSubthemeUseCaseParams(
              categoryId: currentState.categoryId!,
              shouldFollow: true,
              themeId: currentState.themeId!));
        }

        if (result.isErr) {
          logError(
              // ignore: lines_longer_than_80_chars
              "Error while following theme for search results for Theme: ${currentState.themeId} and category: ${currentState.categoryId}.",
              error: result.err);
        }
      } catch (e) {
        logError(e.toString(), error: Exception(e));
      }
    }
  }

  Future<void> onSearchOptionChanged(
      SearchOptionChangedEvent event, Emitter<SearchResultsState> emit) async {
    if (!event.isInfiniteScroll) {
      emit((state as SearchResultsLoadedState).copyWith(isBusy: true));
    }
    final uSettingsResult = await _userSettingsUseCase(null);

    final result = await _searchProductUseCase(SearchUseCaseParams(
        query: event.query,
        take: pageSize,
        skip: event.skip,
        searchContext: event.searchContext ?? SearchContext.product,
        sortOption: event.sortOption,
        deviceLanguage: uSettingsResult.isOk
            ? (uSettingsResult.ok?.preferredLanguageCode ?? '')
            : '',
        premiumDisplayOption: event.premiumDisplayOption,
        languageId: event.languageId,
        themeId: event.themeId,
        categoryId: event.categoryId));

    final prods = result.ok?.products ?? [];
    final collections =
        result.ok != null && result.ok is CollectionSearchResultsEntity
            ? (result.ok! as CollectionSearchResultsEntity).collections ?? []
            : <CollectionSearchOutputItemEntity>[];
    final authors = result.ok != null && result.ok is PeopleSearchResultsEntity
        ? (result.ok! as PeopleSearchResultsEntity).people ?? []
        : <PeopleSearchOutputItemEntity>[];
    if (result.isErr) {
      logError("Error while searching products.", error: result.err);

      if (!await _connectivityService.isInternetAvailable) {
        emit(SearchResultsErrorState(
            previousState: state as SearchResultsLoadedState,
            error: ErrorType.noInternet));
        return;
      }
    }

    emit(SearchResultsLoadedState(
        products: event.isInfiniteScroll
            ? [...(state as SearchResultsLoadedState).products, ...prods]
            : prods,
        authors: event.isInfiniteScroll
            ? [...(state as SearchResultsLoadedState).authors]
            : authors,
        collections: event.isInfiniteScroll
            ? [...(state as SearchResultsLoadedState).collections]
            : collections,
        hasNextPage: prods.length >= pageSize,
        title: _title,
        categories: result.ok?.categories ?? [],
        facets: result.ok?.themes ?? [],
        languages: result.ok?.languages ?? [],
        premiumDisplayOption: event.premiumDisplayOption,
        languageId: event.languageId ?? 0,
        selections: _selections,
        categoryId: event.categoryId ?? 0,
        sortOption: event.sortOption,
        themeId: event.themeId ?? 0,
        searchContext: event.searchContext,
        query: event.query,
        skip: event.skip));
  }
}
