// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/repositories/products_repository.dart';
import 'package:youscribe/core/use_cases/downloads/download_product_usecase.dart';
import 'package:youscribe/core/use_cases/products/check_product_access_rights_use_case.dart';
import 'package:youscribe/infrastructure/readers/reader_helper.dart';
import 'package:youscribe/presentation/blocs/my_lists/my_favorites/my_favorites_bloc.dart';
import 'package:youscribe/presentation/blocs/my_lists/my_offlines/my_offlines_bloc.dart';
import 'package:youscribe/presentation/blocs/my_lists/product_list_items/product_list_item_cubit.dart';
import 'package:youscribe/presentation/blocs/premium_suggestion/premium_suggestion_bloc.dart'
    as premium;
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/screens/products/product_offline_button.dart';
import 'package:youscribe/presentation/screens/products/widgets/product_view.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/utilities/floating_player_control.dart';
import 'package:youscribe/utilities/view_utilities.dart';

class ProductListItemView extends StatefulWidget {
  const ProductListItemView({
    required this.cubit,
    this.isInFavoriteList = false,
    this.isInOfflineList = false,
    super.key,
  });

  final ProductListItemCubit cubit;
  final bool isInOfflineList;
  final bool isInFavoriteList;

  @override
  State<ProductListItemView> createState() => _ProductListItemViewState();
}

class _ProductListItemViewState extends State<ProductListItemView> {
  StreamSubscription<DownloadProgressWithStatus>? _downloadProgressSubscription;
  bool shouldReadAfterDownload = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListItemCubit, ProductListItemState>(
        bloc: widget.cubit,
        builder: (context, state) {
          final currentCubit = context.read<ProductListItemCubit>();

          return Container(
            padding: const EdgeInsets.all(5),
            height: 200,
            child: Dismissible(
              dismissThresholds: const <DismissDirection, double>{
                DismissDirection.startToEnd: 0.2,
                DismissDirection.endToStart: 0.2,
              },
              key: Key('${currentCubit.product.id}'),
              background: _slideStartToEndBackground(
                  currentCubit.product.isFavorite ?? false, context),
              secondaryBackground: _slideEndToStartBackground(
                  currentCubit.product.isOffline ?? false, context),
              // NOTE: We use swipe half way
              confirmDismiss: (direction) async {
                await _onSwipe(context, direction, currentCubit);
                return false;
              },
              child: Card(
                child: Material(
                  child: InkWell(
                    onTap: () => onProductSelected(currentCubit),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ProductView(
                              productId: currentCubit.product.id!,
                              productImageUrl:
                                  currentCubit.product.imageUrl ?? '',
                              width: 100,
                              height: 150,
                              productType: currentCubit.product.productType,
                              onProductSelected: (productId) async =>
                                  onReadProduct(context, currentCubit),
                              downloadProgressStream:
                                  currentCubit.downloadProgressStream,
                            ),
                            if (currentCubit.product.progress != null &&
                                currentCubit.product.progress! > 0)
                              Container(
                                margin: const EdgeInsets.only(top: 5),
                                height: 5,
                                width: 100,
                                child: LinearProgressIndicator(
                                  color: YouScribeColors.accentColor,
                                  value: currentCubit.product.progress,
                                  minHeight: 1,
                                  backgroundColor: Colors.grey,
                                ),
                              )
                          ],
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentCubit.product.title ?? '',
                                  style: WidgetStyles.title3TextStyle,
                                ),

                                _createIndicatorView(
                                    currentCubit.product, currentCubit),

                                //Display the book's author if it exists
                                if ((currentCubit.product.author ?? '')
                                    .isNotEmpty)
                                  Text(
                                    currentCubit.product.author ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                            fontSize: WidgetStyles.bodySize),
                                  ),

                                //Display the audio book's duration
                                // if it is given
                                if (currentCubit
                                        .product.humanizedDuration.isNotEmpty &&
                                    currentCubit.product.humanizedDuration !=
                                        "0 seconds")
                                  Text(
                                    currentCubit.product.humanizedDuration,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                            fontSize: WidgetStyles.bodySize),
                                  ),

                                Expanded(
                                  child: Text(
                                    currentCubit.product.description ?? '',
                                    maxLines: 3,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                            fontSize: WidgetStyles.bodySize),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _downloadProgressSubscription =
        widget.cubit.downloadProgressStream.listen(_downloadProgressChanged);
  }

  @override
  void dispose() {
    _downloadProgressSubscription?.cancel();
    widget.cubit.close();
    super.dispose();
  }

  void _downloadProgressChanged(DownloadProgressWithStatus progressData) {
    if (progressData.state == DownloadProgressState.completed) {
      if (shouldReadAfterDownload) {
        shouldReadAfterDownload = false;
        onReadProduct(context, widget.cubit, progressData);
      }
    } else if (progressData.state == DownloadProgressState.failed) {
    } else if (progressData.state == DownloadProgressState.cancelled) {}
  }

  Widget _createIndicatorView(
    ProductEntity product,
    ProductListItemCubit currentCubit,
  ) {
    final List<Widget> children = [];

    if (product.isFavorite ?? false) {
      children.add(Container(
        margin: const EdgeInsets.only(left: 5, right: 5),
        child: const FontAwesomeTextIcon(
            font: FontIcons.fontAwesomeStar,
            fontSize: 25,
            color: YouScribeColors.primaryAppColor),
      ));
    }

    if ((product.isOffline ?? false) || (product.isFileAvailable ?? false)) {
      children.add(
        ProductOfflineButton<ProductListItemCubit, ProductListItemState>(
          product: product,
          loading: false,
          showSync: true,
          minimalist: true,
          colors: (
            YouScribeColors.primaryAppColor,
            YouScribeColors.primaryAppColor.withOpacity(0.5),
          ),
          rebuildWhen: (state) => state is ProductListItemAttributeChanged,
        ),
      );
    }

    return Row(
      children: children,
    );
  }

  Widget _slideStartToEndBackground(bool isFavorite, BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 10),
        alignment: Alignment.centerLeft,
        color: isFavorite
            ? YouScribeColors.errorColor
            : Theme.of(context).primaryColor,
        child: FontAwesomeTextIcon(
          font: FontIcons.fontAwesomeStar,
          fontSize: 50,
          color: isFavorite
              ? YouScribeColors.whiteColor
              : YouScribeColors.primaryAppColor,
        ));
  }

  Widget _slideEndToStartBackground(bool isOffline, BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(right: 10),
        alignment: Alignment.centerRight,
        color: isOffline
            ? YouScribeColors.errorColor
            : Theme.of(context).primaryColor,
        child: FontAwesomeTextIcon(
          font: FontIcons.fontAwesomeCloudDownload,
          fontSize: 50,
          color: isOffline
              ? YouScribeColors.whiteColor
              : YouScribeColors.primaryAppColor,
        ));
  }

