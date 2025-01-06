// ignore_for_file: unnecessary_statements,, inference_failure_on_function_return_type
// inference_failure_on_function_return_type

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe/utilities/floating_player_control.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons(
    this.player, {
    required this.extraStop,
    required this.goNextProduct,
    required this.goPreviousProduct,
    required this.hasExtraction,
    required this.extraChapterIndex,
    required this.isPremium,
    required this.isPremiunBook,
    required this.isCollectionProductList,
    this.chapterLenght,
    this.collectionProductNextId,
    this.collectionProductPrevId,
    this.collectionCurrentProductId,
    super.key,
  });
  final AudioPlayer player;
  final int? chapterLenght;
  final bool hasExtraction;
  final bool isPremium;
  final bool isPremiunBook;
  final int extraChapterIndex;
  final int? collectionProductPrevId;
  final int? collectionProductNextId;
  final int? collectionCurrentProductId;
  final bool isCollectionProductList;
  final Function(void) extraStop;
  final Function(void) goNextProduct;
  final Function(void) goPreviousProduct;
  static const double normalIconSize = 35;
  static const double largeIconSize = 60;
  static const double smallIconSize = 18;
  static const int seekSize = 10;

  static ButtonStyle audioButtonStyle = ButtonStyle(
    splashFactory: NoSplash.splashFactory,
    iconColor: MaterialStateProperty.all<Color>(
      YouScribeColors.primaryAppColor,
    ),
  );
  // overlayColor: MaterialStatePropertyAll(YouScribeColors.superLightGray));

  int get currentIndex => player.currentIndex ?? 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Provider.of<FloatingPlayerControl>(context, listen: false)
              .changePlayingState(player);
        });
        // Provider.of<FloatingPlayerControl>(context, listen: false)
        //     .changePlayingState(player);
        return Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(
              style: audioButtonStyle,
              icon: const FontAwesomeTextIcon(
                  font: FontIcons.fontAwesomeVolumeUp,
                  fontSize: smallIconSize,
                  color: YouScribeColors.primaryAppColor),
              iconSize: largeIconSize,
              onPressed: () {
                Dialogs.showSliderDialog(
                  context: context,
                  title: AppLocalizations.of(context)!.volume,
                  divisions: 10,
                  min: 0,
                  max: 1,
                  value: player.volume,
                  stream: player.volumeStream,
                  multiplyBy100: true,
                  onChanged: player.setVolume,
                );
              },
            ),
            _buildBackwardsButtons(processingState, playing, context),
            _buildPlayButton(processingState, playing, context),
            _buildForwardsButtons(processingState, playing, context),
            StreamBuilder<double>(
              stream: player.speedStream,
              builder: (context, snapshot) => IconButton(
                style: audioButtonStyle,
                icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                    style: WidgetStyles.caption1TextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: YouScribeColors.primaryAppColor)),
                onPressed: () {
                  Dialogs.showSliderDialog(
                    context: context,
                    title: AppLocalizations.of(context)!.readerSpeed,
                    divisions: 10,
                    min: 0.5,
                    max: 2,
                    value: player.speed,
                    stream: player.speedStream,
                    onChanged: player.setSpeed,
                  );
                },
              ),
            )
          ]),
        );
      },
    );
  }

  Widget _buildBackwardsButtons(
      ProcessingState? processingState, bool? playing, BuildContext context) {
    final isBusy = processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering;

    return Row(
      children: [
        IconButton(
            style: audioButtonStyle,
            onPressed: isBusy
                ? null
                : currentIndex != 0
                    ? player.seekToPrevious
                    : () => goPreviousProduct(null),
            icon: Visibility(
              visible: (isCollectionProductList &&
                      (collectionProductPrevId != 0 || currentIndex > 0)) ||
                  (!isCollectionProductList && currentIndex > 0),
              child: FontAwesomeTextIcon(
                  font: FontIcons.fontAwesomeStepBackward,
                  fontSize: normalIconSize,
                  color: isBusy
                      ? YouScribeColors.secondaryTextColor
                      : YouScribeColors.primaryAppColor),
            )),
        IconButton(
            style: audioButtonStyle,
            iconSize: normalIconSize,
            onPressed: isBusy
                ? null
                : () async {
                    await player.seek(
                      player.position - const Duration(seconds: seekSize),
                    );
                  },
            icon: isBusy
                ? const ImageIcon(AssetImage(ImagesName.backwardLight))
                : const ImageIcon(AssetImage(ImagesName.backwardOrange))),
      ],
    );
  }

  Widget _buildForwardsButtons(
      ProcessingState? processingState, bool? playing, BuildContext context) {
    final isBusy = processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering;

    return Row(
      children: [
        IconButton(
            style: audioButtonStyle,
            iconSize: normalIconSize,
            onPressed: isBusy
                ? null
                : () async {
                    await player.seek(
                      player.position + const Duration(seconds: seekSize),
                    );
                  },
            icon: isBusy
                ? const ImageIcon(AssetImage(ImagesName.forwardLightGray))
                : const ImageIcon(AssetImage(ImagesName.forwardOrange))),
        IconButton(
            style: audioButtonStyle,
            onPressed: isBusy
                ? null
                : () {
                    if (currentIndex < chapterLenght! - 1) {
                      if (isPremiunBook) {
                        if (isPremium) {
                          hasExtraction
                              ? (currentIndex + 1) < extraChapterIndex
                                  ? player.seekToNext()
                                  : extraStop(null)
                              : player.seekToNext();
                        } else {
                          hasExtraction
                              ? (currentIndex + 1) < extraChapterIndex
                                  ? player.seekToNext()
                                  : extraStop(null)
                              : player.seekToNext();
                        }
                      } else {
                        if (isPremium) {
                          player.seekToNext();
                        } else {
                          hasExtraction &&
                                  (currentIndex + 1) < extraChapterIndex
                              ? player.seekToNext()
                              : extraStop(null);
                        }
                      }
                    } else {
                      goNextProduct(null);
                    }
                  },
            icon: Visibility(
              visible: (isCollectionProductList &&
                      (collectionProductNextId != 0 ||
                          currentIndex < chapterLenght! - 1)) ||
                  (!isCollectionProductList &&
                      currentIndex < chapterLenght! - 1),
              child: FontAwesomeTextIcon(
                  font: FontIcons.fontAwesomeStepForward,
                  fontSize: normalIconSize,
                  color: isBusy
                      ? YouScribeColors.secondaryTextColor
                      : YouScribeColors.primaryAppColor),
            )),
      ],
    );
  }

  Widget _buildPlayButton(
      ProcessingState? processingState, bool? playing, BuildContext context) {
    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      return Container(
        margin: const EdgeInsets.all(8),
        width: largeIconSize,
        height: largeIconSize,
        child: const CircularProgressIndicator(
          color: YouScribeColors.accentColor,
        ),
      );
    } else if (!(playing ?? false)) {
      return IconButton(
        style: audioButtonStyle,
        icon: const FontAwesomeTextIcon(
            font: FontIcons.fontAwesomePlayCircle,
            fontSize: largeIconSize,
            color: YouScribeColors.primaryAppColor),
        iconSize: largeIconSize,
        onPressed: player.play,
      );
    } else if (processingState != ProcessingState.completed) {
      return IconButton(
        style: audioButtonStyle,
        splashColor: Colors.transparent,
        icon: const FontAwesomeTextIcon(
            font: FontIcons.fontAwesomePauseCircle,
            fontSize: largeIconSize,
            color: YouScribeColors.primaryAppColor),
        iconSize: largeIconSize,
        onPressed: () async {
          await player.pause();
        },
      );
    } else {
      return IconButton(
        style: audioButtonStyle,
        splashColor: Colors.transparent,
        icon: const FontAwesomeTextIcon(
            font: FontIcons.fontAwesomePlayCircle,
            fontSize: largeIconSize,
            color: YouScribeColors.primaryAppColor),
        iconSize: largeIconSize,
        onPressed: () => player.seek(Duration.zero),
      );
    }
  }
}
