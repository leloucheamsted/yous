part of 'search_results_bloc.dart';

sealed class SearchResultsState extends Equatable {
  const SearchResultsState();

  @override
  List<Object> get props => [];
}

final class SearchResultsInitialState extends SearchResultsState {}

final class SearchResultsLoadingState extends SearchResultsState {}

final class SearchResultsLoadedState extends SearchResultsState {
  const SearchResultsLoadedState(
      {required this.products,
      required this.collections,
      required this.authors,
      required this.hasNextPage,
      required this.categories,
      required this.title,
      required this.facets,
      required this.languages,
      required this.selections,
      this.canFollow = false,
      this.isFollowed = false,
      this.isBusy = false,
      this.premiumDisplayOption,
      this.languageId,
      this.categoryId,
      this.sortOption,
      this.themeId,
      this.subThemeId,
      this.searchContext,
      this.query,
      this.skip = 0});

  final List<ProductFacetEntity> facets;
  final List<ProductEntity> products;
  final List<PeopleSearchOutputItemEntity> authors;
  final List<CollectionSearchOutputItemEntity> collections;
  final bool hasNextPage;
  final String title;
  final List<LanguageEntity> languages;
  final List<ProductCategoryEntity> categories;
  final List<SelectionEntity> selections;
  final bool isBusy;
  final PremiumDisplayOption? premiumDisplayOption;
  final int? languageId;
  final int? categoryId;
  final SortOption? sortOption;
  final int? themeId;
  final int? subThemeId;
  final SearchContext? searchContext;
  final String? query;
  final int skip;
  final bool canFollow;
  final bool isFollowed;

  SearchResultsLoadedState copyWith({
    List<ProductFacetEntity>? facets,
    bool? isFollowed,
    bool? canFollow,
    List<ProductEntity>? products,
    List<PeopleSearchOutputItemEntity>? authors,
    List<CollectionSearchOutputItemEntity>? collections,
    bool? hasNextPage,
    String? title,
    List<LanguageEntity>? languages,
    List<ProductCategoryEntity>? categories,
    bool? isBusy,
    PremiumDisplayOption? premiumDisplayOption,
    int? languageId,
    int? categoryId,
    SortOption? sortOption,
    int? themeId,
    int? subThemeId,
    List<SelectionEntity>? selections,
    SearchContext? searchContext,
    String? query,
    int? skip,
  }) {
    return SearchResultsLoadedState(
      facets: facets ?? this.facets,
      isFollowed: isFollowed ?? this.isFollowed,
      canFollow: canFollow ?? this.canFollow,
      products: products ?? this.products,
      authors: authors ?? this.authors,
      collections: collections ?? this.collections,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      title: title ?? this.title,
      selections: selections ?? this.selections,
      languages: languages ?? this.languages,
      categories: categories ?? this.categories,
      isBusy: isBusy ?? this.isBusy,
      premiumDisplayOption: premiumDisplayOption ?? this.premiumDisplayOption,
      languageId: languageId ?? this.languageId,
      categoryId: categoryId ?? this.categoryId,
      sortOption: sortOption ?? this.sortOption,
      themeId: themeId ?? this.themeId,
      subThemeId: subThemeId ?? this.subThemeId,
      searchContext: searchContext ?? this.searchContext,
      query: query ?? this.query,
      skip: skip ?? this.skip,
    );
  }

  @override
  List<Object> get props => [
        products,
        collections,
        authors,
        title,
        hasNextPage,
        isBusy,
        categories,
        facets,
        languages,
        canFollow,
        isFollowed,
        selections
      ];
}

final class SearchResultsErrorState extends SearchResultsState {
  const SearchResultsErrorState(
      {required this.error, required this.previousState});

  final ErrorType error;
  final SearchResultsLoadedState previousState;

  @override
  List<Object> get props => [error];
}