  Future<void> onProductSelected(ProductListItemCubit currentCubit) async {
    await context.pushNamed(Routes.productDetails, queryParameters: {
      Routes.productIdParamName: currentCubit.product.id.toString(),
    });
    return currentCubit.onProductSelected();
  }

  Future<void> onReadProduct(
      BuildContext context, ProductListItemCubit currentCubit,
      [DownloadProgressWithStatus? progressData]) async {
    final canReadResult = await currentCubit.canReadProduct(true);
    if (canReadResult == null) {
      return;
    }

    if (canReadResult == ProductAccessState.canRead) {
      if (context.mounted) {
        if (currentCubit.product.productType == ProductType.audioBook ||
            currentCubit.product.productType == ProductType.podcast) {
          await Provider.of<FloatingPlayerControl>(context, listen: false)
              .player
              .stop();
          await context.pushNamed(Routes.audioPlayer, queryParameters: {
            Routes.productIdParamName: currentCubit.product.id.toString(),
            Routes.productAccessTypeParamName: canReadResult.toString()
          });
        } else if (progressData != null) {
          await ReaderHelper.showDocument(
            context,
            currentCubit.product,
            progressData.downloadProgress.productExtension,
            progressData.downloadProgress.path,
            progressData.downloadProgress.password,
          );
        } else {
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   Dialogs.displayExtractionWaittingAlert(context: context);
          // });
          final result = await currentCubit.getProductReadData();
          await ReaderHelper.showDocument(
            context,
            currentCubit.product,
            currentCubit.product.getProductExtension(),
            result.$2,
            result.$1,
          );
        }
      }
    } else if (canReadResult == ProductAccessState.canStream) {
      //Stream the book
      if (context.mounted) {
        final currentProduct =
            Provider.of<FloatingPlayerControl>(context, listen: false)
                .currentProduct;

        if (currentProduct.id == currentCubit.product.id) {
          // Already playing the same product
          await context.pushNamed(Routes.audioPlayer, extra: {
            'player': Provider.of<FloatingPlayerControl>(context, listen: false)
                .player,
            'product': currentCubit.product,
          }, queryParameters: {
            Routes.productIdParamName: currentCubit.product.id.toString(),
            Routes.productAccessTypeParamName: canReadResult.toString()
          });
        } else {
          await Provider.of<FloatingPlayerControl>(context, listen: false)
              .player
              .stop();
          await context.pushNamed(Routes.audioPlayer, queryParameters: {
            Routes.productIdParamName: currentCubit.product.id.toString(),
            Routes.productAccessTypeParamName: canReadResult.toString()
          });
        }
      }
    } else if (canReadResult == ProductAccessState.fileNotAvailable) {
      setState(() {
        shouldReadAfterDownload = true;
      });

      final res = await currentCubit.downloadProduct();
      if (!res) {
        //TODO: Display error message or send an event to the UI
        setState(() {
          shouldReadAfterDownload = false;
        });
      }
    } else if (canReadResult == ProductAccessState.reached30DaysLimit) {
      await Dialogs.displayCustomAlert(
          context: context,
          isOneButton: true,
          content:
              AppLocalizations.of(context)!.internet30DaysLimitReachedMessage);
    }

    await context.handleReadRights(
        canReadResult, currentCubit.product.publishDate?.toString() ?? '');
  }

