import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/extensions/build_context_extension.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe/presentation/blocs/publisher/publisher_bloc.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/screens/products/widgets/product_info_view.dart';
import 'package:youscribe/presentation/screens/products/widgets/simple_product_view.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class PublisherScreen extends StatefulWidget {
  const PublisherScreen({
    required this.publisherId,
    required this.publisherName,
    super.key,
  });
  final int publisherId;
  final String publisherName;
  @override
  State<PublisherScreen> createState() => _PublisherScreenState();
}

class _PublisherScreenState extends State<PublisherScreen> {
  late final ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();

    _scrollViewController = ScrollController(initialScrollOffset: 5)
      ..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollViewController.offset >=
            _scrollViewController.position.maxScrollExtent &&
        !_scrollViewController.position.outOfRange) {
      context.read<PublisherBloc>().add(const LoadNewPageEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        BlocBuilder<PublisherBloc, PublisherState>(builder: (context, state) {
      final bloc = context.read<PublisherBloc>();

      if (state is PublisherErrorState) {
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

      if (state is PublisherInitialState) {
        return _loadInitView();
      }
      final loadedState = state as PublisherStateLoadedState;
      if (loadedState.isBusy) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(
              duration: const Duration(seconds: 1),
              backgroundColor: YouScribeColors.accentColor,
              content: Text(
                AppLocalizations.of(context)!.done,
                maxLines: 3,
              )));
        });
      }
      return Stack(children: [
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
                const SizedBox(height: 40),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollViewController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          child: loadedState.image.isNotEmpty
                              ? ClipRRect(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    loadedState.image,
                                    height: 70,
                                    width: 70,
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.publisherName,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: YouScribeColors.whiteColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          child: loadedState.biography.isNotEmpty
                              ? Text(
                                  loadedState.biography,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: YouScribeColors.whiteColor,
                                          fontWeight: FontWeight.w400,
                                          overflow: TextOverflow.clip),
                                )
                              : null,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          AppLocalizations.of(context)!.publications,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: YouScribeColors.whiteColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
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
                                  height: 250,
                                  width:
                                      (MediaQuery.of(context).size.width / 2) -
                                          19,
                                  child: ProductInfoView(
                                    title: product.title!,
                                    author: product.author!,
                                    titleTextAlign: TextAlign.center,
                                    titleFontWeight: FontWeight.w700,
                                    titleSize: 14,
                                    titleColor: YouScribeColors.whiteColor,
                                    productWidget: SimpleProductView(
                                      productId: product.id!,
                                      productImageUrl: product.imageUrl!,
                                      height: 200,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      floatingWidgetSize: 30,
                                      imgBorderRadius: BorderRadius.circular(5),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
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
                            AppLocalizations.of(context)!.done,
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
                            context
                                .read<PublisherBloc>()
                                .add(const FollowEvent());
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
                            !loadedState.isFollowing
                                ? AppLocalizations.of(context)!.follow
                                : AppLocalizations.of(context)!.unfollow,
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
          child: loadedState.isBusy
              ? const Center(
                  child: CircularProgressIndicator(
                    color: YouScribeColors.whiteColor,
                  ),
                )
              : null,
        ),
      ]);
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
