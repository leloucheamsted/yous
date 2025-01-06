import 'package:youscribe/presentation/blocs/search/shared.dart';

class SearchResultScreenParams {
  const SearchResultScreenParams(
      {required this.query,
      required this.searchContext,
      this.categoryId,
      this.categoryTitle,
      this.currentThemeTitle,
      this.currentThemeId,
      this.themeOrder});

  final String query;
  final SearchContext searchContext;
  final int? categoryId;
  final String? categoryTitle;
  final String? currentThemeTitle;
  final int? currentThemeId;
  final List<int>? themeOrder;
}