  Future<void> onAddToOffline(
    BuildContext context,
    ProductListItemCubit currentCubit,
  ) async {
    // Check if the product is audio and can be streamed
    final product = currentCubit.product;
    // Check if the product is offline
    final productIsOffline = product.isOffline ?? false;

    // Check if the product need to be downloaded
    final productNeedSync = !(product.isFileAvailable ?? false);

    // Check if the product is downloaded
    final productDownloaded = productIsOffline && !productNeedSync;

    // Check if the product cannot be downloaded
    final isAudio = product.productType == ProductType.audioBook ||
        product.productType == ProductType.podcast ||
        product.productType == ProductType.partition;

    if (isAudio && !productDownloaded) {
      final audioInfo = await locator<ProductRepository>()
          .getAudioBookInfoFromStreamingAPI(product.id ?? -1);

      final isPremium = product.isPremium ?? false;
      final isExtract = audioInfo.isExtract ?? false;

      if (isPremium && isExtract) {
        final result = await Dialogs.displayPremiumSuggestion(
          context: context,
          productId: product.id,
        );

        if (result != premium.PremiumSuggestionsResult.hasUsedToken) {
          return;
        }
      }
    }

    final canReadResult = await currentCubit.canReadProduct(false);
    if (canReadResult == null) {
      return;
    }
    await currentCubit.onAddToOffline();

    if (canReadResult == ProductAccessState.canDownload) {
      shouldReadAfterDownload = false;
      final res = await currentCubit.downloadProduct();
      if (!res) {
        //TODO: Display error message or send an event to the UI
      }
    } else if (canReadResult == ProductAccessState.fileAvailable) {
      //File available, do nothing.
    } else if (canReadResult == ProductAccessState.internetNeeded) {
      if (context.mounted) {
        await Dialogs.displayInternetNeededAlert(context: context);
        return;
      }
    }

    await context.handleReadRights(
        canReadResult, currentCubit.product.publishDate?.toString() ?? '');
  }

  Future<void> _onSwipe(BuildContext context, DismissDirection direction,
      ProductListItemCubit cubit) async {
    if (direction == DismissDirection.startToEnd) {
      return _onSwipeToFavorite(context, cubit);
    } else if (direction == DismissDirection.endToStart) {
      return _onSwipeToOffline(context, cubit);
    }
  }

  Future<void> _onSwipeToFavorite(
      BuildContext context, ProductListItemCubit cubit) async {
    if (cubit.product.isFavorite!) {
      if (widget.isInFavoriteList) {
        context
            .read<MyFavoritesBloc>()
            .add(RemoveFavoriteBookFromFavoritesEvent(cubit.product.id!));
      }
      return cubit.onRemoveFromFavorites();
    } else {
      return cubit.onAddToFavorites();
    }
  }

  Future<void> _onSwipeToOffline(
      BuildContext context, ProductListItemCubit cubit) async {
    if (cubit.product.isOffline!) {
      if (widget.isInOfflineList) {
        context
            .read<MyOfflinesBloc>()
            .add(RemoveOfflineBookFromOfflinesEvent(cubit.product.id!));
      }
      return cubit.onRemoveFromOffline();
    } else {
      return onAddToOffline(context, cubit);
    }
  }
}
