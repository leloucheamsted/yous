// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/extensions/build_context_extension.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe/presentation/blocs/search/search_bloc.dart';
import 'package:youscribe/presentation/blocs/search/shared.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/screens/search/search_results_screen_params.dart';
import 'package:youscribe/presentation/screens/search/widgets/custom_app_bar.dart';
import 'package:youscribe/presentation/screens/search/widgets/search_view.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/utilities/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Debouncer _debouncer = Debouncer();
  final connectivity = locator<ConnectivityService>();
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          toolbarHeight: appBarHeight,
          flexibleSpace: CustomAppBar(
            handleSearchTextChange: _handleSearchTextChange,
          ),
        ),
        body: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
          if (state is SearchErrorState) {
            if (state.errorType == ErrorType.noInternet) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Dialogs.displayInternetNeededAlert(context: context);
              });
            } else if (state.errorType == ErrorType.serverError) {
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

            context.read<SearchBloc>().add(SearchErrorDisplayedEvent());
            state = state.previousState;
          }

          if (state is SearchInitialState) {
            return const Center(
              child: FontAwesomeTextIcon(
                  font: FontIcons.fontAwesomeMagnifyingGlass,
                  fontSize: 80,
                  color: YouScribeColors.primaryAppColor),
            );
          }

          if (state is SearchEmptyState) {
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

          if (state is SearchLoadedState) {
            return Stack(
              children: [
                SizedBox(
                  child: state.isBusy
                      ? const Center(
                          child: CircularProgressIndicator(
                              color: YouScribeColors.primaryAppColor))
                      : null,
                ),
                SearchView(
                    products: state.searchResults.products,
                    authors: state.searchResults.authors,
                    onAuthorSelected: _onAuthorSelected,
                    onCollectionSelected: _onCollectionSelected,
                    onProductGroupSelected: _onProductGroupSelected,
                    onProductSelected: _onProductSelected,
                    onAuthorsGroupSelected: _onAuthorsGroupSelected,
                    onCollectionsGroupSelected: _onCollectionsGroupSelected,
                    collections: state.searchResults.collections),
              ],
            );
          }
          return const SizedBox();
        }));
  }

  Future<void> _handleSearchTextChange(String value) async {
    final ConnectivityService connectivityService = locator();
    if (!await connectivityService.isInternetAvailable) {
      return;
    }
    _debouncer.debounce(
        duration: const Duration(seconds: 1),
        onDebounce: () {
          final Locale myLocale = Localizations.localeOf(context);
          _searchText = value;
          context.read<SearchBloc>().add(SearchTextChangedEvent(
              searchText: value, language: myLocale.languageCode));
        });
  }

  Future<void> _onProductGroupSelected() async {
    final ConnectivityService connectivityService = locator();
    if (!await connectivityService.isInternetAvailable) {
      if (context.mounted) {
        await Dialogs.displayInternetNeededAlert(context: context);
      }
      return;
    }

    final queryParams = SearchResultScreenParams(
        searchContext: SearchContext.product, query: _searchText);
    final currentUaser = await AuthenticationManager.getCurrentUser();
    final isYsClassfification = currentUaser!.isYSClassificationSettings;
    await context.pushNamed(Routes.searchResults,
        queryParameters: {
          Routes.isYsClassfificationParamName: isYsClassfification.toString()
        },
        extra: queryParams);
  }

  Future<void> _onCollectionsGroupSelected() async {
    final queryParams = SearchResultScreenParams(
        searchContext: SearchContext.collection, query: _searchText);
    final currentUaser = await AuthenticationManager.getCurrentUser();
    final isYsClassfification = currentUaser!.isYSClassificationSettings;
    await context.pushNamed(Routes.searchResults,
        queryParameters: {
          Routes.isYsClassfificationParamName: isYsClassfification.toString()
        },
        extra: queryParams);
  }

  Future<void> _onAuthorsGroupSelected() async {
    final queryParams = SearchResultScreenParams(
        searchContext: SearchContext.author, query: _searchText);
    final currentUaser = await AuthenticationManager.getCurrentUser();
    final isYsClassfification = currentUaser!.isYSClassificationSettings;
    await context.pushNamed(Routes.searchResults,
        queryParameters: {
          Routes.isYsClassfificationParamName: isYsClassfification.toString()
        },
        extra: queryParams);
  }

  Future<void> _onProductSelected(int productId) async {
    await context.pushNamed(Routes.productDetails, queryParameters: {
      Routes.productIdParamName: productId.toString(),
    });
  }

  Future<void> _onAuthorSelected(int authorId, String title) async {
    await context.pushNamed(Routes.authorPage, queryParameters: {
      Routes.authorIdParamName: authorId.toString(),
      Routes.authorTitleParamName: title,
    });
  }

  Future<void> _onCollectionSelected(int collectionId, String title) async {
    await context.pushNamed(Routes.collectionDetails, queryParameters: {
      Routes.collectionIdParamName: collectionId.toString(),
      Routes.collectionTitleParamName: title
    });
  }
}
