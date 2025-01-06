import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/extensions/build_context_extension.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe/presentation/blocs/suggestion/suggestion_bloc.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/screens/products/widgets/product_info_view.dart';
import 'package:youscribe/presentation/screens/products/widgets/simple_product_view.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        BlocBuilder<SuggestionBloc, SuggestionState>(builder: (context, state) {
      final bloc = context.read<SuggestionBloc>();

      if (state is SuggestionErrorState) {
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
      if (state is SuggestionInitialState) {
        return _loadInitView();
      }

      final loadedState = state as SuggestionStateLoadedState;

      return Stack(
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.1,
                1,
              ],
              colors: [
                YouScribeColors.primaryAppColor,
                YouScribeColors.accentColor,
              ],
            )),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.recommendedForYou,
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: YouScribeColors.whiteColor,
                                      fontSize: WidgetStyles.title2Size,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 20,
                            runSpacing: -10,
                            children: [
                              ...List.generate(loadedState.products.length,
                                  (index) {
                                final product = loadedState.products[index];
                                return SizedBox(
                                    height: 280,
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        19,
                                    child: ProductInfoView(
                                      title: "",
                                      author: "",
                                      titleTextAlign: TextAlign.center,
                                      titleFontWeight: FontWeight.w700,
                                      titleSize: 14,
                                      titleColor: YouScribeColors.whiteColor,
                                      productWidget: SimpleProductView(
                                        productId: product.id!,
                                        productImageUrl: product.imageUrl!,
                                        height: 250,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        floatingWidgetSize: 30,
                                        imgBorderRadius:
                                            BorderRadius.circular(5),
                                        productType: product.productType,
                                        onProductSelected: (val) async {
                                          await context.pushNamed(
                                              Routes.productDetails,
                                              queryParameters: {
                                                Routes.productIdParamName:
                                                    val.toString()
                                              });
                                        },
                                      ),
                                    ));
                              })
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                YouScribeColors.primaryAppColor,
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                YouScribeColors.whiteColor,
                              )),
                          child: Text(
                            AppLocalizations.of(context)!.cancel,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: YouScribeColors.whiteColor,
                                    fontWeight: FontWeight.w800),
                          )),
                    ],
                  ),
                  SizedBox(height: Platform.isIOS ? 16 : 8),
                ],
              ),
            ),
          ),
          SizedBox(
            child: loadedState.isBusy
                ? const Center(
                    child: CircularProgressIndicator(
                      color: YouScribeColors.whiteColor,
                    ),
                  )
                : null,
          ),
        ],
      );
    }));
  }

  Widget _loadInitView() {
    return const Stack(children: [
      DecoratedBox(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
            0.1,
            1,
          ],
          colors: [
            YouScribeColors.primaryAppColor,
            YouScribeColors.accentColor,
          ],
        )),
        child: Center(
          child: CircularProgressIndicator(
            color: YouScribeColors.whiteColor,
          ),
        ),
      )
    ]);
  }
}
