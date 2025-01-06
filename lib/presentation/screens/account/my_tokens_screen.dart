import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/extensions/build_context_extension.dart';
import 'package:youscribe/presentation/blocs/app_purchase/app_purchase_cubit.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe/presentation/blocs/token/token_bloc.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/screens/products/widgets/collection_product_item_view.dart';
import 'package:youscribe/presentation/screens/shared/app_purchase_view.dart';
import 'package:youscribe/presentation/screens/shared/no_internet_view.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/styles/youscribe_theme.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe/utilities/youscribe_premium.dart';

class MyTokensScreen extends StatefulWidget {
  const MyTokensScreen({super.key});

  @override
  State<MyTokensScreen> createState() => _MyTokensScreenState();
}

class _MyTokensScreenState extends State<MyTokensScreen> {
  bool hasInternetConnexion = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0.5,
        title: Image(
            height: 35,
            image: AssetImage(Provider.of<YouScribeTheme>(context).brand)),
      ),
      body: BlocBuilder<TokenBloc, TokenState>(builder: (context, state) {
        final bloc = context.read<TokenBloc>();

        if (state is TokenErrorState) {
          //TODO: Handle error better.
          if (state.errorType == ErrorType.serverError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Dialogs.displayGeneralAPIErrorAlert(context: context);
            });
          } else if (state.errorType == ErrorType.noInternet) {
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

          bloc.add(const ErrorDisplayedEvent());
          state = state.previousState;
        }
        if (state is TokenInitialState) {
          return SizedBox(
            child: hasInternetConnexion
                ? const Center(
                    child: CircularProgressIndicator(
                    color: YouScribeColors.accentColor,
                  ))
                : const NoInternetView(),
          );
        }

        final loadedState = state as TokenLoadedState;
        return Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            child: hasInternetConnexion
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (!Provider.of<YouScribePremium>(context).isPremium)
                          _freeTrialBannerView(),
                        Text(
                          AppLocalizations.of(context)!.premiumTokenDetails,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(overflow: TextOverflow.clip),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          AppLocalizations.of(context)!.summary,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  overflow: TextOverflow.clip,
                                  fontSize: WidgetStyles.title3Size,
                                  fontWeight: FontWeight.w600,
                                  color: YouScribeColors.accentColor),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _tokenControlView(
                                description: loadedState.hasAvailableToken
                                    ? AppLocalizations.of(context)!
                                        .availableTokens
                                    : AppLocalizations.of(context)!
                                        .youDonotHaveAnyToken,
                                value: loadedState.hasAvailableToken
                                    ? loadedState.availableTokensCount
                                        .toString()
                                    : ''),
                            const SizedBox(width: 5),
                            _tokenControlView(
                                description: loadedState.hasNextToken
                                    ? AppLocalizations.of(context)!.nextToken
                                    : AppLocalizations.of(context)!
                                        .youDonotHaveAnyNextToken,
                                value: loadedState.hasNextToken
                                    ? DateFormat("dd-MM-yy")
                                        .format(loadedState.nextTokenDate!)
                                    : ''),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                            child: loadedState.hasAvailableToken &&
                                    loadedState.hasNextToken &&
                                    loadedState.hasTokenSubscription
                                ? null
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        loadedState.hasAvailableToken &&
                                                !loadedState.hasNextToken &&
                                                loadedState.hasTokenSubscription
                                            ? AppLocalizations.of(context)!
                                                .noTokenLeftMessage
                                            : loadedState.hasAvailableToken &&
                                                    loadedState.hasNextToken &&
                                                    loadedState
                                                        .hasTokenSubscription
                                                ? AppLocalizations.of(context)!
                                                    .tokenSubscriptionDescription
                                                : AppLocalizations.of(context)!
                                                    .tokenSubscriptionForUnsubscribedUserDescription,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                overflow: TextOverflow.clip),
                                      ),
                                      const SizedBox(height: 3),
                                      GestureDetector(
                                        onTap: () async {
                                          await context.pushNamed(Routes.help,
                                              extra: true);
                                        },
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .learnMore,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    overflow: TextOverflow.clip,
                                                    fontWeight: FontWeight.w600,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationColor:
                                                        Colors.blue,
                                                    decorationThickness: 2,
                                                    color: Colors.blue)),
                                      ),
                                      const SizedBox(height: 25),
                                    ],
                                  )),
                        Text(
                          AppLocalizations.of(context)!.usedTokens,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  overflow: TextOverflow.clip,
                                  fontSize: WidgetStyles.title3Size,
                                  fontWeight: FontWeight.w600,
                                  color: YouScribeColors.accentColor),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                            child: !loadedState.hasUsedTokens
                                ? Text(
                                    AppLocalizations.of(context)!
                                        .noUsedPremiumTokenFiller,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(overflow: TextOverflow.clip),
                                  )
                                : null),
                        // Text(
                        //   AppLocalizations.of(context)!.usedTokens,
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .bodyLarge!
                        //       .copyWith(
                        //           overflow: TextOverflow.clip,
                        //           fontSize: WidgetStyles.title3Size,
                        //           fontWeight: FontWeight.w600,
                        //           color: YouScribeColors.accentColor),
                        // ),
                        const SizedBox(height: 10),
                        SizedBox(
                          child: !loadedState.hasUsedTokens
                              ? Text(
                                  AppLocalizations.of(context)!
                                      .noUsedPremiumTokenFiller,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(overflow: TextOverflow.clip),
                                )
                              : null,
                        ),
                        SizedBox(
                          child: loadedState.hasUsedTokens
                              ? SizedBox(
                                  height: 180,
                                  child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        ...List.generate(
                                            loadedState.tokenProducts.length,
                                            (index) {
                                          //return const SizedBox();
                                          final product = loadedState
                                              .tokenProducts[index].product;
                                          return CollectionProductItemView(
                                            width: 140,
                                            onProductSelected: (id) async {
                                              await context.pushNamed(
                                                  Routes.productDetails,
                                                  queryParameters: {
                                                    Routes.productIdParamName:
                                                        id.toString(),
                                                  });
                                            },
                                            isPremium: product!.isPremium!,
                                            productId: product.id!,
                                            imgurl: product.imageUrl!,
                                            title: product.title!,
                                            productType: product.productType,
                                          );
                                        })
                                      ]))
                              : null,
                        ),
                      ],
                    ),
                  )
                : const NoInternetView(),
          ),
        );
      }),
    );
  }

  Widget _freeTrialBannerView() {
    final cubit = AppPurchaseCubit();
    return SizedBox(
      height: 220,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagesName.subscribeBanner),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.freeTrialDescription,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: WidgetStyles.title2Size,
                    color: YouScribeColors.whiteColor),
              ),
              const SizedBox(height: 20),
              AppPurchasView(
                  cubit: cubit,
                  isTokenScreen: true,
                  child: ElevatedButton(
                      onPressed: () => cubit.callSubscriptionPopup(true),
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.resolveWith(
                            (states) {
                              return states.contains(MaterialState.pressed)
                                  ? YouScribeColors.accentColor
                                  : null;
                            },
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        AppLocalizations.of(context)!.startFreeTrial,
                      )))
            ],
          ),
        ),
      ),
    );
  }

  Widget _tokenControlView({String description = "", String value = ""}) {
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(stops: const [
              0.3,
              1
            ], colors: [
              YouScribeColors.primaryAppColor.withOpacity(1),
              YouScribeColors.accentColor,
            ])),
        child: SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(description,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: WidgetStyles.subBodySize,
                        color: YouScribeColors.whiteColor,
                        overflow: TextOverflow.clip)),
                const SizedBox(height: 5),
                Text(value,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: WidgetStyles.title2Size,
                        color: YouScribeColors.whiteColor,
                        overflow: TextOverflow.clip)),
                const SizedBox(height: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
