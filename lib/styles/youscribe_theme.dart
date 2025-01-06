import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/flavors.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/use_cases/configurations/get_user_settings_use_case.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class YouScribeTheme with ChangeNotifier, Debuggable, Loggable {
  YouScribeTheme() {
    loadThemePreference();
    getCobraString();
  }
  ThemeData theme = YouScribeTheme.lightTheme;
  bool get isDarkMode => theme == YouScribeTheme.darkTheme;
  String _brand = ImagesName.appLogoDark;
  String get brand => _brand;

  @override
  String get debugName => 'YouScribeTheme';

  // bool _isPremium = false;
  // bool get isPremium => _isPremium;
  static ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: YouScribeColors.primaryAppLightColor,
    ),
    useMaterial3: true,
    primaryColor: YouScribeColors.primaryAppLightColor,
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: YouScribeColors.primaryAppColor)),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: YouScribeColors.primaryAppColor),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: YouScribeColors.primaryAppColor),
      ),
    ),
    primaryColorLight: YouScribeColors.primaryAppLightColor,
    scaffoldBackgroundColor: YouScribeColors.backgroundColorLight,
    indicatorColor: YouScribeColors.primaryAppColor,
    hintColor: YouScribeColors.superLightGray,
    fontFamily: WidgetStyles.fontFamily,
    textTheme: TextTheme(
      labelLarge: WidgetStyles.faqTextStyle,
      displayLarge: WidgetStyles.largeTitleTextStyle,
      bodyMedium: WidgetStyles.textStyle,
      bodySmall: WidgetStyles.caption2TextStyle,
      titleLarge: WidgetStyles.title1TextStyle,
      titleMedium: WidgetStyles.title2TextStyle,
      titleSmall: WidgetStyles.title3TextStyle,
      displaySmall: WidgetStyles.caption1TextStyle.copyWith(
        color: YouScribeColors.secondaryTextColor,
      ),
    ),
    buttonTheme: const ButtonThemeData(
        buttonColor: YouScribeColors.primaryAppColor,
        colorScheme: ColorScheme.light(
          secondary: YouScribeColors.whiteColor,
          primary: YouScribeColors.primaryAppColor,
        )),
    drawerTheme: const DrawerThemeData(
      backgroundColor: YouScribeColors.backgroundColorLight,
    ),
    badgeTheme: const BadgeThemeData(
      backgroundColor: YouScribeColors.primaryAppColor,
      textColor: YouScribeColors.whiteColor,
    ),
    iconTheme: const IconThemeData(
      color: YouScribeColors.primaryAppColor,
    ),
    dividerColor: YouScribeColors.lightDividerColor,
    colorScheme: const ColorScheme.light(
      primary: YouScribeColors.primaryAppColor,
      onSecondary: YouScribeColors.whiteColor,
      error: YouScribeColors.errorColor,
      secondary: YouScribeColors.accentColor,
      tertiary: YouScribeColors.secondaryTextColor,
    ).copyWith(
        background: YouScribeColors.pageBackgroundLightColor,
        surface: YouScribeColors.accentColor.withOpacity(0.3)),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: YouScribeColors.primaryAppDarkColor,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: YouScribeColors.primaryAppColor)),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: YouScribeColors.primaryAppColor),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: YouScribeColors.primaryAppColor),
      ),
    ),
    scaffoldBackgroundColor: YouScribeColors.backgroundColorDark,
    primaryColor: YouScribeColors.primaryAppColor,
    primaryColorLight: YouScribeColors.primaryAppDarkColor,
    fontFamily: WidgetStyles.fontFamily,
    indicatorColor: YouScribeColors.blackColor,
    badgeTheme: const BadgeThemeData(
      backgroundColor: YouScribeColors.primaryAppLightColor,
      textColor: YouScribeColors.blackColor,
    ),
    buttonTheme: const ButtonThemeData(
        colorScheme: ColorScheme.light(
      secondary: YouScribeColors.blackColor,
      primary: YouScribeColors.lightIconColor,
    )),
    drawerTheme: const DrawerThemeData(
      backgroundColor: YouScribeColors.backgroundColorDark,
    ),
    textTheme: TextTheme(
      labelLarge: WidgetStyles.faqTextStyle,
      displayLarge: WidgetStyles.largeTitleTextStyle,
      bodyMedium: WidgetStyles.textStyle,
      bodySmall: WidgetStyles.caption2TextStyle,
      titleLarge: WidgetStyles.title1TextStyle,
      titleMedium: WidgetStyles.title2TextStyle,
      titleSmall: WidgetStyles.title3TextStyle,
      displaySmall: WidgetStyles.caption1TextStyle.copyWith(
        color: YouScribeColors.secondaryTextColor,
      ),
    ),
    iconTheme: const IconThemeData(
      color: YouScribeColors.lightIconColor,
    ),
    dividerColor: YouScribeColors.darkDividerColor,
    colorScheme: const ColorScheme.dark(
      primary: YouScribeColors.primaryAppColor,
      onPrimary: YouScribeColors.whiteColor,
      onSecondary: YouScribeColors.whiteColor,
      error: YouScribeColors.errorColor,
      secondary: YouScribeColors.accentColor,
      tertiary: YouScribeColors.secondaryTextColor,
    ).copyWith(
        background: YouScribeColors.primaryAppDarkColor,
        surface: YouScribeColors.accentColor.withOpacity(0.5)),
  );

  ThemeData loadTheme(ThemeType themeValue) {
    // User theme preferences
    // --------------------------------
    if (themeValue == ThemeType.system) {
      // use the default theme of system
      final brightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      theme = brightness == Brightness.dark
          ? YouScribeTheme.darkTheme
          : YouScribeTheme.lightTheme;

      // notifyListeners();
    } else if (themeValue == ThemeType.darkTheme) {
      theme = YouScribeTheme.darkTheme;
      notifyListeners();
    } else {
      theme = YouScribeTheme.lightTheme;
      notifyListeners();
    }
    notifyListeners();
    getCobraString();
    return isDarkMode ? YouScribeTheme.darkTheme : YouScribeTheme.lightTheme;
  }

  Future<ThemeType> loadThemePreference() async {
    final GetUserSettingsUseCase getUserConfigurationsUseCase = locator();
    final userConfigurationsResult = await getUserConfigurationsUseCase(null);

    if (userConfigurationsResult.isErr) {
      logError("Error loading user configurations:",
          error: userConfigurationsResult.err);
      return ThemeType.system;
    }

    final themeType = userConfigurationsResult.ok?.theme ?? ThemeType.system;
    loadTheme(themeType);

    return themeType;
  }

  Future<void> getCobraString() async {
    final currentUser = await AuthenticationManager.getCurrentUser();
    if (F.appFlavor == Flavor.youscribedev) {
      _brand = isDarkMode ? ImagesName.appLogoDark : ImagesName.appLogoWhite;
      notifyListeners();
    }
    switch (currentUser!.cobranding?.toLowerCase()) {
      case 'orange':
        notifyListeners();
      case 'mtn':
        notifyListeners();
      case 'alexandrie':
        notifyListeners();
      case 'cultura':
        notifyListeners();
      case 'orangemoney':
        notifyListeners();
    }
  }
}
