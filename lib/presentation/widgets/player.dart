// ignore_for_file: unawaited_futures, unnecessary_statements

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/helpers/async_snapshot_helper.dart';
import 'package:youscribe/core/use_cases/products/check_product_access_rights_use_case.dart';
import 'package:youscribe/presentation/screens/audio_player/widgets/seek_bar.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/utilities/floating_player_control.dart';
import 'package:youscribe/utilities/youscribe_premium.dart';

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> with WidgetsBindingObserver {
  static const double largeBannerSize = 60;
  AudioPlayer _player = locator();
  late String currentChapterTitle;
  bool isExpand = false;
  bool isPlaying = false;
  bool isPause = false;
  final Duration _animatioDuration = const Duration(seconds: 1);
  // late StreamSubscription<Duration>? _sub3;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // _sub3 = _player.positionStream
    //     .asBroadcastStream()
    //     .listen(_playerPositionChanged);
    _player.playingStream.listen((event) {
      setState(() {
        isPause = event;
        isPlaying = event;
      });
    });

    _player.playerStateStream.listen((state) async {
      if (state.processingState == ProcessingState.completed) {
        if (_player.sequence!.length - 1 == _player.currentIndex) {
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
            _player.stop();
          }
        }
      }
    });
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _player.positionStream.asBroadcastStream(),
        _player.bufferedPositionStream.asBroadcastStream(),
        _player.durationStream.asBroadcastStream(),
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _player =
              Provider.of<FloatingPlayerControl>(context, listen: false).player;
        });
      }
    });
    return Positioned(
      right: 10,
      bottom: Platform.isIOS ? 128 : 120,
      child: SizedBox(
          child: _player.audioSource != null
              ? Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      right: 10,
                      child: AnimatedOpacity(
                        opacity: !isExpand ? 1.0 : 0.0,
                        duration: _animatioDuration,
                        child: StreamBuilder<PositionData>(
                          stream: _positionDataStream,
                          builder: (context, snapshot) {
                            return snapshot.when(
                                loading: () => Container(
                                      width: 50,
                                      height: 50,
                                      color: Colors.transparent,
                                      child: const CircularProgressIndicator(
                                        backgroundColor: Colors.black12,
                                        color: Colors.white,
                                      ),
                                    ),
                                data: (data) => const SizedBox.shrink(),
                                failure: (error, stackTrace) =>
                                    const SizedBox.shrink());
                          },
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      height: 60,
                      width: isExpand
                          ? MediaQuery.of(context).size.width - 20
                          : largeBannerSize,
                      duration: _animatioDuration,
                      curve: Curves.fastOutSlowIn,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [
                            0.1,
                            1,
                          ],
                          colors: [
                            YouScribeColors.primaryAppColor,
                            YouScribeColors.accentColor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () async {
                              await Provider.of<FloatingPlayerControl>(context,
                                      listen: false)
                                  .player
                                  .stop();

                              await context
                                  .pushNamed(Routes.audioPlayer, extra: {
                                'player': _player,
                                'product': Provider.of<FloatingPlayerControl>(
                                        context,
                                        listen: false)
                                    .currentProduct
                              }, queryParameters: {
                                Routes.productIdParamName:
                                    Provider.of<FloatingPlayerControl>(context,
                                            listen: false)
                                        .currentProduct
                                        .id
                                        .toString(),
                                Routes.productAccessTypeParamName:
                                    ProductAccessState.canStream.toString()
                              });
                            },
                            child: SizedBox(
                              child: !isExpand
                                  ? AnimatedOpacity(
                                      opacity: !isExpand ? 1.0 : 0.0,
                                      duration: _animatioDuration,
                                      child: Ink(
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          onTap: () {
                                            setState(() {
                                              isExpand = !isExpand;
                                            });
                                          },
                                          child: const FontAwesomeTextIcon(
                                              font: FontIcons
                                                  .fontAwersomeWaveForm,
                                              fontSize: 25,
                                              color:
                                                  YouScribeColors.whiteColor),
                                        ),
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        AnimatedOpacity(
                                          opacity: isExpand ? 1.0 : 0.0,
                                          duration: _animatioDuration,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            onTap: () {
                                              setState(() {
                                                isExpand = !isExpand;
                                              });
                                            },
                                            child: const FontAwesomeTextIcon(
                                                font:
                                                    FontIcons.fontAwesomeTimes,
                                                fontSize: 25,
                                                color:
                                                    YouScribeColors.whiteColor),
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        Expanded(
                                            child: Row(
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        Provider.of<FloatingPlayerControl>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .currentProduct
                                                                .imageUrl ??
                                                            '')),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            InkWell(
                                              onTap: () async {
                                                await context.pushNamed(
                                                    Routes.audioPlayer,
                                                    extra: {
                                                      'player': _player,
                                                      'product': Provider.of<
                                                                  FloatingPlayerControl>(
                                                              context,
                                                              listen: false)
                                                          .currentProduct
                                                    },
                                                    queryParameters: {
                                                      Routes.productIdParamName:
                                                          Provider.of<FloatingPlayerControl>(
                                                                  context,
                                                                  listen: false)
                                                              .currentProduct
                                                              .id
                                                              .toString(),
                                                      Routes.productAccessTypeParamName:
                                                          ProductAccessState
                                                              .canStream
                                                              .toString()
                                                    });
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                          Provider.of<FloatingPlayerControl>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .currentProduct
                                                                      .title!
                                                                      .length >
                                                                  25
                                                              ? "${Provider.of<FloatingPlayerControl>(context, listen: false).currentProduct.title!.substring(0, 25)}..."
                                                              : Provider.of<FloatingPlayerControl>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .currentProduct
                                                                      .title ??
                                                                  '',
                                                          style: const TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              color:
                                                                  YouScribeColors
                                                                      .whiteColor,
                                                              fontSize: WidgetStyles
                                                                  .caption1Size,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  ),
                                                  StreamBuilder<PositionData>(
                                                    stream: _positionDataStream,
                                                    builder:
                                                        (context, snapshot) {
                                                      return snapshot.when(
                                                        data: (data) => Text(
                                                            RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                                                                    .firstMatch(
                                                                        "${data.position}")
                                                                    ?.group(
                                                                        1) ??
                                                                '${data.position}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                                    color: YouScribeColors
                                                                        .whiteColor)),
                                                        loading: () =>
                                                            const SizedBox
                                                                .shrink(),
                                                        failure: (error,
                                                                stackTrace) =>
                                                            const SizedBox
                                                                .shrink(),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                        const SizedBox(width: 10),
                                        AnimatedOpacity(
                                          opacity: isExpand ? 1.0 : 0.0,
                                          duration: _animatioDuration,
                                          child: _player.hasPrevious
                                              ? InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  onTap: _player.seekToPrevious,
                                                  child: const FontAwesomeTextIcon(
                                                      font: FontIcons
                                                          .fontAwesomeBackward,
                                                      fontSize: 25,
                                                      color: YouScribeColors
                                                          .whiteColor),
                                                )
                                              : const SizedBox.shrink(),
                                        ),
                                        const SizedBox(width: 10),
                                        AnimatedOpacity(
                                          opacity: isExpand ? 1.0 : 0.0,
                                          duration: _animatioDuration,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            onTap: () {
                                              _player.playing
                                                  ? _player.pause()
                                                  : _player.play();
                                              // });
                                            },
                                            child: FontAwesomeTextIcon(
                                                font: _player.playing
                                                    ? FontIcons
                                                        .fontAwesomePauseCircle
                                                    : FontIcons
                                                        .fontAwesomePlayCircle,
                                                fontSize: 25,
                                                color:
                                                    YouScribeColors.whiteColor),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        AnimatedOpacity(
                                          opacity: isExpand ? 1.0 : 0.0,
                                          duration: _animatioDuration,
                                          child: _player.hasNext
                                              ? InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  onTap: _player.seekToNext,
                                                  child:
                                                      const FontAwesomeTextIcon(
                                                          font: FontIcons
                                                              .fontAwesomeForward,
                                                          fontSize: 25,
                                                          color: YouScribeColors
                                                              .whiteColor),
                                                )
                                              : const SizedBox.shrink(),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 25,
                      left: 25,
                      child: AnimatedOpacity(
                        opacity: isExpand ? 1.0 : 0.0,
                        duration: _animatioDuration,
                        child: StreamBuilder<PositionData>(
                          stream: _positionDataStream,
                          builder: (context, snapshot) {
                            return snapshot.when(
                              data: (data) => Container(
                                width: MediaQuery.of(context).size.width - 50,
                                height: 3,
                                color: Colors.transparent,
                                child: LinearProgressIndicator(
                                  backgroundColor: Colors.black12,
                                  color: Colors.white,
                                  value: data.playedPercentage,
                                ),
                              ),
                              loading: () => const SizedBox.shrink(),
                              failure: (error, stackTrace) =>
                                  const SizedBox.shrink(),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: AnimatedOpacity(
                        opacity: !isExpand ? 1.0 : 0.0,
                        duration: _animatioDuration,
                        child: StreamBuilder<PositionData>(
                          stream: _positionDataStream,
                          builder: (context, snapshot) {
                            return snapshot.when(
                              data: (data) => InkWell(
                                onTap: () {
                                  setState(() {
                                    isExpand = !isExpand;
                                  });
                                },
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.transparent,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.black12,
                                    color: Colors.white,
                                    value: data.playedPercentage,
                                  ),
                                ),
                              ),
                              loading: () => const SizedBox.shrink(),
                              failure: (error, stackTrace) =>
                                  const SizedBox.shrink(),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )
              : null),
    );
  }
}
