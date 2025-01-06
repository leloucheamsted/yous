import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/entities/product_facet_entity.dart';
import 'package:youscribe/core/extensions/build_context_extension.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe/presentation/blocs/library/first_level/library_bloc.dart';
import 'package:youscribe/presentation/blocs/search/shared.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/screens/library/widgets/explorer_item_view.dart';
import 'package:youscribe/presentation/screens/library/widgets/explorer_tab_item.dart';
import 'package:youscribe/presentation/screens/library/widgets/library_skeleton_view.dart';
import 'package:youscribe/presentation/screens/search/search_results_screen_params.dart';
import 'package:youscribe/presentation/screens/shared/no_internet_view.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/utilities/constants.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final double _headerHeight = 180;
  late BaseProductFacetEntity currentFacet = BaseProductFacetEntity();
  bool isBusy = false;
  bool hasInternetConnexion = true;
  bool isFirstOpen = false;
  final RxSharedPreferences rxPrefs = locator();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    rxPrefs
        .getBoolStream(PreferenceKey.libraryIsReloaded)
        .map((event) => event ?? false)
        .listen((event) {
      if (event) {
        setState(() {
          isFirstOpen = true;
        });
        rxPrefs.setBool(PreferenceKey.libraryIsReloaded, false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocBuilder<LibraryBloc, LibraryState>(builder: (context, state) {
          final bloc = context.read<LibraryBloc>();

          if (state is LibraryExceptionState) {
            if (state.errorType == ErrorType.noInternet) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  hasInternetConnexion = false;
                });
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.showErrorSnackBar(
                  AppLocalizations.of(context)!.errorOccuredGeneralTitle);
              });
            }
            context.read<LibraryBloc>().add(ErrorDisplayedEvent());
            state = state.previousState;
          }
          if (state is LibraryInitialState) {
            return const LibrarySkeletonView();
          }
          if (isFirstOpen) {
            bloc.add(const LibraryInitEvent());
            isFirstOpen = false;
          }
          final loadedState = state as LibraryLoadedState;
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: _headerHeight,
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(ImagesName.headerBackground)),
                        ),
                      ),
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: const Alignment(0, 0.2),
                              end: Alignment.topCenter,
                              colors: [
                                YouScribeColors.primaryAppColor,
                                YouScribeColors.primaryAppColor
                                    .withOpacity(0.65),
                              ]),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 55),
                            GestureDetector(
                              onTap: () async {
                                bloc.add(const LibraryInitEvent());
                              },
                              child: Text(
                                AppLocalizations.of(context)!.explorerPageTitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: YouScribeColors.whiteColor,
                                        fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 45,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  ...List.generate(
                                      loadedState.productFacets.length,
                                      (index) {
                                    final productFacet =
                                        loadedState.productFacets[index];
                                    final fontIcon =
                                        getFontAwesomeIconForCategory(
                                            productFacet.name!);
                                    return ExplorerTabItem(
                                        isYsClassificationTree:
                                            loadedState.isYsClassfification,
                                        currentThemeIndex:
                                            loadedState.currentThemeIndex,
                                        id: productFacet.id ?? 0,
                                        exploreName:
                                            loadedState.isYsClassfification
                                                ? "  ${productFacet.label!}  "
                                                : productFacet.label!,
                                        onCategorySelected: () async {
                                          if (productFacet.id == 67) {
                                            final queryParams =
                                                SearchResultScreenParams(
                                                    searchContext:
                                                        SearchContext.product,
                                                    query: '',
                                                    categoryId: productFacet.id,
                                                    themeOrder: [
                                                  productFacet.id!
                                                ]);
                                            if (context.mounted) {
                                              await context.pushNamed(
                                                  Routes.searchResults,
                                                  extra: queryParams);
                                            }
                                            return;
                                          }
                                          await bloc.changeIndex(
                                              productFacet.id ?? 0);
                                          late final ConnectivityService
                                              connectivityService = locator();
                                          if (!await connectivityService
                                              .isInternetAvailable) {
                                            if (context.mounted) {
                                              await Dialogs
                                                  .displayInternetNeededAlert(
                                                      context: context);
                                            }
                                            return;
                                          }
                                          setState(() {
                                            currentFacet = productFacet;
                                            isBusy = true;
                                          });

                                          context.read<LibraryBloc>().add(
                                              FirstSearchOptionSelectedEvent(
                                                  firstLevelOption:
                                                      productFacet));

                                          if (loadedState
                                              .secondproductFacets.isEmpty) {
                                            final queryParams =
                                                SearchResultScreenParams(
                                                    searchContext:
                                                        SearchContext.product,
                                                    query: '',
                                                    categoryId: productFacet.id,
                                                    themeOrder: [
                                                  productFacet.id!
                                                ]);
                                            if (context.mounted) {
                                              await context.pushNamed(
                                                  Routes.searchResults,
                                                  extra: queryParams);
                                            }
                                          }
                                          setState(() {
                                            isBusy = false;
                                          });
                                        },
                                        fontIcon: fontIcon);
                                  })
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: _headerHeight - 30,
                left: 0,
                right: 0,
                child: Stack(
                  children: [
                    SizedBox(
                        height:
                            MediaQuery.of(context).size.height - _headerHeight,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40)),
                            child: SizedBox(
                              child: hasInternetConnexion
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            const SizedBox(height: 40),
                                            Wrap(
                                              spacing: 20,
                                              runSpacing: 12,
                                              children: [
                                                ...List.generate(
                                                    loadedState
                                                        .secondproductFacets
                                                        .length, (index) {
                                                  final facet = loadedState
                                                          .secondproductFacets[
                                                      index];
                                                  final fontIcon =
                                                      getFontAwesomeIconForCategory(
                                                          facet.name!);
                                                  return ExplorerItemView(
                                                      name: loadedState
                                                              .isYsClassfification
                                                          ? facet.name!
                                                          : facet.label!,
                                                      isYsClassfification:
                                                          loadedState
                                                              .isYsClassfification,
                                                      onCategorySelected:
                                                          () async {
                                                        final queryParams = SearchResultScreenParams(
                                                            searchContext:
                                                                SearchContext
                                                                    .product,
                                                            query: '',
                                                            categoryTitle:
                                                                currentFacet
                                                                    .label,
                                                            currentThemeTitle:
                                                                facet.label,
                                                            categoryId: loadedState
                                                                    .isYsClassfification
                                                                ? loadedState
                                                                    .currentThemeIndex
                                                                : null,
                                                            themeOrder: [
                                                              loadedState
                                                                  .currentThemeIndex,
                                                              facet.id!
                                                            ],
                                                            currentThemeId:
                                                                facet.id);
                                                        if (context.mounted) {
                                                          await context.pushNamed(
                                                              Routes
                                                                  .searchResults,
                                                              queryParameters: {
                                                                Routes.isYsClassfificationParamName:
                                                                    loadedState
                                                                        .isYsClassfification
                                                                        .toString()
                                                              },
                                                              extra:
                                                                  queryParams);
                                                        }
                                                      },
                                                      fontIcon: fontIcon,
                                                      exploreName:
                                                          facet.label!);
                                                })
                                              ],
                                            ),
                                            const SizedBox(height: 70)
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      color: YouScribeColors.whiteColor,
                                      child: const NoInternetView()),
                            ))),
                    SizedBox(
                      child: isBusy
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height -
                                  _headerHeight,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: YouScribeColors.primaryAppColor,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          );
        }));
  }
}

String getFontAwesomeIconForCategory(String name) {
  switch (name) {
    case RootName.poodcast:
      return FontIcons.fontAwesomePodcast;
    case RootName.partition:
      return FontIcons.fontAwesomeFileAudio;
    case RootName.document:
      return FontIcons.fontAwesomeFileAlt;
    case RootName.audiobooks:
      return FontIcons.fontAwesomeHeadphonesAlt;
    case RootName.externalLink:
      return FontIcons.fontAwersomeArrowUpRightSquare;
    case RootName.books:
      return FontIcons.fontAwesomeBookOpen;
    case RootName.video:
      return FontIcons.fontAwersomeVideo;
    case RootName.bd:
      return FontIcons.fontAwesomeComments;
    case RootName.press:
      return FontIcons.fontAwesomeNewsPaper;
    default:
      return FontIcons.fontAwesomeBookOpen;
  }
}

class RootName {
  static const poodcast = "podcasts_root";
  static const partition = "partition_root";
  static const document = "document_scolaire_root";
  static const String audiobooks = "audiobooks_root";
  static const String externalLink = "external_link_root";
  static const String books = "book_root";
  static const String video = "video_root";
  static const String bd = "bd_root";
  static const String press = "press_root";
}
