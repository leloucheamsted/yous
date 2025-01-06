const int pageSize = 30;
const String imagePath = "assets/images";
const double appBarHeight = 60;
const String androidNotificationChannelId = "YouscribeChannel#449";
const String androidNotificationChannelName = "YouscribeChannel#449";
const String androidNotificationChannelDescription =
    "Youscribe's notification Channel";

class ImagesName {
  static const String baseImagePath = "assets/images";
  static const String appLogoWhite = "assets/images/logo_black.png";
  static const String appLogoDark = "assets/images/logo_white.png";
  static const String orangeLogoLight = "assets/images/orange_light.png";
  static const String orangeLogoDark = "assets/images/orange_dark.png";
  static const String mtnLogoLight = "assets/images/mtn_light.png";
  static const String mtnLogoDark = "assets/images/mtn_dark.png";
  static const String orangeMoneyLogoLight =
      "assets/images/orange_money_light.png";
  static const String orangeMneyLogoDark =
      "assets/images/orange_money_dark.png";
  static const String culturaLogoLight = "assets/images/cultura_light.png";
  static const String culturaLogoDark = "assets/images/cultura_dark.png";
  static const String alexandrieLogoLight =
      "assets/images/alexandrie_light.png";
  static const String alexandrieLogoDark = "assets/images/alexandrie_dark.png";
  static const String subscribeBanner = "assets/images/subscribe_banner.jpg";
  static const String premiumBadgeImg =
      "assets/images/ListPremium_32_Primary.png";
  static const String backwardLight = "$baseImagePath/backward_lightGray.png";
  static const String forwardOrange = "$baseImagePath/forward_orange.png";
  static const String forwardLightGray = "$baseImagePath/forward_lightGray.png";
  static const String backwardOrange = "$baseImagePath/backward_orange.png";
  static const String headerBackground = '$baseImagePath/header_background.png';
  static const String themeBackground = '$baseImagePath/themeBackground.png';
  static const String themeArtSmall = '$baseImagePath/theme-art_small.png';
  static const String themeBdActionEtAventureSmall =
      '$baseImagePath/theme-bd_action_et_aventure_small.png';
  static const String themeBdHumoristiqueSmall =
      '$baseImagePath/theme-bd_humoristique_small.png';
  static const String themeBdSfEtFantasySmall =
      '$baseImagePath/theme-bd_sf_et_fantasy_small.png';
  static const String themeBdSocieteSmall =
      '$baseImagePath/theme-bd_societe_small.png';
  static const String themeComicsSmall =
      '$baseImagePath/theme-comics_small.png';
  static const String themeCultureSmall =
      '$baseImagePath/theme-culture_small.png';
  static const String themeDeveloppementPersonnelSmall =
      '$baseImagePath/theme-developpement-personnel_small.png';
  static const String themeEducationSmall =
      '$baseImagePath/theme-education_small.png';
  static const String themeEnfantsSmall =
      '$baseImagePath/theme-enfants_small.png';
  static const String themeFictionsSmall =
      '$baseImagePath/theme-fictions_small.png';
  static const String themeHealthSmall =
      '$baseImagePath/theme-health_small.png';
  static const String themeHobbiesSmall =
      '$baseImagePath/theme-hobbies_small.png';
  static const String themeKnowSmall = '$baseImagePath/theme-know_small.png';
  static const String themeLifeSmall = '$baseImagePath/theme-life_small.png';
  static const String themeLifeproSmall =
      '$baseImagePath/theme-lifepro_small.png';
  static const String themeLiteratureSmall =
      '$baseImagePath/theme-literature_small.png';
  static const String themeMangasSmall =
      '$baseImagePath/theme-Mangas_small.png';
  static const String themeNewsSmall = '$baseImagePath/theme-news_small.png';
  static const String themeOthersSmall =
      '$baseImagePath/theme-others_small.png';
  static const String themeSocieteSmall =
      '$baseImagePath/theme-societe_small.png';
  static const String themeTemoignagesSmall =
      '$baseImagePath/theme-temoignages_small.png';
  static const String themeYoungSmall = '$baseImagePath/theme-young_small.png';
}

class AssetsName {
  static const String appName = "YouScribe";
  static const String fakeUserEMail = "loicJordan@gmail.com";
  static const String animationEmptyBox = "assets/animations/emptyList.json";
  static const String animationNoInternet =
      "assets/animations/noInternetAnimation.json";
  static const String garButton = "assets/images/button_gar.svg";
}

class PreferenceKey {
  static const String isGarUserConnected = "isGARUserConnect";
  static const String lastLogout = "lastlLogout";
  static const String lastUserAccountId = "lastUserAccountId";
  static const String lastlLogin = "lastlLogin";
  static const String isDownloaded = "isDownloaded";
  static const String libraryIsReloaded = "libraryIsReloaded";
  static const String bufferedPosition = 'bufferedPosition';
  static const String currentPlayerId = 'currentPlayerId';
  static const String currentSeekIndex = 'currentSeekIndex';
  static const String productAccessState = 'productAccessState';
}

enum ThemeType {
  system._("default"),
  darkTheme._("dark"),
  lightTheme._("light");

  const ThemeType._(this.value);
  final String value;

  // static implicit(String value) => AnalyticsEvent._(value);

  @override
  String toString() => value;
}

class FontName {
  static const String openSans = "OpenSans";
  static const String fontAwersome = "FontAwesome";
}

class BrandName {
  static const String youscribe = "Default";
  static const String orange = "Orange";
  static const String mtn = "MTN";
  static const String alexandrie = "Alexandrie";
  static const String cultura = "Cultura";
  static const String orangeMoney = "Orangemoney";
}