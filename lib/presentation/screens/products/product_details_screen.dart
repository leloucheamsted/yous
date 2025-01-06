// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:io';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/entities/simple_library_entity.dart';
import 'package:youscribe/core/extensions/build_context_extension.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/models/responses/ys_product_get_model.dart';
import 'package:youscribe/core/use_cases/downloads/download_product_usecase.dart';
import "package:youscribe/core/use_cases/products/check_product_access_rights_use_case.dart";
import 'package:youscribe/infrastructure/readers/reader_helper.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe/presentation/blocs/premium_suggestion/premium_suggestion_bloc.dart'
    as premium;
import 'package:youscribe/presentation/blocs/products/details/product_bloc.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/screens/my_lists/selections/widgets/dialog_view.dart';
import 'package:youscribe/presentation/screens/products/product_offline_button.dart';
import 'package:youscribe/presentation/screens/products/widgets/product_details_collection_widget.dart';
import 'package:youscribe/presentation/screens/products/widgets/product_details_description_widget.dart';
import 'package:youscribe/presentation/screens/products/widgets/product_details_skeleton.dart';
import 'package:youscribe/presentation/screens/products/widgets/product_details_suggestions_widget.dart';
import 'package:youscribe/presentation/screens/products/widgets/product_view.dart';
import 'package:youscribe/presentation/screens/shared/back_button.dart';
import 'package:youscribe/presentation/widgets/custom_path_icon.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/presentation/widgets/player.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/path_icons.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe/utilities/floating_player_control.dart';
import 'package:youscribe/utilities/view_utilities.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({required this.productId, super.key});
  final int productId;
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollViewController = ScrollController();
  final double _headerSize = 0;
  double _headerHeight = 265;
  double _floatingButonOpacity = 0;
  bool _isGARUserConnected = false;
  late AnimationController controller;
  late Animation<double> animationRadiusIn;
  late Animation<double> animationRadiusOut;
  double initialRadius = 30;
  bool showExtractLoad = false;
  bool shouldReadAfterDownload = false;
  double radius = 0;
  StreamSubscription<DownloadProgressWithStatus>? _downloadProgressSubscription;
  final connectivity = locator<ConnectivityService>();
  late AnimationController animateController;
  late Animation<double> animation;
  final RxSharedPreferences rxPrefs = locator();
  @override
  void initState() {
    _scrollViewController.addListener(_scrollListener);

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animationRadiusIn = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.75, 1, curve: Curves.elasticIn)));
    animationRadiusOut = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0, 0.25, curve: Curves.elasticOut)));
    controller
      ..addListener(() {
        setState(() {
          if (controller.value >= 0.75 && controller.value <= 1.0) {
            radius = animationRadiusIn.value * initialRadius;
          } else if (controller.value >= 0.0 && controller.value <= 0.25) {
            radius = animationRadiusOut.value * initialRadius;
          }
        });
      })
      ..repeat();

    repeatOnce();
    rxPrefs
        .getStringListStream(PreferenceKey.isDownloaded)
        .map((event) => event ?? [])
        .listen((event) {
      if (event.last.contains(widget.productId.toString())) {
        setState(() {
          showExtractLoad = true;
        });
      }
    });
    rxPrefs
        .getStringListStream(PreferenceKey.isDownloaded)
        .map((event) => event ?? [])
        .listen((event) {
      if (event.isEmpty) {
        setState(() {
          showExtractLoad = false;
        });
      }
      if (!event.last.contains(widget.productId.toString())) {
        setState(() {
          showExtractLoad = false;
        });
      }
    });
    super.initState();
  }

  Future<void> repeatOnce() async {
    // ignore: inference_failure_on_instance_creation
    final SharedPreferences pref = await prefs;
    final bool isGARUserConnected =
        pref.getBool(PreferenceKey.isGarUserConnected) ?? false;
    setState(() {
      _isGARUserConnected = isGARUserConnected;
    });
    if (isGARUserConnected) {
      controller.stop();
      return;
    }
    await Future.delayed(const Duration(seconds: 3));
    controller.stop();
  }

  void _scrollListener() {
    if (_scrollViewController.offset < 0) {
      if (_scrollViewController.offset != double.infinity) {
        setState(() {
          _floatingButonOpacity = 0;
          _headerHeight = 265 - (_scrollViewController.offset);
        });
      }
    } else if (_scrollViewController.offset >= 0) {
      setState(() {
        _headerHeight = 265 - (_scrollViewController.offset);
        _floatingButonOpacity = _scrollViewController.offset < 150
            ? _scrollViewController.offset / 150
            : 1;
      });
    }
    _downloadProgressSubscription = context
        .read<ProductDetailsBloc>()
        .downloadProgressStream
        .listen(_downloadProgressChanged);
  }

  @override
  void dispose() {
    _scrollViewController
      ..removeListener(_scrollListener)
      ..dispose();
    controller.dispose();
    _downloadProgressSubscription?.cancel();

    super.dispose();
  }

  void _downloadProgressChanged(DownloadProgressWithStatus progressData) {
    if (progressData.state == DownloadProgressState.completed) {
      if (shouldReadAfterDownload) {
        setState(() {
          shouldReadAfterDownload = false;
        });
        onReadProduct(
            context, context.read<ProductDetailsBloc>(), false, progressData);
      }
    } else if (progressData.state == DownloadProgressState.failed) {
    } else if (progressData.state == DownloadProgressState.cancelled) {}
  }

  Future<void> onReadProduct(
      BuildContext context, ProductDetailsBloc bloc, bool isSavedOffline,
      [DownloadProgressWithStatus? progressData]) async {
    final canReadResult = await bloc.canReadProduct(true);

    if (canReadResult == null) {
      return;
    }

    if (canReadResult == ProductAccessState.canRead) {
      if (context.mounted) {
        setState(() {
          showExtractLoad = false;
        });
        if (bloc.product.productType == ProductType.audioBook ||
            bloc.product.productType == ProductType.podcast) {
          await Provider.of<FloatingPlayerControl>(context, listen: false)
              .player
              .stop();
          await context.pushNamed(Routes.audioPlayer, queryParameters: {
            Routes.productIdParamName: bloc.product.id.toString(),
            Routes.productAccessTypeParamName: canReadResult.toString()
          });
        } else if (progressData != null) {
          await ReaderHelper.showDocument(
            context,
            bloc.product,
            progressData.downloadProgress.productExtension,
            progressData.downloadProgress.path,
            progressData.downloadProgress.password,
          );
        } else {
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   Dialogs.displayExtractionWaittingAlert(context: context);
          // });
          final result = await bloc.getProductReadData();
          await ReaderHelper.showDocument(
            context,
            bloc.product,
            bloc.product.getProductExtension(),
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

        if (currentProduct.id == bloc.product.id) {
          // Already playing the same product
          await context.pushNamed(Routes.audioPlayer, extra: {
            'player': Provider.of<FloatingPlayerControl>(context, listen: false)
                .player,
            'product': bloc.product,
          }, queryParameters: {
            Routes.productIdParamName: bloc.product.id.toString(),
            Routes.productAccessTypeParamName: canReadResult.toString()
          });
        } else {
          await Provider.of<FloatingPlayerControl>(context, listen: false)
              .player
              .stop();
          await context.pushNamed(Routes.audioPlayer, queryParameters: {
            Routes.productIdParamName: bloc.product.id.toString(),
            Routes.productAccessTypeParamName: canReadResult.toString()
          });
        }
      }
    } else if (canReadResult == ProductAccessState.fileNotAvailable) {
      setState(() {
        shouldReadAfterDownload = true;
      });

      final res = await bloc.downloadProduct(isSavedOffline);
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
        canReadResult, bloc.product.publishDate?.toString() ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Scaffold(
            body: BlocBuilder<ProductDetailsBloc, ProductState>(
              builder: (context, state) {
                final bloc = context.read<ProductDetailsBloc>();

                if (state is ProductErrorState) {
                  //TODO: Handle error better.
                  if (state.errorType == ErrorType.serverError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Dialogs.displayGeneralAPIErrorAlert(context: context);
                    });
                  } else if (state.errorType == ErrorType.noInternet) {
                    if (state.showErrorMessage) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Dialogs.displayInternetNeededAlert(context: context);
                      });
                    }
                  } else {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.showErrorSnackBar(AppLocalizations.of(context)!
                          .errorOccuredGeneralTitle);
                    });
                  }

                  bloc.add(const ErrorDisplayedEvent());
                  state = state.previousState;
                }
                if (state is ProductAddedSelectionState) {
                  final selections = state.selections;

                  if (selections.isNotNull && selections.isNotEmpty) {
                    selections.sort((a, b) {
                      return a.label!
                          .toLowerCase()
                          .compareTo(b.label!.toLowerCase());
                    });
                    if (state.selections.length == 1) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Dialogs.displayOnlyOneSelectionAlert(
                            context: context,
                            onAdded: () => bloc.add(AddToSelectionEvent(
                                isSelectionExist: true,
                                name: selections.first.name!,
                                productId: widget.productId,
                                libraryId: selections.first.id)),
                            onCreate: () {
                              MySelectionDialogView.addSelection(
                                  context: context,
                                  selection: SimpleLibraryEntity(),
                                  onCreate: (name, isPublic) => bloc.add(
                                      AddToSelectionEvent(
                                          isSelectionExist: false,
                                          name: name,
                                          isPublic: isPublic,
                                          productId: widget.productId)));
                            });
                      });
                    } else {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Dialogs.displayChooseSelectionAlert(
                            context: context,
                            selections: selections,
                            onAdd: (selection) {
                              bloc.add(AddToSelectionEvent(
                                  isSelectionExist: true,
                                  name: selection.name!,
                                  productId: widget.productId,
                                  libraryId: selection.id));
                            });
                      });
                    }
                  } else {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Dialogs.displayEmptySelectionAlert(
                          context: context,
                          onAdd: () {
                            MySelectionDialogView.addSelection(
                                context: context,
                                selection: SimpleLibraryEntity(),
                                onCreate: (name, isPublic) => bloc.add(
                                    AddToSelectionEvent(
                                        isSelectionExist: false,
                                        name: name,
                                        isPublic: isPublic,
                                        productId: widget.productId)));
                          });
                    });
                  }
                  bloc.add(const SelectionDisplayedEvent());
                  state = state.previousState;
                }
                if (state is ProductInitialState) {
                  return const Center(
                    child: ProductDetailsSkeleton(),
                  );
                }

                if (state is ProductSuccessSelectionAddState) {
                  final name = state.name;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(
                        backgroundColor: YouScribeColors.accentColor,
                        content: Row(
                          children: [
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .addedToSelection(name),
                                maxLines: 3,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              },
                              child: Text(AppLocalizations.of(context)!.ok),
                            )
                          ],
                        )));
                  });

                  bloc.add(const AddToSelectionDisplayedEvent());
                  state = state.previousState;
                }

                if (state is RequestSyncState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Dialogs.displayRequestSyncAlert(
                        context: context,
                        sync: () {
                          bloc.add(const SyncEvent());
                        });
                  });

                  bloc.add(const RequestSyncDisplayedEvent());
                  state = state.previousState;
                }

                if (state is ProductInitialState) {
                  return const Center(
                    child: ProductDetailsSkeleton(),
                  );
                }
                final loadedState = state as ProductLoadedState;

                bloc.downloadProgressStream.listen((event) {
                  if (event.downloadProgress.progress == 100) {
                    if (shouldReadAfterDownload) {
                      setState(() {
                        shouldReadAfterDownload = false;
                      });
                      onReadProduct(context, bloc, false);
                    }
                  }
                });

                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: _headerSize,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        height: _headerHeight > 0 ? _headerHeight : 0,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        loadedState.product.imageUrl ?? '')),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: const Alignment(0, 0.2),
                                      end: Alignment.topCenter,
                                      colors: [
                                    YouScribeColors.primaryAppColor,
                                    YouScribeColors.primaryAppColor
                                        .withOpacity(0.65),
                                  ])),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: RefreshIndicator.adaptive(
                          color: YouScribeColors.whiteColor,
                          onRefresh: () async {
                            context
                                .read<ProductDetailsBloc>()
                                .add(RefreshProductEvent(widget.productId));
                          },
                          child: SingleChildScrollView(
                            controller: _scrollViewController,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight:
                                    MediaQuery.of(context).size.height - 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: Platform.isIOS ? 70 : 80),
                                  SizedBox(
                                    height: 235,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(60)),
                                              child: Container(
                                                height: 90,
                                                color: Colors.white,
                                                child: Container(
                                                  height: 200,
                                                  width: 100,
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                ),
                                              )),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 18),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ProductView(
                                                isPremium: loadedState
                                                    .product.isPremium!,
                                                productId: widget.productId,
                                                productImageUrl:
                                                    state.product.imageUrl!,
                                                height: 200,
                                                width: 150,
                                                floatingWidgetSize: 30,
                                                imgBorderRadius:
                                                    BorderRadius.circular(0),
                                                productType:
                                                    state.product.productType,
                                                onProductSelected: (val) async {
                                                  await onReadProduct(
                                                      context, bloc, false);
                                                },
                                                downloadProgressStream:
                                                    bloc.downloadProgressStream,
                                              ),
                                              const SizedBox(width: 30),
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const SizedBox(height: 30),
                                                  Text(
                                                    loadedState.product.title!,
                                                    maxLines: 2,
                                                    style: WidgetStyles
                                                        .textStyle
                                                        .copyWith(
                                                            color:
                                                                YouScribeColors
                                                                    .whiteColor,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontSize:
                                                                WidgetStyles
                                                                    .bodySize,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                  ),
                                                  const SizedBox(height: 2),
                                                  InkWell(
                                                    onTap: () async {
                                                      await _onAuthorSelected();
                                                    },
                                                    child: Text(
                                                      loadedState
                                                              .product.author ??
                                                          "",
                                                      maxLines: 1,
                                                      style: WidgetStyles
                                                          .textStyle
                                                          .copyWith(
                                                              color:
                                                                  YouScribeColors
                                                                      .whiteColor,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ),
                                                  //row control
                                                  //// const SizedBox(height: 10),
                                                  const SizedBox(height: 4),

                                                  _buildProductCallToActions(
                                                    context,
                                                    state: state,
                                                    isBusy: loadedState.isBusy,
                                                    isFavorite: state.product
                                                            .isFavorite ??
                                                        false,
                                                    productName: loadedState
                                                        .product.title!,
                                                    isOffline: state.product
                                                            .isOffline ??
                                                        false,
                                                    isFollowingAuthor:
                                                        state.isFollowingAuthor,
                                                    isFollowingEditor:
                                                        state.isFollowingEditor,
                                                    isFollowingTheme:
                                                        state.isFollowingTheme,
                                                    isFollowing:
                                                        state.isFollowing,
                                                    canFollowTheme:
                                                        state.canFollowTheme,
                                                  ),

                                                  // read button
                                                  const Spacer(),
                                                  SizedBox(
                                                    child: loadedState.product
                                                            .isPublished!
                                                        ? _readButton(
                                                            isBusy:
                                                                state.isBusy)
                                                        : null,
                                                  ),
                                                  const SizedBox(height: 20),
                                                ],
                                              ))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  ProductDetailsDescriptionWidget(
                                    showHeader: (val) {
                                      if (val) {
                                        setState(() {
                                          _headerHeight = 265;
                                          _floatingButonOpacity = 0;
                                        });
                                      }
                                    },
                                    authorId: loadedState.product.authorId!,
                                    ownerId: loadedState.product.ownerId!,
                                    ownerDisplayableUserName: loadedState
                                        .product.ownerDisplayableUserName!,
                                    plainDescription:
                                        loadedState.product.description,
                                    comments:
                                        loadedState.product.comment?.comments,
                                    opinion: loadedState.product.comment
                                                ?.opinionSource ==
                                            OpinionSource.ysTeam
                                        ? AppLocalizations.of(context)!
                                            .wordFromYSTeam
                                        : loadedState.product.comment
                                                    ?.opinionSource ==
                                                OpinionSource.author
                                            ? AppLocalizations.of(context)!
                                                .wordFromAuthor
                                            : AppLocalizations.of(context)!
                                                .wordFromYSAmbassador,
                                    subjects: loadedState.product.subjects
                                        .toSet()
                                        .toList(),
                                    duration:
                                        loadedState.product.humanizedDuration,
                                    title: loadedState.product.title!,
                                    totalPages:
                                        loadedState.product.numberOfPages,
                                    language:
                                        loadedState.product.languagesIsoCode[0],
                                    size: loadedState.product.sizeInMb,
                                    author: loadedState.product.author ?? "",
                                    isPremium: state.product.isPremium ?? false,
                                    isAudio: state.isAudio,
                                  ),
                                  SizedBox(
                                      height: loadedState
                                              .product.subjects.isNotEmpty
                                          ? 20
                                          : 0),
                                  SizedBox(
                                    child: loadedState.suggestions.isNotEmpty
                                        ? ProductDetailsSuggestionsWidget(
                                            suggestions:
                                                loadedState.suggestions)
                                        : null,
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    child: loadedState.canShowCollections
                                        ? ProductDetailsCollectionWidget(
                                            seeMoreAction: () => {
                                                  _seeMoreCollection(
                                                      loadedState.product
                                                          .collectionId!,
                                                      loadedState.product
                                                          .collectionTitle!)
                                                },
                                            onProductSelected:
                                                _onCollectionProductSelected,
                                            title: loadedState
                                                    .product.collectionTitle ??
                                                "",
                                            collections:
                                                loadedState.collections)
                                        : null,
                                  ),
                                  const SizedBox(height: 60),
                                ],
                              ),
                            ),
                          ),
                        )),
                    _buildFloatingBackButton(context),
                    _buildLegalInformation(context, loadedState),
                    if (showExtractLoad)
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: ColoredBox(
                          color: Colors.black.withOpacity(0.5),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                color: Colors.white,
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          YouScribeColors.primaryAppColor),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                          AppLocalizations.of(context)!
                                              .extractDocumentMsg,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  color: YouScribeColors
                                                      .blackColor,
                                                  fontSize: WidgetStyles
                                                      .subBodySize)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                );
              },
            ),
          ),
          const Player()
        ],
      ),
    );
  }

  Widget _buildProductCallToActions(
    BuildContext context, {
    required ProductLoadedState state,
    bool isFavorite = false,
    bool isOffline = false,
    bool isFollowing = false,
    String productName = "",
    bool isBusy = false,
    bool isFollowingEditor = false,
    bool isFollowingAuthor = false,
    bool isFollowingTheme = false,
    bool canFollowTheme = false,
  }) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.st,
      children: [
        ProductOfflineButton<ProductDetailsBloc, ProductState>(
          loading: state.isBusy,
          product: state.product,
          colors: (
            YouScribeColors.whiteColor,
            YouScribeColors.whiteColor.withOpacity(0.5),
          ),
          rebuildWhen: (state) => state is ProductLoadedState,
          onDownloadPressed: (offlineState) async {
            if (!offlineState.productDownloaded) {
              if (offlineState.productCannotBeDownloaded) {
                final result = await Dialogs.displayPremiumSuggestion(
                  context: context,
                  productId: widget.productId,
                );

                if (result != premium.PremiumSuggestionsResult.hasUsedToken) {
                  return;
                }
              }

              await Dialogs.displayDownloadBookWarningAlert(
                  title: AppLocalizations.of(context)!.downloadBookWarningTitle,
                  message:
                      AppLocalizations.of(context)!.downloadBookWarningMessage,
                  context: context,
                  confirm: () async {
                    context.read<ProductDetailsBloc>().add(
                          IsOfflineEvent(
                            isOffline: offlineState.productIsOffline,
                          ),
                        );
                    await _onAddToOffline(
                        context.read<ProductDetailsBloc>(), true);
                  });
            } else {
              await Dialogs.displayDownloadBookWarningAlert(
                  title: AppLocalizations.of(context)!.removeOfflineTitle,
                  message: AppLocalizations.of(context)!.removeOfflineMessage(
                    state.product.title!,
                  ),
                  context: context,
                  confirm: () async {
                    context.read<ProductDetailsBloc>().add(
                          IsOfflineEvent(
                            isOffline: offlineState.productIsOffline,
                          ),
                        );
                  });
            }
          },
        ),
        const SizedBox(width: 15),
        InkWell(
          onTap: !isBusy
              ? () {
                  if (!isFavorite) {
                    context
                        .read<ProductDetailsBloc>()
                        .add(FavoriteEvent(isFavorite: !isFavorite));
                  } else {
                    Dialogs.displayRemoveFavoriteAlert(
                        context: context,
                        productName: productName,
                        confirm: () {
                          context
                              .read<ProductDetailsBloc>()
                              .add(FavoriteEvent(isFavorite: !isFavorite));
                        });
                  }
                }
              : () {},
          child: SizedBox(
            child: isFavorite && !isBusy
                ? CustomPathIcon(
                    path: PathIcons.filledFontAwesomeStarIcon,
                    fontSize: 28,
                  )
                : FontAwesomeTextIcon(
                    font: FontIcons.fontAwesomeStar,
                    fontSize: 25,
                    color: !isBusy
                        ? YouScribeColors.whiteColor
                        : YouScribeColors.whiteColor.withOpacity(0.5)),
          ),
        ),
        const SizedBox(width: 15),
        InkWell(
          onTap: !isBusy
              ? () async {
                  if (!await connectivity.isInternetAvailable) {
                    if (context.mounted) {
                      await Dialogs.displayInternetNeededAlert(
                          context: context);
                    }
                    return;
                  }
                  context
                      .read<ProductDetailsBloc>()
                      .add(const RetreiveSelectionsEvent());
                }
              : () {},
          child: FontAwesomeTextIcon(
              font: FontIcons.fontAwesomeBookArrowUp,
              fontSize: 25,
              color: !isBusy
                  ? YouScribeColors.whiteColor
                  : YouScribeColors.whiteColor.withOpacity(0.5)),
        ),
        const SizedBox(width: 15),
        if (!_isGARUserConnected)
          Transform.translate(
              offset: Offset(!isFollowing ? radius : 0, 0),
              child: GestureDetector(
                onTap: isBusy
                    ? null
                    : () async {
                        Platform.isAndroid
                            ? Dialogs.displayFollowAlert(
                                context: context,
                                followPublisherEvent: () {
                                  _followEditor(context, isFollowingEditor);
                                },
                                followAuthorEvent: () {
                                  _followAuthor(context, isFollowingAuthor);
                                },
                                followThemeEvent: () {
                                  _followSubThme(context, isFollowingTheme);
                                },
                                title: AppLocalizations.of(context)!
                                    .followActionSheetTitle,
                                followAuthor: isFollowingAuthor
                                    ? AppLocalizations.of(context)!
                                        .unfollowAuthor
                                    : AppLocalizations.of(context)!
                                        .followAuthor,
                                followPublisher: isFollowingEditor
                                    ? AppLocalizations.of(context)!
                                        .unFollowEditor
                                    : AppLocalizations.of(context)!
                                        .followEditor,
                                followTheme: isFollowingTheme
                                    ? AppLocalizations.of(context)!
                                        .unFollowTheme
                                    : AppLocalizations.of(context)!.followTheme)
                            : await showCupertinoModalPopup<void>(
                                context: context,
                                builder: (subContext) => CupertinoActionSheet(
                                  title: Text(AppLocalizations.of(context)!
                                      .followActionSheetTitle),
                                  actions: <Widget>[
                                    CupertinoActionSheetAction(
                                      onPressed: () {
                                        _followEditor(
                                            context, isFollowingEditor);
                                      },
                                      child: Text(isFollowingEditor
                                          ? AppLocalizations.of(context)!
                                              .unFollowEditor
                                          : AppLocalizations.of(context)!
                                              .followEditor),
                                    ),
                                    CupertinoActionSheetAction(
                                      child: Text(isFollowingAuthor
                                          ? AppLocalizations.of(context)!
                                              .unfollowAuthor
                                          : AppLocalizations.of(context)!
                                              .followAuthor),
                                      onPressed: () {
                                        _followAuthor(
                                            context, isFollowingAuthor);
                                      },
                                    ),
                                    CupertinoActionSheetAction(
                                      child: Text(isFollowingTheme
                                          ? AppLocalizations.of(context)!
                                              .unFollowTheme
                                          : AppLocalizations.of(context)!
                                              .followTheme),
                                      onPressed: () {
                                        _followSubThme(
                                            context, isFollowingTheme);
                                      },
                                    ),
                                  ],
                                  cancelButton: CupertinoActionSheetAction(
                                    isDefaultAction: true,
                                    onPressed: () {
                                      Navigator.pop(subContext);
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)!.cancel),
                                  ),
                                ),
                              );
                      },
                child: SizedBox(
                  child: isFollowing && !isBusy
                      ? CustomPathIcon(
                          path: PathIcons.filledFontAwesomeBellIcon,
                          fontSize: 28,
                        )
                      : FontAwesomeTextIcon(
                          font: FontIcons.fontAwesomeBell,
                          fontSize: 25,
                          color: !isBusy
                              ? YouScribeColors.whiteColor
                              : YouScribeColors.whiteColor.withOpacity(0.5)),
                ),
              ))
      ],
    );
  }

  void _followEditor(BuildContext context, bool isFollowingEditor) {
    context.read<ProductDetailsBloc>().add(FollowEvent(
        followType: isFollowingEditor
            ? FollowType.unFollowEditor
            : FollowType.followEditor));
    Navigator.pop(context);
  }

  void _followAuthor(BuildContext context, bool isFollowingAuthor) {
    context.read<ProductDetailsBloc>().add(FollowEvent(
        followType: isFollowingAuthor
            ? FollowType.unFollowAuthor
            : FollowType.followAuthor));
    Navigator.pop(context);
  }

  void _followSubThme(BuildContext context, bool isFollowingTheme) {
    context.read<ProductDetailsBloc>().add(FollowEvent(
        followType: isFollowingTheme
            ? FollowType.unfollowTheme
            : FollowType.followTheme));
    Navigator.pop(context);
  }

  Widget _readButton({bool isBusy = false}) {
    return ElevatedButton(
        onPressed: !isBusy
            ? () async {
                await onReadProduct(context, context.read(), false);
              }
            : () {},
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )),
            backgroundColor: MaterialStateProperty.all<Color>(
              YouScribeColors.primaryAppColor,
            ),
            foregroundColor: MaterialStateProperty.all<Color>(
              YouScribeColors.whiteColor,
            )),
        child: Text(
          AppLocalizations.of(context)!.read,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: WidgetStyles.subBodySize,
              color: !isBusy
                  ? YouScribeColors.whiteColor
                  : YouScribeColors.secondaryTextColor),
        ));
  }

  Widget _buildFloatingBackButton(BuildContext context) {
    return Positioned(
        top: Platform.isIOS ? 40 : 30,
        left: 10,
        child: YsBackButton(floatingButonOpacity: _floatingButonOpacity));
  }

  Widget _buildLegalInformation(
      BuildContext context, ProductLoadedState loadedState) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ColoredBox(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SizedBox(
            child: loadedState.shouldSetPriceInfo
                ? Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: YouScribeColors.secondaryTextColor,
                        ),
                        ExpansionTileCard(
                          elevation: 0,
                          animateTrailing: true,
                          baseColor: Colors.transparent,
                          expandedColor: Colors.transparent,
                          expandedTextColor: Colors.transparent,
                          title: Text(
                            AppLocalizations.of(context)!.legalInfo,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: YouScribeColors.secondaryTextColor),
                          ),
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .priceInfo(loadedState.priceInfo),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              overflow: TextOverflow.clip),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ],
                    ),
                  )
                : null),
      ),
    );
  }

  Future<void> _onAddToOffline(ProductDetailsBloc bloc, bool isOffline) async {
    bloc.add(IsOfflineEvent(isOffline: !isOffline));
    final canReadResult = await bloc.canReadProduct(false);

    if (canReadResult == null) {
      return;
    }

    if (canReadResult == ProductAccessState.canDownload) {
      // shouldReadAfterDownload = false;

      final res = await bloc.downloadProduct(true);
      if (!res) {
        //TODO: Display error message or send an event to the UI
      }
    } else if (canReadResult == ProductAccessState.fileAvailable) {
      //File available, do nothing.
    } else if (canReadResult == ProductAccessState.canStream) {
      //Stream the book
    } else if (canReadResult == ProductAccessState.internetNeeded) {
      if (context.mounted) {
        await Dialogs.displayInternetNeededAlert(context: context);
        return;
      }
    }

    await context.handleReadRights(
        canReadResult, bloc.product.publishDate?.toString() ?? '');
  }

  Future<void> _onCollectionProductSelected(int productId) async {
    await context.pushNamed(Routes.productDetails, queryParameters: {
      Routes.productIdParamName: productId.toString(),
    });
  }

  Future<void> _seeMoreCollection(
      int collectionId, String collectionTitle) async {
    if (!await connectivity.isInternetAvailable) {
      if (context.mounted) {
        await Dialogs.displayInternetNeededAlert(context: context);
        return;
      }
    }
    if (context.mounted) {
      await context.pushNamed(Routes.collectionDetails, queryParameters: {
        Routes.collectionIdParamName: collectionId.toString(),
        Routes.collectionTitleParamName: collectionTitle
      });
    }
  }

  Future<void> _onAuthorSelected() async {}
}
