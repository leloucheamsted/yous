import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/extensions/build_context_extension.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe/presentation/blocs/premium_suggestion/premium_suggestion_bloc.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/widgets/item_image_view.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class PremiumSuggestionScreen extends StatelessWidget {
  const PremiumSuggestionScreen({required this.productId, super.key});
  final int productId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PremiumSuggestionBloc, PremiumSuggestionState>(
        builder: (context, state) {
      final bloc = context.read<PremiumSuggestionBloc>();

      if (state is PremiumSuggestionErrorState) {
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
      if (state is PremiumSuggestionStateInitial) {
        return Scaffold(
          body: Stack(children: [
            Container(
              width: MediaQuery.of(context).size.width,
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
            ),
          ]),
        );
      }
      final loadedState = state as PremiumSuggestionStateLoading;
      return Scaffold(
        body: Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
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
                  const SizedBox(height: 40),
                  Text(
                    textAlign: TextAlign.center,
                    AppLocalizations.of(context)!.spendTokenTitle,
                    style: const TextStyle(
                      color: YouScribeColors.whiteColor,
                      overflow: TextOverflow.clip,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    textAlign: TextAlign.center,
                    AppLocalizations.of(context)!
                        .endOfExtractReachedForSubscriberWithToken,
                    style: const TextStyle(
                      fontWeight: FontWeight.w200,
                      overflow: TextOverflow.clip,
                      color: YouScribeColors.whiteColor,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 20,
                      runSpacing: -10,
                      children: [
                        ...List.generate(loadedState.products.length, (index) {
                          final product = loadedState.products[index];
                          return SizedBox(
                              height: 250,
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 19,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Material(
                                  color: Colors.transparent,
                                  child: Ink(
                                    child: InkWell(
                                      onTap: () async {
                                        await context.pushNamed(
                                            Routes.productDetails,
                                            queryParameters: {
                                              Routes.productIdParamName:
                                                  product.id.toString()
                                            });
                                      },
                                      child: SizedBox(
                                        child: ItemImageView(
                                            productImageUrl: product.imageUrl!,
                                            height: 200,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2),
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                        })
                      ],
                    ),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () async {
                              // Navigator.pop(context, true);
                              // call useToken
                              final result = await bloc.useToken(productId);
                              if (context.mounted) {
                                switch (result) {
                                  case PremiumSuggestionsResult
                                        .shouldNavigateToHelp:
                                    Navigator.pop(
                                        context,
                                        PremiumSuggestionsResult
                                            .shouldNavigateToHelp);
                                  case PremiumSuggestionsResult.shouldSubscribe:
                                    Navigator.pop(
                                        context,
                                        PremiumSuggestionsResult
                                            .shouldSubscribe);
                                  //  await cubit.callSubscriptionPopup(false);
                                  case PremiumSuggestionsResult.noInternet:
                                    Navigator.pop(context,
                                        PremiumSuggestionsResult.noInternet);
                                  case PremiumSuggestionsResult.hasUsedToken:
                                    Navigator.pop(context,
                                        PremiumSuggestionsResult.hasUsedToken);
                                  case PremiumSuggestionsResult.errorServer:
                                    Navigator.pop(context,
                                        PremiumSuggestionsResult.errorServer);
                                  case PremiumSuggestionsResult.errorUnknown:
                                    Navigator.pop(context,
                                        PremiumSuggestionsResult.errorUnknown);
                                  case PremiumSuggestionsResult.noResult:
                                    Navigator.pop(context,
                                        PremiumSuggestionsResult.noResult);
                                  default:
                                }
                              }
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                )),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  YouScribeColors.primaryAppColor,
                                ),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                  YouScribeColors.whiteColor,
                                )),
                            child: Text(
                              AppLocalizations.of(context)!.letsGo,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: YouScribeColors.whiteColor,
                                      fontWeight: FontWeight.w800),
                            )),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(
                                  context, PremiumSuggestionsResult.noResult);
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                )),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  YouScribeColors.primaryAppColor,
                                ),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                  YouScribeColors.whiteColor,
                                )),
                            child: Text(
                              AppLocalizations.of(context)!.noThanks,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: YouScribeColors.whiteColor,
                                      fontWeight: FontWeight.w800),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: Platform.isIOS ? 16 : 8),
                ],
              ),
            ),
          ),
          SizedBox(
            child: loadedState.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: YouScribeColors.whiteColor,
                    ),
                  )
                : null,
          ),
        ]),
      );
    });
  }
}
