import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/entities/product_facet_entity.dart';
import 'package:youscribe/core/extensions/build_context_extension.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe/presentation/blocs/library/second_level/classifications_bloc.dart';
import 'package:youscribe/presentation/blocs/search/shared.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/screens/library/library_screen.dart';
import 'package:youscribe/presentation/screens/library/widgets/classification_skelethon_view.dart';
import 'package:youscribe/presentation/screens/library/widgets/facet_item_list_view.dart';
import 'package:youscribe/presentation/screens/search/search_results_screen_params.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class ClassificationScreen extends StatefulWidget {
  const ClassificationScreen(
      {required this.facetName, required this.productFacets, super.key});
  final String facetName;
  final List<BaseProductFacetEntity> productFacets;
  @override
  State<ClassificationScreen> createState() => _ClassificationScreenState();
}

class _ClassificationScreenState extends State<ClassificationScreen> {
  bool isBusy = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        BlocBuilder<ClassificationsBloc, ClassificationsState>(
            builder: (context, state) {
      final bloc = context.read<ClassificationsBloc>();

      if (state is ClassificationErrorState) {
        if (state.errorType == ErrorType.serverError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Dialogs.displayGeneralAPIErrorAlert(context: context);
          });
        } else if (state.errorType == ErrorType.noInternet) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Dialogs.displayInternetNeededAlert(context: context);
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.showErrorSnackBar(
                  AppLocalizations.of(context)!.errorOccuredGeneralTitle);
          });
        }

        bloc.add(const ErrorDisplayedEvent());
        state = state.previousState;
      }

      if (state is ClassificationsInitialState) {
        return ClassificationsSkelethonView(facetName: widget.facetName);
      }

      final loadedState = state as ClassificationsLoadedState;
      return Stack(
        children: [
          ColoredBox(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ColoredBox(
                  color: YouScribeColors.primaryAppColor,
                  child: SizedBox(
                    height: 90,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Material(
                            color: YouScribeColors.primaryAppColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: InkWell(
                              onTap: () {
                                context.pop(context);
                              },
                              borderRadius: BorderRadius.circular(40),
                              child: Container(
                                height: 40,
                                width: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: const FontAwesomeTextIcon(
                                    font: FontIcons.fontAwesomeArrowLeft,
                                    fontSize: 24,
                                    color: YouScribeColors.whiteColor),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    child: widget.productFacets.isNotEmpty
                                        ? FontAwesomeTextIcon(
                                            font: getFontAwesomeIconForCategory(
                                                widget
                                                    .productFacets.last.name!),
                                            fontSize: 24,
                                            color: YouScribeColors.whiteColor)
                                        : null,
                                  ),
                                  SizedBox(
                                      width: widget.productFacets.isNotEmpty
                                          ? 18
                                          : 0),
                                  Text(
                                    widget.facetName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: YouScribeColors.whiteColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 40),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        _seeMore(context),
                        const SizedBox(height: 40),
                        ...List.generate(loadedState.productFacets.length,
                            (index) {
                          final facet = loadedState.productFacets[index];
                          return FacetItemListView(
                              title: facet.label!,
                              onFacetSelected: () async {
                                final ConnectivityService connectivityService =
                                    locator();
                                if (!await connectivityService
                                    .isInternetAvailable) {
                                  if (context.mounted) {
                                    await Dialogs.displayInternetNeededAlert(
                                        context: context);
                                  }
                                  return;
                                }
                                setState(() {
                                  isBusy = true;
                                });
                                final isHasChildreen =
                                    await bloc.isHasChildreen(facet);
                                if (isHasChildreen) {
                                  final queryParams = SearchResultScreenParams(
                                      searchContext: SearchContext.product,
                                      query: '',
                                      categoryId: widget.productFacets[0].id,
                                      themeOrder: [
                                        ...widget.productFacets
                                            .map((e) => e.id!),
                                        facet.id!
                                      ],
                                      currentThemeId: facet.id);
                                  if (context.mounted) {
                                    await context.pushNamed(
                                        Routes.searchResults,
                                        extra: queryParams);
                                  }
                                } else {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) async {
                                    await context.pushNamed(
                                        Routes.classification,
                                        extra: [
                                          ...widget.productFacets,
                                          facet
                                        ]);
                                  });
                                }
                                setState(() {
                                  isBusy = false;
                                });
                              });
                        }),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
          SizedBox(
            child: isBusy
                ? const Center(
                    child: CircularProgressIndicator(
                      color: YouScribeColors.primaryAppColor,
                    ),
                  )
                : null,
          ),
        ],
      );
    }));
  }

  Widget _seeMore(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(30),
      child: Ink(
          child: InkWell(
        onTap: () async {
          final ConnectivityService connectivityService = locator();
          if (!await connectivityService.isInternetAvailable) {
            if (context.mounted) {
              await Dialogs.displayInternetNeededAlert(context: context);
            }
            return;
          }
          final queryParams = SearchResultScreenParams(
            searchContext: SearchContext.product,
            query: '',
            categoryId: widget.productFacets.last.id,
            themeOrder: [...widget.productFacets.map((e) => e.id!)],
          );
          if (context.mounted) {
            await context.pushNamed(Routes.searchResults, extra: queryParams);
          }
        },
        borderRadius: BorderRadius.circular(30),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: YouScribeColors.primaryAppColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '••• ${AppLocalizations.of(context)!.seeMore}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: YouScribeColors.primaryAppColor),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
