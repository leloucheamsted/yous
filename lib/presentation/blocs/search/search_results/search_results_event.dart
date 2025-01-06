part of 'search_results_bloc.dart';

sealed class SearchResultsEvent extends Equatable {
  const SearchResultsEvent();

  @override
  List<Object?> get props => [];
}

class FollowSelectedEvent extends SearchResultsEvent {}

class InitizeSearchResultsEvent extends SearchResultsEvent {
  const InitizeSearchResultsEvent({
    required this.query,
    required this.categoryId,
    required this.categoryTtitle,
    required this.searchContext,
    required this.currentThemeId,
    required this.themeOrder,
    required this.themeId,
    required this.pageSize,
    required this.isFromFirstFacet,
  });

  final String? query;
  final int? categoryId;
  final String? categoryTtitle;
  final SearchContext? searchContext;
  final int? currentThemeId;
  final int? themeId;
  final int? pageSize;
  final bool? isFromFirstFacet;
  final List<int>? themeOrder;

  @override
  List<Object?> get props => [
        query,
        categoryId,
        categoryTtitle,
        currentThemeId,
        themeOrder,
        themeId,
        pageSize,
        isFromFirstFacet
      ];
}

class SearchResultsErrorDisplayedEvent extends SearchResultsEvent {}

class SearchOptionChangedEvent extends SearchResultsEvent {
  const SearchOptionChangedEvent({
    required this.premiumDisplayOption,
    required this.languageId,
    required this.searchContext,
    required this.categoryId,
    required this.sortOption,
    required this.themeId,
    required this.query,
    this.isInfiniteScroll = false,
    this.skip = 0,
  });

  final PremiumDisplayOption? premiumDisplayOption;
  final int? languageId;
  final int? categoryId;
  final SortOption? sortOption;
  final int? themeId;
  final SearchContext? searchContext;
  final String? query;
  final int skip;
  final bool isInfiniteScroll;

  SearchOptionChangedEvent copyWith({
    PremiumDisplayOption? premiumDisplayOption,
    int? languageId,
    int? categoryId,
    SortOption? sortOption,
    int? themeId,
    SearchContext? searchContext,
    String? query,
  }) {
    return SearchOptionChangedEvent(
      premiumDisplayOption: premiumDisplayOption ?? this.premiumDisplayOption,
      languageId: languageId ?? this.languageId,
      categoryId: categoryId ?? this.categoryId,
      sortOption: sortOption ?? this.sortOption,
      themeId: themeId ?? this.themeId,
      searchContext: searchContext ?? this.searchContext,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [
        premiumDisplayOption,
        categoryId,
        themeId,
        languageId,
        sortOption,
        searchContext,
        skip,
      ];
}
