// ignore_for_file: use_named_constants,
// no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: directives_ordering
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/current_user_account_entity.dart';
import 'package:youscribe/infrastructure/service/service_impl.dart';
import 'package:youscribe/presentation/blocs/account/account_bloc.dart';
import 'package:youscribe/presentation/blocs/notifications/notification_bloc.dart';
import 'package:youscribe/presentation/screens/account/components/account_dialog_view.dart';
import 'package:youscribe/presentation/screens/account/components/account_item.dart';
import 'package:youscribe/presentation/screens/account/components/account_settings.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe/utilities/floating_player_control.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final GlobalKey<ExpansionTileCardState> _configExpandKey = GlobalKey();
  CurrentUserAccountEntity currentUser = CurrentUserAccountEntity();
  bool _isGARUserConnected = false;
  @override
  void initState() {
    _getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, Platform.isAndroid ? 100 : 140),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 140,
            child: Stack(
              children: [
                SizedBox(
                  height: 110,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(80),
                            bottomRight: Radius.circular(80)),
                        image: DecorationImage(
                          image: AssetImage('$imagePath/profilBackground.png'),
                          fit: BoxFit.cover,
                        ),
                        color: YouScribeColors.primaryAppLightColor),
                    //  child:,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: (MediaQuery.of(context).size.width - 60) / 2,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: CircleAvatar(
                      radius: 29,
                      backgroundColor:
                          Theme.of(context).badgeTheme.backgroundColor,
                      child: FontAwesomeTextIcon(
                          font: FontIcons.fontAwesomeUser,
                          fontSize: 40,
                          color: Theme.of(context).badgeTheme.textColor!),
                    ),
                  ),
                )
              ],
            ),
          ),
          Text(
            currentUser.email ?? "",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 15),
          Divider(
              thickness: 0.5,
              color: YouScribeColors.blackColor.withOpacity(0.4)),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    _convertPageIntoGift(),
                    if (currentUser.premiumIsAllowed!)
                      AccountItem(
                        callback: () async {
                          await context.pushNamed(Routes.myTokens);
                        },
                        font: FontIcons.fontAwesomeCoins,
                        title: AppLocalizations.of(context)!.myTokens,
                      ),
                    ExpansionTileCard(
                      key: _configExpandKey,
                      elevation: 0,
                      animateTrailing: true,
                      baseColor: Colors.transparent,
                      expandedColor: Colors.transparent,
                      expandedTextColor: Colors.transparent,
                      contentPadding: const EdgeInsets.all(0),
                      finalPadding: const EdgeInsets.all(0),
                      title: GestureDetector(
                        onTap: () {
                          _configExpandKey.currentState!.toggleExpansion();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FontAwesomeTextIcon(
                                  font: FontIcons.fontAwesomeCog,
                                  fontSize: 20,
                                  color: YouScribeColors.primaryAppColor),
                              const SizedBox(width: 15),
                              Text(
                                AppLocalizations.of(context)!.accountConfig,
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            ],
                          ),
                        ),
                      ),
                      children: const [
                        AccountSettings(),
                      ],
                    ),
                    if (!_isGARUserConnected)
                      AccountItem(
                        callback: () {
                          context.pushNamed(Routes.help, extra: false);
                        },
                        font: FontIcons.fontAwesomeHelpingHand,
                        title: AppLocalizations.of(context)!.help,
                      ),
                    if (!_isGARUserConnected)
                      AccountItem(
                        callback: () async {
                          final showRate =
                              await ServiceImpl().requestAppRating(true);
                          if (showRate) {
                            await Dialogs.showStarRateDialog(context);
                          }
                        },
                        font: FontIcons.fontAwesomeStar,
                        title: AppLocalizations.of(context)!.requestRatings,
                      ),
                    if (!_isGARUserConnected)
                      AccountItem(
                        callback: () async {
                          Platform.isAndroid
                              ? Dialogs.displayNotificationsAlert(
                                  context: context,
                                  openNotification: _openNotifiaction)
                              : await showCupertinoModalPopup<void>(
                                  context: context,
                                  builder: (subContext) => CupertinoActionSheet(
                                    title: Text(AppLocalizations.of(context)!
                                        .followActionSheetTitle),
                                    actions: <Widget>[
                                      CupertinoActionSheetAction(
                                        onPressed: () {
                                          _openNotifiaction(subContext,
                                              NotificationOption.authorsOption);
                                        },
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .authorNotificationOption),
                                      ),
                                      CupertinoActionSheetAction(
                                        onPressed: () {
                                          _openNotifiaction(subContext,
                                              NotificationOption.editorsOption);
                                        },
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .editorsNotificationOption),
                                      ),
                                      CupertinoActionSheetAction(
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .subThemeNotificationsOption),
                                        onPressed: () {
                                          _openNotifiaction(subContext,
                                              NotificationOption.themesOption);
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
                        font: FontIcons.fontAwesomeBell,
                        title: AppLocalizations.of(context)!.notifications,
                      ),
                    if (_isGARUserConnected)
                      AccountItem(
                        callback: _openPersonalDataCharter,
                        font: FontIcons.fontAwersomeCard,
                        title:
                            AppLocalizations.of(context)!.personalDataCharter,
                      ),
                    if (_isGARUserConnected)
                      AccountItem(
                        callback: _openLegalNotices,
                        font: FontIcons.fontAwersomeFlag,
                        title: AppLocalizations.of(context)!.legalNotices,
                      ),
                    AccountItem(
                      callback: () async {
                        final bool isClose = await AccountDialoView.logoutAlert(
                            context: context);
                        if (isClose) {
                          await _logOut();
                        } else {}
                      },
                      font: FontIcons.fontAwesomeSignout,
                      title: AppLocalizations.of(context)!.logOut,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder(
                        future: PackageInfo.fromPlatform(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final PackageInfo packageInfo = snapshot.data!;
                            return Text(
                                '${packageInfo.version} (${packageInfo.buildNumber})',
                                style: WidgetStyles.helpTextStyle);
                          } else {
                            return const SizedBox();
                          }
                        }),
                  ],
                ),
              ],
            ),
          )),
          Column(
            children: [
              Divider(
                  thickness: 0.4,
                  color: YouScribeColors.blackColor.withOpacity(0.4)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                child: Text(AppLocalizations.of(context)!.accountInfo,
                    style: WidgetStyles.helpTextStyle),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _openNotifiaction(BuildContext subContext, NotificationOption option) {
    if (Platform.isIOS) {
      Navigator.pop(subContext);
    } else {
      Navigator.of(context, rootNavigator: true).pop(context);
    }

    context.pushNamed(Routes.notifications, extra: option);
  }

  Future<void> _openLegalNotices() async {
    final result = await AuthenticationManager.openLegalNotices();
    await context.pushNamed(Routes.personnalLegalNotices,
        queryParameters: {Routes.contentLegalParamName: result});
  }

  Future<void> _openPersonalDataCharter() async {
    final result = await AuthenticationManager.openPersonalDataCharter();
    await context.pushNamed(Routes.personnalLegalNotices,
        queryParameters: {Routes.contentLegalParamName: result});
  }

  Widget _convertPageIntoGift() {
    return BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
      return SizedBox(
        child: state.isLisEtGagneVisible
            ? Column(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                        color:
                            Theme.of(context).colorScheme.copyWith().surface),
                    child: AccountItem(
                      callback: () {},
                      font: FontIcons.fontAwesomeGift,
                      title: AppLocalizations.of(context)!.lisEtGagneBannerText,
                    ),
                  ),
                  Divider(
                      thickness: 0.5,
                      color: YouScribeColors.blackColor.withOpacity(0.4)),
                ],
              )
            : null,
      );
    });
  }

  Future<void> _logOut() async {
    final SharedPreferences preferences = await prefs;
    final auth = locator<AuthenticationManager>();

    // stop player
    if (mounted) {
      await Provider.of<FloatingPlayerControl>(context, listen: false)
          .player
          .stop();
      // ignore: use_build_context_synchronously
      await Provider.of<FloatingPlayerControl>(context, listen: false)
          .changePlayingState(AudioPlayer());
    }
    final bool isGARUserConnected =
        preferences.getBool(PreferenceKey.isGarUserConnected) ?? false;
    if (isGARUserConnected) {
      await auth.logOutWithGAR();
    } else {
      await auth.logOut();
    }
  }

  void _getCurrentUser() {
    AuthenticationManager.getCurrentUser().then((value) async {
      final SharedPreferences preferences = await prefs;
      final bool isGARUserConnected =
          preferences.getBool(PreferenceKey.isGarUserConnected) ?? false;
      setState(() {
        currentUser = value!;
        _isGARUserConnected = isGARUserConnected;
      });
    });
  }
}
