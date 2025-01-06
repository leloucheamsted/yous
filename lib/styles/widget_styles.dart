import 'package:flutter/material.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class WidgetStyles {
  static const String fontAwesomeFontFamily = 'FontAwesome';
  static const String fontFamily = "OpenSans";
  static const double largeTitleSize = 34;
  static const double title1Size = 28;
  static const double title2Size = 22;
  static const double title3Size = 20;
  static const double bodySize = 16;
  static const double subBodySize = 14;
  static const double caption1Size = 12;
  static const double caption2Size = 11;

  static const TextStyle textStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: bodySize,
    overflow: TextOverflow.ellipsis,
  );

  static const TextStyle secondaryTextStyle = TextStyle(
    fontFamily: fontFamily,
    color: YouScribeColors.secondaryTextColor,
    fontSize: bodySize,
    overflow: TextOverflow.ellipsis,
  );

  static const TextStyle helpTextStyle = TextStyle(
    fontFamily: fontFamily,
    color: YouScribeColors.secondaryTextColor,
    fontSize: caption1Size,
    overflow: TextOverflow.clip,
  );

  static InputDecoration textFieldInputDecoration = InputDecoration(
      border: const UnderlineInputBorder(),
      hintStyle: WidgetStyles.secondaryTextStyle
          .copyWith(fontSize: WidgetStyles.bodySize));

  static TextStyle largeTitleTextStyle =
      textStyle.copyWith(fontSize: largeTitleSize);

  static TextStyle title1TextStyle = textStyle.copyWith(fontSize: title1Size);

  static TextStyle title2TextStyle = textStyle.copyWith(fontSize: title2Size);

  static TextStyle title3TextStyle = textStyle.copyWith(fontSize: title3Size);

  static TextStyle caption1TextStyle =
      textStyle.copyWith(fontSize: caption1Size);

  static TextStyle caption2TextStyle =
      caption1TextStyle.copyWith(fontSize: caption2Size);
  static LinearGradient get youscribeGradient => LinearGradient(
          begin: const Alignment(0, 0.3),
          end: Alignment.topCenter,
          colors: [
            YouScribeColors.primaryAppColor,
            YouScribeColors.primaryAppColor.withOpacity(0.65)
          ]);
  //Buttons
  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    disabledBackgroundColor: YouScribeColors.primaryAppColor.withOpacity(0.6),
    backgroundColor: YouScribeColors.primaryAppColor,
  );

  static const TextStyle faqTextStyle = TextStyle(
    fontFamily: fontFamily,
    color: YouScribeColors.accentColor,
    fontWeight: FontWeight.w600,
    fontSize: bodySize,
    overflow: TextOverflow.clip,
  );
}
