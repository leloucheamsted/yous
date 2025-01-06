import 'dart:math';

import 'package:flutter/material.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class SeekBar extends StatefulWidget {
  const SeekBar({
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    super.key,
    this.onChanged,
    this.onChangeEnd,
  });
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  @override
  SeekBarState createState() => SeekBarState();
}

class SeekBarState extends State<SeekBar> {
  double? _dragValue;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SliderTheme(
          data: _sliderThemeData.copyWith(
              thumbShape: HiddenThumbComponentShape(),
              activeTrackColor:
                  YouScribeColors.secondaryTextColor.withOpacity(0.3),
              inactiveTrackColor: YouScribeColors.primaryAppLightColor),
          child: ExcludeSemantics(
            child: Slider(
              max: widget.duration.inMilliseconds.toDouble(),
              value: min(widget.bufferedPosition.inMilliseconds.toDouble(),
                  widget.duration.inMilliseconds.toDouble()),
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!.call(Duration(milliseconds: value.round()));
                }
              },
              onChangeEnd: (value) {
                if (widget.onChangeEnd != null) {
                  widget.onChangeEnd!
                      .call(Duration(milliseconds: value.round()));
                }
                _dragValue = null;
              },
            ),
          ),
        ),
        SliderTheme(
          data: _sliderThemeData.copyWith(
            inactiveTrackColor: Colors.transparent,
            activeTrackColor: YouScribeColors.primaryAppColor,
            thumbColor: YouScribeColors.whiteColor,
          ),
          child: Slider(
            max: widget.duration.inMilliseconds.toDouble(),
            value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble()),
            onChanged: (value) {
              setState(() {
                _dragValue = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged!.call(Duration(milliseconds: value.round()));
              }
            },
            onChangeEnd: (value) async {
              if (widget.onChangeEnd != null) {
                widget.onChangeEnd!.call(Duration(milliseconds: value.round()));
              }
              _dragValue = null;
            },
          ),
        ),
        Positioned(
          left: 16,
          bottom: 0,
          top: 35,
          child: Text(
              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                      .firstMatch("${widget.position}")
                      ?.group(1) ??
                  '${widget.position}',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: YouScribeColors.blackColor)),
        ),
        Positioned(
          right: 16,
          bottom: 0,
          child: Text(
              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                      .firstMatch("$_remaining")
                      ?.group(1) ??
                  '$_remaining',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: YouScribeColors.blackColor)),
        ),
      ],
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {}
}

class PositionData {
  const PositionData(this.position, this.bufferedPosition, this.duration);
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  double get loadedPercentage => (bufferedPosition.inMilliseconds.isFinite &&
          duration.inMilliseconds.isFinite && duration.inMilliseconds > 0)
      ? bufferedPosition.inMilliseconds / duration.inMilliseconds
      : 0.0;

  double get playedPercentage =>
      (position.inMilliseconds.isFinite && duration.inMilliseconds.isFinite &&
              duration.inMilliseconds > 0)
          ? position.inMilliseconds / duration.inMilliseconds
          : 0.0;
}

T? ambiguate<T>(T? value) => value;
