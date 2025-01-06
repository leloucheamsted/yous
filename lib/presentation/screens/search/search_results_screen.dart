import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/entities/language_entity.dart';
import 'package:youscribe/core/entities/product_category_entity.dart';
import 'package:youscribe/core/entities/product_facet_entity.dart';
import 'package:youscribe/core/extensions/build_context_extension.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe/presentation/blocs/search/search_results/search_results_bloc.dart';
import 'package:youscribe/presentation/blocs/search/shared.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/screens/search/search_results_screen_params.dart';
import 'package:youscribe/presentation/screens/search/widgets/search_options_view.dart';
import 'package:youscribe/presentation/screens/search/widgets/search_result_skeleton_loader.dart';
import 'package:youscribe/presentation/screens/search/widgets/search_results_list_view.dart';
import 'package:youscribe/presentation/widgets/custom_path_icon.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/path_icons.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/utilities/constants.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen(
      {required this.params, super.key, this.isYsClassfification});

  final SearchResultScreenParams? params;
  final bool? isYsClassfification;
  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  bool _isLargeDisplay = false;
  final ScrollController _scrollViewController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<SearchResultsBloc, SearchResultsState>(
      builder: (context, state) {
        Widget body = const Placeholder();

        if (state is SearchResultsInitialState) {
          body = SearchResultSkeletonLoader(
            title: widget.params?.categoryTitle ?? '',
          );
          context.read<SearchResultsBloc>().add(InitizeSearchResultsEvent(
                categoryId: widget.params?.categoryId ?? 0,
                isFromFirstFacet: false,
                pageSize: pageSize,
                categoryTtitle: widget.params?.categoryTitle ?? '',
                currentThemeId: widget.params?.currentThemeId,
                query: widget.params?.query,
                searchContext: widget.params?.searchContext,
                themeId: widget.params?.currentThemeId,
                themeOrder: widget.params?.themeOrder,
              ));
        } else {
          if (state is SearchResultsErrorState) {
            if (state.error == ErrorType.noInternet) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Dialogs.displayInternetNeededAlert(context: context);
              });
            } else if (state.error == ErrorType.serverError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.showErrorSnackBar(
                    AppLocalizations.of(context)!.aPIErrorOccuredGeneralTitle);
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.showErrorSnackBar(
                    AppLocalizations.of(context)!.errorOccuredGeneralTitle);
              });
            }
            context
                .read<SearchResultsBloc>()
                .add(SearchResultsErrorDisplayedEvent());
            state = state.previousState;
          }

          if (state is SearchResultsLoadedState) {
            body = _buildSearchResultsPage(context, state);
          }
        }

        return body;
      },
    ));
  }

  Widget _buildSearchResultsPage(
      BuildContext context, SearchResultsLoadedState state) {
    final languages = [
      LanguageEntity(label: AppLocalizations.of(context)!.allLanguages, id: 0),
      ...state.languages
    ];

    return Center(
        child: Column(
      children: [
        SearchOptionsView(
          languages: languages,
          title: state.title,
          isYsClassfification: widget.isYsClassfification ?? true,
          scrollViewController: _scrollViewController,
          categories: [
            ProductCategoryEntity(
                name: AppLocalizations.of(context)!.everyCategories,
                id: 0,
                label: AppLocalizations.of(context)!.everyCategories),
            ...state.categories
          ],
          themes: [
            ProductFacetEntity(
                name: AppLocalizations.of(context)!.everyThemes,
                id: 0,
                label: AppLocalizations.of(context)!.everyThemes),
            ...state.facets
          ],
          premiumDisplayOption: PremiumDisplayOption.display,
          tableDisplayChanged: _tableDisplayChanged,
          searchContext: state.searchContext ?? SearchContext.product,
          searchText: state.query ?? '',
          selectedCategoryId: state.categoryId,
          selectedLanguageId: state.languageId,
          selectedThemeId: state.themeId,
          sortOption: state.query.isNotNullOrEmpty
              ? SortOption.relevance
              : state.sortOption ?? SortOption.mostRead,
        ),
        Expanded(
            child: SizedBox(
                child: Stack(children: [
          SizedBox(
            child: _shouldDisplayEmptyView(state)
                ? _emptyListSearch()
                : Container(
                    padding: const EdgeInsets.all(8),
                    transform: Matrix4.translationValues(0, -4, 0),
                    child: Stack(children: [
                      SearchResultsListView(
                        scrollViewController: _scrollViewController,
                        searchContext:
                            state.searchContext ?? SearchContext.product,
                        onInfiniteScroll: () => _infiniteScroll(context),
                        onAuthorSelected: _authorsSelected,
                        onCollectionSelected: _collectionSelected,
                        collections: state.collections,
                        authors: state.authors,
                        hasNextPage: state.hasNextPage,
                        products: state.products,
                        onProductSelected: _productSelected,
                        isLargeTile: _isLargeDisplay,
                      ),
                      if (state.canFollow)
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: FloatingActionButton(
                                backgroundColor: YouScribeColors.accentColor,
                                onPressed: () {
                                  context
                                      .read<SearchResultsBloc>()
                                      .add(FollowSelectedEvent());
                                  if (state.isFollowed) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      ScaffoldMessenger.maybeOf(context)
                                          ?.showSnackBar(SnackBar(
                                              backgroundColor:
                                                  YouScribeColors.accentColor,
                                              content: Text(
                                                AppLocalizations.of(context)!
                                                    // ignore: lines_longer_than_80_chars
                                                    .youStoppedFollowingSubTheme,
                                                maxLines: 3,
                                              )));
                                    });
                                  } else {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      ScaffoldMessenger.maybeOf(context)
                                          ?.showSnackBar(SnackBar(
                                              backgroundColor:
                                                  YouScribeColors.accentColor,
                                              content: Text(
                                                  AppLocalizations.of(context)!
                                                      .youNowFollowThisSubTheme,
                                                  maxLines: 3)));
                                    });
                                  }
                                },
                                child: state.isFollowed
                                    ? CustomPathIcon(
                                        path:
                                            PathIcons.filledFontAwesomeBellIcon,
                                        fontSize: 28,
                                      )
                                    : const FontAwesomeTextIcon(
                                        font: FontIcons.fontAwesomeBell,
                                        fontSize: 25,
                                        color: YouScribeColors.whiteColor)),
                          ),
                        )
                    ]),
                  ),
          ),
          if (state.isBusy) _buildSearchResultsLoader(context),
        ])))
      ],
    ));
  }

  bool _shouldDisplayEmptyView(SearchResultsLoadedState state) {
    if (state.searchContext == SearchContext.product) {
      return state.products.isNullOrEmpty;
    } else if (state.searchContext == SearchContext.collection) {
      return state.collections.isNullOrEmpty;
    } else {
      return state.authors.isNullOrEmpty;
    }
  }

  Widget _emptyListSearch() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FontAwesomeTextIcon(
                font: FontIcons.fontAwesomePersevering,
                fontSize: 50,
                color: YouScribeColors.primaryAppColor),
            Text(
              AppLocalizations.of(context)!.emptyListSearch,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _infiniteScroll(BuildContext context) async {
    final state = context.read<SearchResultsBloc>().state;
    if (state is SearchResultsLoadedState) {
      context.read<SearchResultsBloc>().add(SearchOptionChangedEvent(
          premiumDisplayOption: state.premiumDisplayOption,
          isInfiniteScroll: true,
          languageId: state.languageId,
          categoryId: state.categoryId,
          sortOption: state.sortOption,
          themeId: state.themeId,
          searchContext: state.searchContext,
          query: state.query,
          skip: state.products.length));
    }
  }

  Future<void> _productSelected(int productId) async {
    await context.pushNamed(Routes.productDetails, queryParameters: {
      Routes.productIdParamName: productId.toString(),
    });
  }

  Future<void> _authorsSelected(int authorId, String title) async {
    await context.pushNamed(Routes.authorPage, queryParameters: {
      Routes.authorIdParamName: authorId.toString(),
      Routes.authorTitleParamName: title,
    });
  }

  Future<void> _collectionSelected(int collectionId, String title) async {
    await context.pushNamed(Routes.collectionDetails, queryParameters: {
      Routes.collectionIdParamName: collectionId.toString(),
      Routes.collectionTitleParamName: title
    });
  }

  Future<void> _tableDisplayChanged(bool isLargeDisplay) async {
    setState(() {
      _isLargeDisplay = isLargeDisplay;
    });
  }

  Widget _buildSearchResultsLoader(BuildContext context) {
    //TODO: implement
    return const Padding(
      padding: EdgeInsets.only(bottom: 100),
      child: Center(
        child: CircularProgressIndicator(
          color: YouScribeColors.accentColor,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    super.dispose();
  }
}
