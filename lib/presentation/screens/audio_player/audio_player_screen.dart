// ignore_for_file: use_build_context_synchronously, unawaited_futures, avoid_dynamic_calls, lines_longer_than_80_chars
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/presentation/blocs/app_purchase/app_purchase_cubit.dart';
import 'package:youscribe/presentation/blocs/audio_player/audio_player_cubit.dart';
import 'package:youscribe/presentation/blocs/premium_suggestion/premium_suggestion_bloc.dart';
import 'package:youscribe/presentation/screens/audio_player/widgets/player_control_buttons.dart';
import 'package:youscribe/presentation/screens/audio_player/widgets/seek_bar.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/screens/shared/app_purchase_view.dart';
import 'package:youscribe/presentation/screens/shared/back_button.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe/utilities/floating_player_control.dart';
import 'package:youscribe/utilities/youscribe_premium.dart';
import 'package:youscribe/utilities/ys_timer.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({
    this.player,
    this.product,
    super.key,
  });
  final AudioPlayer? player;
  final ProductEntity? product;

  @override
  AudioPlayerScreenState createState() => AudioPlayerScreenState();
}

class AudioPlayerScreenState extends State<AudioPlayerScreen>
    with WidgetsBindingObserver {
  AudioPlayer _player = locator();

  late AudioPlayerLoadedState latestLoadedState;
  late String currentChapterTitle;
  // late ProductEntity product = ProductEntity();

  static const double bottomSheetBorder = 30;
  StreamSubscription<PlayerState>? _playerStateSubscription;
  final cubit = AppPurchaseCubit();
  bool titleSet = false;
  bool isCollectionProduct = false;
  List<ProductEntity> collection = [];
  @override
  void initState() {
    super.initState();
    _playerStateSubscription =
        _player.playerStateStream.listen(_playerSubscriptionHandler);
    titleSet = false;
  }

  // RESTART function
  Future<void> _restart(int? id) async {
    final prefs = await SharedPreferences.getInstance();
    final productId =
        id ?? (prefs.get(PreferenceKey.currentPlayerId) ?? 0) as int;
    prefs.setInt(PreferenceKey.currentSeekIndex, _player.currentIndex ?? 0);
    final productAccessState =
        prefs.get(PreferenceKey.productAccessState)! as String;
    context.pushReplacementNamed(Routes.audioPlayer, queryParameters: {
      Routes.productIdParamName: productId.toString(),
      Routes.productAccessTypeParamName: productAccessState
    });
    // jump to current index
    final buffer = prefs.getDouble(PreferenceKey.bufferedPosition) ?? 0;
    _player.seek(Duration(seconds: int.parse(buffer.toString())),
        index: prefs.getInt(PreferenceKey.currentSeekIndex));
  }

  Future<void> _playerSubscriptionHandler(PlayerState event) async {
    if (event.processingState == ProcessingState.completed) {
      if (Provider.of<FloatingPlayerControl>(context, listen: false)
          .isCollectionProduct) {
        if (Provider.of<FloatingPlayerControl>(context, listen: false)
            .currentCollectionProducts
            .isNotEmpty) {
          final nextProduct = getNextId(
              Provider.of<FloatingPlayerControl>(context, listen: false)
                  .currentCollectionProducts,
              Provider.of<FloatingPlayerControl>(context, listen: false)
                  .currentProduct
                  .id!);
          if (nextProduct != 0) {
            await _restart(nextProduct);
            return;
          }
          _player
            ..seek(Duration.zero, index: 0)
            ..pause();
          return;
        }
      }

      _player
        ..seek(Duration.zero, index: 0)
        ..pause();
    }
    // stop if is not premium

    if (Provider.of<FloatingPlayerControl>(context, listen: false)
            .hasExtraction &&
        !Provider.of<YouScribePremium>(context).isPremium) {
      if (_player.currentIndex ==
          Provider.of<FloatingPlayerControl>(context, listen: false)
              .extraChapterIndex) {
        await _player.stop();
        await _extractStopTimeReachedHandler(AudioExtractStopTimeReachedState(
            chapters: const [],
            product: widget.product!,
            collection: const [],
            isProductCollection: false,
            isPremium: Provider.of<YouScribePremium>(context, listen: false)
                .isPremium));
      }
    }
  }

  Future<void> _extractStopTimeReachedHandler(
      AudioExtractStopTimeReachedState event) async {
    if (!Provider.of<YouScribePremium>(context, listen: false).isPremium) {
      final result = await Dialogs.displayCustomAlert(
          content: AppLocalizations.of(context)!.extractGuardMessageForPopup,
          leftButtonText: AppLocalizations.of(context)!.cancel,
          rightButtonText: AppLocalizations.of(context)!.subscribe,
          context: context);
      if (result) {
        await cubit.callSubscriptionPopup(false).then((value) => {});
      } else {
        await _player.stop();
        Navigator.pop(context);
      }
    } else {
      //TODO: Trigger premium modal
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: YouScribeColors.primaryAppColor,
      ));
      final result = await Dialogs.displayPremiumSuggestion(
          context: context, productId: event.product.id);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ));
      switch (result) {
        case PremiumSuggestionsResult.shouldSubscribe:
          await cubit.callSubscriptionPopup(false).then((value) => {
                _restart(event.product.id),
              });
        case PremiumSuggestionsResult.shouldNavigateToHelp:
          await context.pushNamed(Routes.help, extra: true);
        case PremiumSuggestionsResult.noInternet:
          await Dialogs.displayInternetNeededAlert(context: context);
        case PremiumSuggestionsResult.errorServer:
          await Dialogs.displayGeneralAPIErrorAlert(context: context);
        case PremiumSuggestionsResult.errorUnknown:
          await Dialogs.displayGeneralAPIErrorAlert(context: context);
        case PremiumSuggestionsResult.noResult:
          await _player.stop();
          Navigator.pop(context);
        case PremiumSuggestionsResult.hasUsedToken:
          _restart(event.product.id);
          Navigator.pop(context);
        default:
          break;
      }
    }
  }

  @override
  void dispose() {
    locator.get<YsTimer>().stopMonitoringAudioPlayer();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));
    _playerStateSubscription?.cancel();

    super.dispose();
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _player.positionStream.asBroadcastStream(),
        _player.bufferedPositionStream.asBroadcastStream(),
        _player.durationStream.asBroadcastStream(),
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );
  static ButtonStyle audioButtonStyle = ButtonStyle(
    splashFactory: NoSplash.splashFactory,
    iconColor: MaterialStateProperty.all<Color>(
      YouScribeColors.primaryAppColor,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AppPurchasView(
      cubit: cubit,
      child: BlocConsumer<AudioPlayerCubit, AudioPlayerState>(
        listener: (context, state) {
          if (state is AudioExtractStopTimeReachedState) {
            _extractStopTimeReachedHandler(state);
          }
        },
        builder: (context, state) {
          ProductEntity? product;
          if (widget.product.isNotNull) {
            product = widget.product;
            _player = widget.player!;
          }
          final extraChapterIndex =
              Provider.of<FloatingPlayerControl>(context).extraChapterIndex;
          final hasExtraction =
              Provider.of<FloatingPlayerControl>(context).hasExtraction;
          final isPremium = Provider.of<YouScribePremium>(context).isPremium;
          isCollectionProduct =
              Provider.of<FloatingPlayerControl>(context).isCollectionProduct;
          collection = Provider.of<FloatingPlayerControl>(context)
              .currentCollectionProducts;
          if (state is AudioPlayerErrorState) {
            // Display error report screen, and navigate back.
          } else if (state is AudioPlayerLoadedState) {
            latestLoadedState = state;
            product = state.product;
            // send to provider
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                Provider.of<FloatingPlayerControl>(context, listen: false)
                    .changeProduct(
                        state.product,
                        state.hasExtractRestrictions,
                        state.extractChapterIndex,
                        state.isProductCollection,
                        state.chapterStopSeconds,
                        state.collection);
              }
            });

            _setChaptersTitle(state, context);

            return Stack(children: [
              if (product.imageUrl.isNotNullOrEmpty)
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(product.imageUrl ?? '')),
                  ),
                ),
              Container(
                decoration:
                    BoxDecoration(gradient: WidgetStyles.youscribeGradient),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 43, left: 10),
                    alignment: Alignment.topLeft,
                    child: const YsBackButton(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 17),
                    child: Center(
                      child: Column(children: [
                        Text(
                          product.author ?? '',
                          style: WidgetStyles.textStyle
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          product.title ?? '',
                          style: WidgetStyles.title3TextStyle.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          product.narrator ?? '',
                          style: WidgetStyles.title3TextStyle
                              .copyWith(color: Colors.white),
                        ),
                      ]),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(bottomSheetBorder),
                        topRight: Radius.circular(bottomSheetBorder)),
                    child: SizedBox(
                      height: 250,
                      child: ColoredBox(
                        color: YouScribeColors.whiteColor,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, top: 1, right: 15),
                              child: Row(children: [
                                IconButton(
                                  style: ControlButtons.audioButtonStyle,
                                  onPressed: () async {
                                    await _displayChapters(
                                        context,
                                        latestLoadedState,
                                        state.extractChapterIndex,
                                        state.hasExtractRestrictions,
                                        isPremium);
                                  },
                                  icon: const FontAwesomeTextIcon(
                                      font: FontIcons.fontAwesomeList,
                                      color: YouScribeColors.primaryAppColor),
                                ),
                                Expanded(
                                    child: Center(
                                        child: _currentChapterTitle(state))),
                                IconButton(
                                  style: ControlButtons.audioButtonStyle,
                                  onPressed: () async {
                                    await _displaySettings(
                                        context, latestLoadedState);
                                  },
                                  icon: const FontAwesomeTextIcon(
                                      font: FontIcons.fontAwesomeSliders,
                                      color: YouScribeColors.primaryAppColor),
                                ),
                              ]),
                            ),

                            SizedBox(
                              child: state.hasExtractRestrictions &&
                                      !Provider.of<YouScribePremium>(context)
                                          .isPremium
                                  ? Container(
                                      margin: const EdgeInsets.all(10),
                                      child: InkWell(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .extractGuardMessage,
                                          style: WidgetStyles.caption1TextStyle
                                              .copyWith(
                                                  color: YouScribeColors
                                                      .primaryAppColor),
                                          maxLines: 5,
                                          textAlign: TextAlign.center,
                                        ),
                                        onTap: () async {
                                          await _extractStopTimeReachedHandler(
                                              AudioExtractStopTimeReachedState(
                                                  chapters: state.chapters,
                                                  product: product!,
                                                  isPremium: isPremium,
                                                  collection: state.collection,
                                                  isProductCollection: state
                                                      .isProductCollection));
                                        },
                                      ),
                                    )
                                  : state.hasExtractRestrictions &&
                                          Provider.of<YouScribePremium>(context)
                                              .isPremium &&
                                          state.product.isPremium!
                                      ? Container(
                                          margin: const EdgeInsets.all(10),
                                          child: InkWell(
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .extractGuardMessage,
                                              style: WidgetStyles
                                                  .caption1TextStyle
                                                  .copyWith(
                                                      color: YouScribeColors
                                                          .primaryAppColor),
                                              maxLines: 5,
                                              textAlign: TextAlign.center,
                                            ),
                                            onTap: () async {
                                              await _extractStopTimeReachedHandler(
                                                  AudioExtractStopTimeReachedState(
                                                      chapters: state.chapters,
                                                      product: product!,
                                                      isPremium: isPremium,
                                                      collection:
                                                          state.collection,
                                                      isProductCollection: state
                                                          .isProductCollection));
                                            },
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                            ),
                            StreamBuilder<PositionData>(
                              stream: _positionDataStream,
                              builder: (context, snapshot) {
                                final positionData = snapshot.data;
                                // save buffer in prefs
                                if (positionData != null) {
                                  final prefs = SharedPreferences.getInstance();
                                  // ignore: cascade_invocations
                                  prefs.then((value) {
                                    value.setDouble(
                                        PreferenceKey.bufferedPosition,
                                        positionData.position.inSeconds
                                            .toDouble());
                                  });
                                }
                                return SeekBar(
                                  duration:
                                      positionData?.duration ?? Duration.zero,
                                  position:
                                      positionData?.position ?? Duration.zero,
                                  bufferedPosition:
                                      positionData?.bufferedPosition ??
                                          Duration.zero,
                                  onChangeEnd: _player.seek,
                                );
                              },
                            ),

                            // Display play/pause button and volume/speed sliders.
                            ControlButtons(_player,
                                chapterLenght: state.chapters.length,
                                isPremium: isPremium,
                                isPremiunBook: state.product.isPremium ?? false,
                                extraChapterIndex: state.extractChapterIndex,
                                hasExtraction: hasExtraction && isPremium,
                                collectionCurrentProductId: state.product.id,
                                isCollectionProductList:
                                    state.isProductCollection &&
                                        state.collection.isNotEmpty,
                                collectionProductNextId: getNextId(
                                    state.collection, state.product.id!),
                                collectionProductPrevId: getPrevId(
                                    state.collection, state.product.id!),
                                goPreviousProduct: (value) {
                                  _restart(getPrevId(
                                      state.collection, state.product.id!));
                                },
                                goNextProduct: (value) {
                                  _restart(getNextId(
                                      state.collection, state.product.id!));
                                },
                                extraStop: (p0) => {
                                      _extractStopTimeReachedHandler(
                                          AudioExtractStopTimeReachedState(
                                              chapters: const [],
                                              product: product!,
                                              isPremium: isPremium,
                                              collection: state.collection,
                                              isProductCollection:
                                                  state.isProductCollection))
                                    }),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ]);
          }

          if (widget.player.isNotNull) {
            return Stack(children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(product?.imageUrl ?? '')),
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(gradient: WidgetStyles.youscribeGradient),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 43, left: 10),
                    alignment: Alignment.topLeft,
                    child: const YsBackButton(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 17),
                    child: Center(
                      child: Column(children: [
                        Text(
                          product?.author ?? '',
                          style: WidgetStyles.textStyle
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          product?.title ?? '',
                          style: WidgetStyles.title3TextStyle.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          product?.narrator ?? '',
                          style: WidgetStyles.title3TextStyle
                              .copyWith(color: Colors.white),
                        ),
                      ]),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(bottomSheetBorder),
                        topRight: Radius.circular(bottomSheetBorder)),
                    child: SizedBox(
                      height: 250,
                      child: ColoredBox(
                        color: YouScribeColors.whiteColor,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, top: 1, right: 15),
                              child: Row(children: [
                                IconButton(
                                  style: ControlButtons.audioButtonStyle,
                                  onPressed: () async {
                                    await _displayChapters(
                                        context,
                                        null,
                                        extraChapterIndex,
                                        hasExtraction,
                                        isPremium);
                                  },
                                  icon: const FontAwesomeTextIcon(
                                      font: FontIcons.fontAwesomeList,
                                      color: YouScribeColors.primaryAppColor),
                                ),
                                Expanded(
                                    child: Center(
                                        child: _currentChapterTitle(state))),
                                IconButton(
                                  style: ControlButtons.audioButtonStyle,
                                  onPressed: () async {
                                    await _displaySettings(context, null);
                                  },
                                  icon: const FontAwesomeTextIcon(
                                      font: FontIcons.fontAwesomeSliders,
                                      color: YouScribeColors.primaryAppColor),
                                ),
                              ]),
                            ),
                            SizedBox(
                              child: Provider.of<FloatingPlayerControl>(context)
                                          .hasExtraction &&
                                      !Provider.of<YouScribePremium>(context)
                                          .isPremium
                                  ? Container(
                                      margin: const EdgeInsets.all(10),
                                      child: AppPurchasView(
                                          cubit: cubit,
                                          child: InkWell(
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .extractGuardMessage,
                                              style: WidgetStyles
                                                  .caption1TextStyle
                                                  .copyWith(
                                                      color: YouScribeColors
                                                          .primaryAppColor),
                                              maxLines: 5,
                                              textAlign: TextAlign.center,
                                            ),
                                            onTap: () async {
                                              await _extractStopTimeReachedHandler(
                                                  AudioExtractStopTimeReachedState(
                                                chapters: const [],
                                                product: product!,
                                                isPremium: isPremium,
                                                isProductCollection:
                                                    isCollectionProduct,
                                                collection: collection,
                                              ));
                                            },
                                          )),
                                    )
                                  : Provider.of<FloatingPlayerControl>(context)
                                              .hasExtraction &&
                                          Provider.of<YouScribePremium>(context)
                                              .isPremium &&
                                          widget.product!.isPremium!
                                      ? Container(
                                          margin: const EdgeInsets.all(10),
                                          child: AppPurchasView(
                                              cubit: cubit,
                                              child: InkWell(
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .extractGuardMessage,
                                                  style: WidgetStyles
                                                      .caption1TextStyle
                                                      .copyWith(
                                                          color: YouScribeColors
                                                              .primaryAppColor),
                                                  maxLines: 5,
                                                  textAlign: TextAlign.center,
                                                ),
                                                onTap: () async {
                                                  await _extractStopTimeReachedHandler(
                                                      AudioExtractStopTimeReachedState(
                                                    chapters: const [],
                                                    product: product!,
                                                    isPremium: isPremium,
                                                    isProductCollection:
                                                        isCollectionProduct,
                                                    collection: collection,
                                                  ));
                                                },
                                              )),
                                        )
                                      : const SizedBox.shrink(),
                            ),

                            StreamBuilder<PositionData>(
                              stream: _positionDataStream,
                              builder: (context, snapshot) {
                                final positionData = snapshot.data;
                                if (positionData != null) {
                                  final prefs = SharedPreferences.getInstance();
                                  prefs.then((value) {
                                    value.setDouble(
                                        'bufferedPosition',
                                        positionData.position.inSeconds
                                            .toDouble());
                                  });
                                }
                                return SeekBar(
                                  duration:
                                      positionData?.duration ?? Duration.zero,
                                  position:
                                      positionData?.position ?? Duration.zero,
                                  bufferedPosition:
                                      positionData?.bufferedPosition ??
                                          Duration.zero,
                                  onChangeEnd: _player.seek,
                                );
                              },
                            ),

                            // Display play/pause button and volume/speed sliders.
                            ControlButtons(_player,
                                chapterLenght: _player.sequence!.length,
                                isPremium: isPremium,
                                isPremiunBook: widget.product!.isPremium!,
                                extraChapterIndex: extraChapterIndex,
                                collectionCurrentProductId: widget.product!.id,
                                isCollectionProductList: isCollectionProduct &&
                                    collection.isNotEmpty,
                                collectionProductNextId:
                                    getNextId(collection, widget.product!.id!),
                                collectionProductPrevId:
                                    getPrevId(collection, widget.product!.id!),
                                hasExtraction:
                                    Provider.of<FloatingPlayerControl>(context)
                                            .hasExtraction &&
                                        !Provider.of<YouScribePremium>(context)
                                            .isPremium,
                                goPreviousProduct: (value) {
                                  _restart(getPrevId(collection, product!.id!));
                                },
                                goNextProduct: (value) {
                                  _restart(getNextId(collection, product!.id!));
                                },
                                extraStop: (p0) => {
                                      _extractStopTimeReachedHandler(
                                          AudioExtractStopTimeReachedState(
                                        chapters: const [],
                                        product: product!,
                                        isPremium: isPremium,
                                        isProductCollection:
                                            isCollectionProduct,
                                        collection: collection,
                                      ))
                                    }),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ]);
          }

          return Stack(children: [
            // Container(
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //         fit: BoxFit.cover,
            //         image: NetworkImage(product?.imageUrl ?? '')),
            //   ),
            // ),
            Container(
              decoration:
                  BoxDecoration(gradient: WidgetStyles.youscribeGradient),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 43, left: 10),
                  alignment: Alignment.topLeft,
                  child: const YsBackButton(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 17),
                  child: Center(
                    child: Column(children: [
                      Text(
                        product?.author ?? '',
                        style: WidgetStyles.textStyle
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        product?.title ?? '',
                        style: WidgetStyles.title3TextStyle.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        product?.narrator ?? '',
                        style: WidgetStyles.title3TextStyle
                            .copyWith(color: Colors.white),
                      ),
                    ]),
                  ),
                ),
                const Expanded(child: SizedBox()),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(bottomSheetBorder),
                      topRight: Radius.circular(bottomSheetBorder)),
                  child: SizedBox(
                    height: 250,
                    child: ColoredBox(
                      color: YouScribeColors.whiteColor,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 1, right: 15),
                            child: Row(children: [
                              IconButton(
                                style: ControlButtons.audioButtonStyle,
                                onPressed: () async {},
                                icon: const FontAwesomeTextIcon(
                                    font: FontIcons.fontAwesomeList,
                                    color: YouScribeColors.primaryAppColor),
                              ),
                              const Expanded(child: Center()),
                              IconButton(
                                style: ControlButtons.audioButtonStyle,
                                onPressed: () async {
                                  await _displaySettings(
                                      context, latestLoadedState);
                                },
                                icon: const FontAwesomeTextIcon(
                                    font: FontIcons.fontAwesomeSliders,
                                    color: YouScribeColors.primaryAppColor),
                              ),
                            ]),
                          ),

                          StreamBuilder<PositionData>(
                            stream: _positionDataStream,
                            builder: (context, snapshot) {
                              final positionData = snapshot.data;
                              return SeekBar(
                                duration:
                                    positionData?.duration ?? Duration.zero,
                                position:
                                    positionData?.position ?? Duration.zero,
                                bufferedPosition:
                                    positionData?.bufferedPosition ??
                                        Duration.zero,
                                // onChangeEnd: (){},
                              );
                            },
                          ),

                          // Display play/pause button and volume/speed sliders.
                          Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    style: audioButtonStyle,
                                    icon: const FontAwesomeTextIcon(
                                        font: FontIcons.fontAwesomeVolumeUp,
                                        fontSize: 35,
                                        color: YouScribeColors.primaryAppColor),
                                    iconSize: 60,
                                    onPressed: () {},
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          style: audioButtonStyle,
                                          onPressed: () {},
                                          icon: const FontAwesomeTextIcon(
                                              font: FontIcons
                                                  .fontAwesomeStepBackward,
                                              fontSize: 24,
                                              color: YouScribeColors
                                                  .primaryAppColor)),
                                      IconButton(
                                          style: audioButtonStyle,
                                          iconSize: 35,
                                          onPressed: () {},
                                          icon: const ImageIcon(AssetImage(
                                              ImagesName.backwardOrange))),
                                    ],
                                  ),
                                  IconButton(
                                    style: audioButtonStyle,
                                    icon: const FontAwesomeTextIcon(
                                        font: FontIcons.fontAwesomePlayCircle,
                                        fontSize: 60,
                                        color: YouScribeColors.primaryAppColor),
                                    iconSize: 60,
                                    onPressed: () {},
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          style: audioButtonStyle,
                                          iconSize: 35,
                                          onPressed: () {},
                                          icon: const ImageIcon(AssetImage(
                                              ImagesName.forwardOrange))),
                                      IconButton(
                                          style: audioButtonStyle,
                                          onPressed: () {},
                                          icon: const FontAwesomeTextIcon(
                                              font: FontIcons
                                                  .fontAwesomeStepForward,
                                              fontSize: 35,
                                              color: YouScribeColors
                                                  .primaryAppColor)),
                                    ],
                                  ),
                                  IconButton(
                                    style: audioButtonStyle,
                                    icon: Text("1x",
                                        style: WidgetStyles.caption1TextStyle
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: YouScribeColors
                                                    .primaryAppColor)),
                                    onPressed: () {},
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ]);
        },
      ),
    ));
  }

  StreamBuilder<PlayerState> _currentChapterTitle(AudioPlayerState? state) {
    return StreamBuilder(
        stream: _player.playerStateStream,
        builder: (context, snapshot) {
          if (state is AudioPlayerLoadedState) {
            if ((snapshot.data?.processingState == ProcessingState.ready) &&
                _player.currentIndex != null &&
                state.chapters.isNotEmpty) {
              // final index =_player.currentIndex!+1;
              if (state.chapters.length == 1) {
                return Text(state.product.title ?? "",
                    style: WidgetStyles.textStyle.copyWith(
                        color: YouScribeColors.primaryAppColor,
                        fontWeight: FontWeight.w600));
              }
              return Text(
                  state.chapters[_player.currentIndex ?? 0].title!.replaceAll(
                      AppLocalizations.of(context)!.chapterUnavailable, ''),
                  style: WidgetStyles.textStyle.copyWith(
                      color: YouScribeColors.primaryAppColor,
                      fontWeight: FontWeight.w600));
            }
          } else {
            if (widget.player!.sequence!.length == 1) {
              return Text(widget.product!.title ?? "",
                  style: WidgetStyles.textStyle.copyWith(
                      color: YouScribeColors.primaryAppColor,
                      fontWeight: FontWeight.w600));
            }
            final value = (_player.sequence![_player.currentIndex ?? 0].tag
                            .title as String)
                        .contains("Chapitre") ||
                    (_player.sequence![_player.currentIndex ?? 0].tag.title
                            as String)
                        .contains("Piste") ||
                    (_player.sequence![_player.currentIndex ?? 0].tag.title
                            as String)
                        .contains("Chapter")
                ? '${AppLocalizations.of(context)!.chapterPrefix} ${(_player.currentIndex ?? 0) + 1}'
                : _player.sequence![_player.currentIndex ?? 0].tag.title
                    as String;
            return Text(value,
                style: WidgetStyles.textStyle.copyWith(
                    color: YouScribeColors.primaryAppColor,
                    fontWeight: FontWeight.w600));
          }

          return const SizedBox.shrink();
        });
  }

  void _setChaptersTitle(AudioPlayerLoadedState? state, BuildContext context) {
    try {
      //  if (state.isNotNull) {
      for (final chapter in state!.chapters) {
        if (chapter.title.isNotNullOrEmpty) {
          if (state.hasExtractRestrictions) {
            if (chapter.orderId < state.extractChapterIndex) {
              chapter.title = chapter.title!.contains("Chapitre") ||
                      chapter.title!.contains("Piste") ||
                      chapter.title!.contains("Chapter")
                  ? "${AppLocalizations.of(context)!.chapterPrefix} ${chapter.orderId + 1}"
                  : chapter.title!.contains("${chapter.orderId + 1}")
                      ? chapter.title
                      : "${chapter.orderId + 1}. ${chapter.title}";
            } else {
              chapter.title = chapter.title!.contains("Chapitre") ||
                      chapter.title!.contains("Piste") ||
                      chapter.title!.contains("Chapter")
                  ? chapter.title!.contains(
                          AppLocalizations.of(context)!.chapterUnavailable)
                      ? chapter.title
                      : "${AppLocalizations.of(context)!.chapterPrefix} ${chapter.orderId + 1}${AppLocalizations.of(context)!.chapterUnavailable}"
                  : chapter.title!.contains(
                          AppLocalizations.of(context)!.chapterUnavailable)
                      ? chapter.title
                      : "${chapter.orderId + 1}. ${chapter.title} ${AppLocalizations.of(context)!.chapterUnavailable}";
            }
          } else {
            chapter.title = chapter.title!.contains("Chapitre") ||
                    chapter.title!.contains("Piste") ||
                    chapter.title!.contains("Chapter")
                ? "${AppLocalizations.of(context)!.chapterPrefix} ${chapter.orderId + 1}"
                : chapter.title!.contains("${chapter.orderId + 1}")
                    ? chapter.title
                    : "${chapter.orderId + 1}. ${chapter.title}";
          }
        }
      }
    } catch (e) {
      Exception(e);
    }
  }

  Future<void> _displayChapters(
      BuildContext context,
      AudioPlayerLoadedState? state,
      int extraChapterIndex,
      bool hasExtraction,
      bool isPremium) async {
    int? selectedIndex;
    if (state == null) {
      selectedIndex = await showModalBottomSheet<int>(
          context: context,
          backgroundColor: Theme.of(context).colorScheme.background,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(bottomSheetBorder),
              topRight: Radius.circular(bottomSheetBorder),
            ),
          ),
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                height: 300,
                child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: _player.sequence?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context, index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                Provider.of<FloatingPlayerControl>(context)
                                        .hasExtraction
                                    ? index < extraChapterIndex
                                        ? (_player.sequence![index].tag.title as String)
                                                    .contains("Chapitre") ||
                                                (_player.sequence![index].tag.title as String)
                                                    .contains("Piste") ||
                                                (_player.sequence![index].tag.title as String)
                                                    .contains("Chapter")
                                            ? '${AppLocalizations.of(context)!.chapterPrefix} ${index + 1}'
                                            : _player.sequence![index].tag.title
                                                as String
                                        : (_player.sequence![index].tag.title as String)
                                                    .contains("Chapitre") ||
                                                (_player.sequence![index].tag.title as String)
                                                    .contains("Piste") ||
                                                (_player.sequence![index].tag.title as String)
                                                    .contains("Chapter")
                                            ? '${AppLocalizations.of(context)!.chapterPrefix} ${index + 1}${AppLocalizations.of(context)!.chapterUnavailable}'
                                            : '${_player.sequence![index].tag.title as String} ${index + 1} ${AppLocalizations.of(context)!.chapterUnavailable}'
                                    : (_player.sequence![index].tag.title as String)
                                                .contains("Chapitre") ||
                                            (_player.sequence![index].tag.title as String)
                                                .contains("Piste") ||
                                            (_player.sequence![index].tag.title as String).contains("Chapter")
                                        ? '${AppLocalizations.of(context)!.chapterPrefix} ${index + 1}'
                                        : _player.sequence![index].tag.title as String,

                                // _player.sequence![index].tag.title as String,
                                style: WidgetStyles.textStyle.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .color),
                              ),
                            )),
                      );
                    }),
              ),
            );
          });
    } else {
      selectedIndex = await showModalBottomSheet<int>(
          context: context,
          backgroundColor: Theme.of(context).colorScheme.background,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(bottomSheetBorder),
                  topRight: Radius.circular(bottomSheetBorder))),
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                height: 300,
                child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: state.chapters.length,
                    itemBuilder: (context, index) {
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context, index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                state.chapters[index].title ?? '',
                                style: WidgetStyles.textStyle.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .color),
                              ),
                            )),
                      );
                    }),
              ),
            );
          });
    }
    if (selectedIndex == -1 || selectedIndex == null) {
      return;
    }

    if (selectedIndex == _player.currentIndex) {
      return;
    }

    if (hasExtraction && state!.product.isPremium!) {
      if (selectedIndex + 1 > extraChapterIndex) {
        await _extractStopTimeReachedHandler(AudioExtractStopTimeReachedState(
          chapters: const [],
          product: widget.product ?? state.product,
          isPremium: isPremium,
          collection: const [],
          isProductCollection: state.isProductCollection,
        ));
        return;
      }
    }

    await _player.seek(Duration.zero, index: selectedIndex);
    await _player.play();
  }

  Future<void> _displaySettings(
      BuildContext context, AudioPlayerLoadedState? state) async {
    final TextEditingController controller = TextEditingController();
    final minutes = await showDialog<int>(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(AppLocalizations.of(context)!.stopReadingAfterNMinutes),
            content: SizedBox(
              height: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: WidgetStyles.textFieldInputDecoration.copyWith(
                        hintText: AppLocalizations.of(context)!.timeInMinutes),
                    controller: controller,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          YouScribeColors.primaryAppColor,
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          YouScribeColors.whiteColor,
                        )),
                    onPressed: () {
                      Navigator.pop(
                          context,
                          controller.text.isNotEmpty
                              ? int.parse(controller.text)
                              : 0);
                    },
                    child: Text(AppLocalizations.of(context)!.done,
                        style: WidgetStyles.textStyle.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary)),
                  )
                ],
              ),
            ),
          );
        });

    if (minutes != null && minutes != 0) {
      if (state.isNotNull) {
        locator.get<YsTimer>().monitorAudioPlayer(state!.product.id!, minutes);
      } else {
        locator.get<YsTimer>().monitorAudioPlayer(widget.product!.id!, minutes);
      }
    }
  }

// get prev Id of the list
  int getPrevId(List<ProductEntity> list, int currentId) {
    if (list.isNullOrEmpty) {
      return 0;
    }
    final currentIndex = list.indexWhere((element) => element.id == currentId);
    if (currentIndex == 0) {
      return 0;
    }
    final prevProduct = list[currentIndex - 1];
    return prevProduct.id!;
  }

// get next Id of the list
  int getNextId(List<ProductEntity> list, int currentId) {
    if (list.isNullOrEmpty) {
      return 0;
    }
    final currentIndex = list.indexWhere((element) => element.id == currentId);
    if (currentIndex == list.length - 1) {
      return 0;
    }
    final nextProduct = list[currentIndex + 1];
    return nextProduct.id!;
  }
}
