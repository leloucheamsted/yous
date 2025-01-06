import 'package:flutter/material.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class FontAwesomeTextIcon extends StatelessWidget {
  const FontAwesomeTextIcon(
      {required this.font,
      super.key,
      this.fontSize,
      this.color = YouScribeColors.primaryTextColor});

  final String font;
  final double? fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      font,
      style: TextStyle(
          fontFamily: WidgetStyles.fontAwesomeFontFamily,
          fontSize: fontSize,
          color: color),
    );
  }
}
