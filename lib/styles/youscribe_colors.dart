import 'package:flutter/material.dart';

class YouScribeColors {
  //TO Add levels of transparency to colors, checkout this: https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4
  static const Color primaryTextColor = Color(0xff322d3a);
  static const Color searchIconColor = Color(0xff322d3a);
  static const Color secondaryTextColor = Color(0xff9c9b9b);
  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color blackColor = Color(0xff09010d);
  static const Color backgroundColorLight = whiteColor;
  static const Color backgroundColorDark = Color(0xff303030);
  static const Color primaryAppColor = Color(0xffE87C61);
  static const Color onboardingBackgroundColor = Color(0xfff29468);
  static const Color primaryAppDarkColor = Color(0xff212121);
  static const Color primaryAppLightColor = Color(0xfffbf1e8);
  static const Color pageBackgroundLightColor = Color(0xffFFFFFF);
  static const Color pageBackgroundDarkColor = Color(0xffE87C61);
  static const Color accentColor = Color(0xff911B49);
  static const Color superLightGray = Color(0xffCDCDCD);
  static const Color invalidTextColor = Colors.red;
  static const Color affirmationColor = Colors.red;
  static const Color errorColor = Colors.red;
  static const Color lightDividerColor = Colors.black;
  static const Color darkDividerColor = Colors.white;
  static const Color lightIconColor = Colors.white;
  static const Color facebookColor = Color(0xff006AFF);
  static const Color commentsJetGray = Color(0xFF343434);
  static final LinearGradient ysGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        YouScribeColors.primaryAppColor.withOpacity(0.7),
        YouScribeColors.primaryAppColor,
      ]);
}
