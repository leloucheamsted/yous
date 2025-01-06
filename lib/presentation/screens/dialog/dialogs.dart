// ignore_for_file: avoid_dynamic_calls

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/country_configuration_entity.dart';
import 'package:youscribe/core/entities/simple_library_entity.dart';
import 'package:youscribe/infrastructure/service/service_impl.dart';
import 'package:youscribe/presentation/blocs/notifications/notification_bloc.dart';
import 'package:youscribe/presentation/blocs/premium_suggestion/premium_suggestion_bloc.dart';
import 'package:youscribe/presentation/screens/premium_suggestion/premium_suggestion_screen.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/utilities/youscribe_premium.dart';
import 'package:youscribe_analytics/youscribe_analytics.dart';

class Dialogs {
  final navigationKey = GlobalKey<NavigatorState>();
  static Future<void> displayGeneralAPIErrorAlert(
      {required BuildContext context}) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: Text(AppLocalizations.of(context)!.errorOccuredGeneralTitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(overflow: TextOverflow.clip)),
            content: Text(
                AppLocalizations.of(context)!.aPIErrorOccuredGeneralTitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(overflow: TextOverflow.clip)),
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                      child: Text(AppLocalizations.of(context)!.ok,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium)),
                ),
              )
            ],
          );
        });
  }

  static Future<void> displayInternetNeededAlert(
      {required BuildContext context}) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: Text(AppLocalizations.of(context)!.internetRequiredTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    overflow: TextOverflow.clip, fontWeight: FontWeight.w800)),
            content: Text(
                AppLocalizations.of(context)!.internetRequiredErrorMessage,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(overflow: TextOverflow.clip)),
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                      child: Text(AppLocalizations.of(context)!.ok,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium)),
                ),
              )
            ],
          );
        });
  }

  static Future<bool> displayCustomAlert({
    required BuildContext context,
    required String content,
    String title = "",
    bool isOneButton = false,
    String? leftButtonText,
    String? rightButtonText,
  }) async {
    final bool? state = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Container(
              width: MediaQuery.of(context).size.width - 30,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  overflow: TextOverflow.clip,
                                  fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Flexible(
                      child: Text(content,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(overflow: TextOverflow.clip)),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (!isOneButton)
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context, false);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 8),
                                child: Center(
                                  child: Text(
                                      leftButtonText ??
                                          AppLocalizations.of(context)!.cancel,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: YouScribeColors
                                                  .primaryAppColor)),
                                ),
                              ),
                            ),
                          ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context, true);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 8),
                              child: Center(
                                  child: Text(
                                      rightButtonText ??
                                          AppLocalizations.of(context)!.ok,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: YouScribeColors
                                                  .primaryAppColor))),
                            ),
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          );
        });

    return state ?? false;
  }

  static Future<void> displayFollowAlert(
      {required BuildContext context,
      required String title,
      required String followAuthor,
      required String followPublisher,
      required void Function() followAuthorEvent,
      required void Function() followPublisherEvent,
      required void Function() followThemeEvent,
      required String followTheme}) async {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            insetPadding: const EdgeInsets.all(20),
            shape: const RoundedRectangleBorder(),
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: Container(
              height: 220,
              width: MediaQuery.of(context).size.width - 30,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            overflow: TextOverflow.clip,
                            fontSize: WidgetStyles.title3Size,
                            fontWeight: FontWeight.w600)),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Ink(
                      child: InkWell(
                        onTap: followPublisherEvent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 13),
                          child: Text(followPublisher,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(overflow: TextOverflow.clip)),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Ink(
                      child: InkWell(
                        onTap: followAuthorEvent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 13),
                          child: Text(followAuthor,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(overflow: TextOverflow.clip)),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Ink(
                      child: InkWell(
                        onTap: followThemeEvent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 13),
                          child: Text(followTheme,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(overflow: TextOverflow.clip)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(AppLocalizations.of(context)!.cancel,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: YouScribeColors.accentColor,
                                      fontWeight: FontWeight.w500)),
                        ),
                      ),
                      const SizedBox(width: 4),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  static Future<void> displayPremiunInfoAlert(
      {required BuildContext context}) async {
    const double iconSize = 22;
    Widget premiumMessageAdvantageitemView(
        BuildContext context, String message, double iconSize) {
      return Row(
        children: [
          FontAwesomeTextIcon(
            font: FontIcons.fontAwesomeCheck,
            color: YouScribeColors.whiteColor,
            fontSize: iconSize / 1.5,
          ),
          const SizedBox(width: 3),
          Expanded(
            child: Text(message,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    overflow: TextOverflow.clip,
                    color: YouScribeColors.whiteColor)),
          ),
        ],
      );
    }

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            insetPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Platform.isIOS ? 10 : 0),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: Container(
              width: MediaQuery.of(context).size.width - 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Platform.isIOS ? 10 : 0),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0.1,
                      1,
                    ],
                    colors: [
                      YouScribeColors.primaryAppColor,
                      YouScribeColors.accentColor,
                    ],
                  )),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const FontAwesomeTextIcon(
                            font: FontIcons.fontAwersoneCancel,
                            color: YouScribeColors.whiteColor,
                            fontSize: iconSize,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(AppLocalizations.of(context)!.premiumMessageTitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            overflow: TextOverflow.clip,
                            fontWeight: FontWeight.w600,
                            color: YouScribeColors.whiteColor)),
                    const SizedBox(height: 15),
                    premiumMessageAdvantageitemView(
                        context,
                        AppLocalizations.of(context)!.premiumMessageAdvantage1,
                        iconSize),
                    const SizedBox(height: 7),
                    premiumMessageAdvantageitemView(
                        context,
                        AppLocalizations.of(context)!.premiumMessageAdvantage2,
                        iconSize),
                    const SizedBox(height: 7),
                    premiumMessageAdvantageitemView(
                        context,
                        AppLocalizations.of(context)!.premiumMessageAdvantage3,
                        iconSize),
                    const SizedBox(height: 7),
                    premiumMessageAdvantageitemView(
                        context,
                        AppLocalizations.of(context)!.premiumMessageAdvantage4,
                        iconSize),
                    const SizedBox(height: 7),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static Future<void> displaySimpleAlert(
      {required BuildContext context,
      required String message,
      required String title}) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: Text(title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(overflow: TextOverflow.clip)),
            content: Text(message,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(overflow: TextOverflow.clip)),
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                      child: Text(AppLocalizations.of(context)!.ok,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium)),
                ),
              )
            ],
          );
        });
  }

  static Future<void> displayRequestSyncAlert({
    required BuildContext context,
    required Function sync,
  }) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            surfaceTintColor: YouScribeColors.whiteColor,
            contentPadding: const EdgeInsets.all(15),
            actionsPadding: const EdgeInsets.all(8),
            insetPadding:
                Platform.isAndroid ? const EdgeInsets.all(20) : EdgeInsets.zero,
            title: Text(AppLocalizations.of(context)!.sync,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    overflow: TextOverflow.clip, fontWeight: FontWeight.w600)),
            content: Text(AppLocalizations.of(context)!.syncMessage,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(overflow: TextOverflow.clip)),
            actions: <Widget>[
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(AppLocalizations.of(context)!.cancel,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Platform.isAndroid
                              ? YouScribeColors.accentColor
                              : null,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  await sync();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(AppLocalizations.of(context)!.ok,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Platform.isAndroid
                              ? YouScribeColors.accentColor
                              : null,
                          fontWeight: FontWeight.w600)),
                ),
              )
            ],
          );
        });
  }

  static Future<void> showErrorMessageAndRequestReportAlert(
      {required BuildContext context,
      required String title,
      required String message}) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: Text(title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: YouScribeColors.blackColor,
                    fontWeight: FontWeight.w600)),
            content: Text(
                "$message\n ${AppLocalizations.of(context)!.errorReportAdditionalMessage}",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(overflow: TextOverflow.clip)),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Center(
                      child: Text(AppLocalizations.of(context)!.cancel,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Platform.isAndroid
                                      ? YouScribeColors.accentColor
                                      : YouScribeColors.facebookColor,
                                  fontWeight: FontWeight.w600))),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  final currentUser =
                      await AuthenticationManager.getCurrentUser();

                  final state = await ServiceImpl()
                      .showErrorMessageAndRequestReport(
                          title: title,
                          message: message,
                          supportEmailHeader: context.mounted
                              ? AppLocalizations.of(context)!
                                  .supportRequestEmailHeader(
                                      currentUser.isNotNull
                                          ? currentUser!.email!
                                          : 'Not authenticated',
                                      currentUser.isNotNull
                                          ? currentUser!.id!.toString()
                                          : 'Not authenticated')
                              : '');

                  if (!state) {
                    if (context.mounted) {
                      await displayGeneralAPIErrorAlert(context: context);
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                      child: Text(
                          AppLocalizations.of(context)!.shouldReportError,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Platform.isAndroid
                                      ? YouScribeColors.accentColor
                                      : YouScribeColors.facebookColor,
                                  fontWeight: FontWeight.w600))),
                ),
              )
            ],
          );
        });
  }

  static Future<void> displayChooseSelectionAlert(
      {required BuildContext context,
      required List<SimpleLibraryEntity> selections,
      required Function(SimpleLibraryEntity) onAdd}) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            surfaceTintColor: YouScribeColors.whiteColor,
            shape: const RoundedRectangleBorder(),
            insetPadding:
                Platform.isAndroid ? const EdgeInsets.all(20) : EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.all(15),
            actionsPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            title: Text(AppLocalizations.of(context)!.choseSelection,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    overflow: TextOverflow.clip, fontWeight: FontWeight.w600)),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...List.generate(selections.length, (index) {
                    return Material(
                      color: Colors.transparent,
                      child: Ink(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);

                            onAdd(selections[index]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: Text("- ${selections[index].label}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(overflow: TextOverflow.clip)),
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(AppLocalizations.of(context)!.cancel,
                      textAlign: Platform.isIOS ? TextAlign.center : null,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Platform.isAndroid
                                ? YouScribeColors.accentColor
                                : null,
                          )),
                ),
              )
            ],
          );
        });
  }

  static Future<void> displayOnlyOneSelectionAlert({
    required BuildContext context,
    required Function onCreate,
    required Function onAdded,
  }) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            shape: const RoundedRectangleBorder(),
            surfaceTintColor: YouScribeColors.whiteColor,
            contentPadding: const EdgeInsets.all(15),
            insetPadding:
                Platform.isAndroid ? const EdgeInsets.all(20) : EdgeInsets.zero,
            actionsPadding: const EdgeInsets.all(8),
            content: Text(AppLocalizations.of(context)!.createSelectionRequest,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    overflow: TextOverflow.clip,
                    fontSize: WidgetStyles.subBodySize)),
            actions: <Widget>[
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  await onCreate();
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                  child: Text(AppLocalizations.of(context)!.createSelection,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: YouScribeColors.accentColor,
                          fontWeight: FontWeight.w500)),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  await onAdded();
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Text(AppLocalizations.of(context)!.addOption,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: YouScribeColors.accentColor,
                          fontWeight: FontWeight.w500)),
                ),
              )
            ],
          );
        });
  }

  static Future<void> displayEmptySelectionAlert({
    required BuildContext context,
    required Function onAdd,
  }) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            shape: const RoundedRectangleBorder(),
            surfaceTintColor: YouScribeColors.whiteColor,
            contentPadding: const EdgeInsets.all(15),
            insetPadding:
                Platform.isAndroid ? const EdgeInsets.all(20) : EdgeInsets.zero,
            actionsPadding: const EdgeInsets.all(8),
            content: Text(
                AppLocalizations.of(context)!.youDonotHaveAnySelection,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    overflow: TextOverflow.clip,
                    fontSize: WidgetStyles.subBodySize)),
            actions: <Widget>[
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  await onAdd();
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                  child: Text(AppLocalizations.of(context)!.letsGo,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Platform.isAndroid
                              ? YouScribeColors.accentColor
                              : null,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                  child: Text(AppLocalizations.of(context)!.cancel,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Platform.isAndroid
                              ? YouScribeColors.accentColor
                              : null,
                          fontWeight: FontWeight.w600)),
                ),
              )
            ],
          );
        });
  }

  static Future<void> displayRemoveFavoriteAlert(
      {required BuildContext context,
      required String productName,
      required void Function() confirm}) async {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog.adaptive(
            shape: const RoundedRectangleBorder(),
            surfaceTintColor: YouScribeColors.whiteColor,
            contentPadding: const EdgeInsets.all(10),
            titlePadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            insetPadding:
                Platform.isAndroid ? const EdgeInsets.all(20) : EdgeInsets.zero,
            actionsPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            elevation: 0,
            title: Text(AppLocalizations.of(context)!.removeOfflineTitle,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    overflow: TextOverflow.clip,
                    fontSize: WidgetStyles.title3Size,
                    fontWeight: FontWeight.w600)),
            content: Text(
                AppLocalizations.of(context)!
                    .removeFavoriteMessage(productName),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    overflow: TextOverflow.clip,
                    fontSize: WidgetStyles.subBodySize)),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(AppLocalizations.of(context)!.cancel,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Platform.isAndroid
                              ? YouScribeColors.accentColor
                              : null,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  confirm();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(AppLocalizations.of(context)!.ok,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Platform.isAndroid
                              ? YouScribeColors.accentColor
                              : null,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: 4),
            ],
          );
        });
  }

  static Future<void> displayDownloadBookWarningAlert(
      {required BuildContext context,
      required String title,
      required String message,
      required void Function() confirm}) async {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog.adaptive(
            shape: const RoundedRectangleBorder(),
            surfaceTintColor: YouScribeColors.whiteColor,
            contentPadding: const EdgeInsets.all(10),
            titlePadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            insetPadding:
                Platform.isAndroid ? const EdgeInsets.all(20) : EdgeInsets.zero,
            actionsPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            elevation: 0,
            title: Text(title,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    overflow: TextOverflow.clip,
                    fontSize: WidgetStyles.title3Size,
                    fontWeight: FontWeight.w600)),
            content: Text(message,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    overflow: TextOverflow.clip,
                    fontSize: WidgetStyles.subBodySize)),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(AppLocalizations.of(context)!.cancel,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Platform.isAndroid
                              ? YouScribeColors.accentColor
                              : null,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  confirm();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(AppLocalizations.of(context)!.ok,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Platform.isAndroid
                              ? YouScribeColors.accentColor
                              : null,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              if (Platform.isAndroid) const SizedBox(width: 4),
            ],
          );
        });
  }

  static void showSliderDialog({
    required BuildContext context,
    required String title,
    required int divisions,
    required double min,
    required double max,
    required double value,
    required Stream<double> stream,
    required ValueChanged<double> onChanged,
    bool multiplyBy100 = false,
    String valueSuffix = '',
  }) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, textAlign: TextAlign.center),
        content: StreamBuilder<double>(
          stream: stream,
          builder: (context, snapshot) => SizedBox(
            height: 100,
            child: Column(
              children: [
                Text(
                    // ignore: lines_longer_than_80_chars
                    '${multiplyBy100 ? (100 * (snapshot.data ?? 0)).toStringAsFixed(0) : (snapshot.data ?? 0).toStringAsFixed(1)}$valueSuffix',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24)),
                SliderTheme(
                  data: const SliderThemeData(
                    inactiveTrackColor: YouScribeColors.secondaryTextColor,
                    activeTrackColor: YouScribeColors.primaryAppColor,
                    thumbColor: YouScribeColors.accentColor,
                  ),
                  child: Slider(
                    divisions: divisions,
                    min: min,
                    max: max,
                    value: snapshot.data ?? value,
                    onChanged: onChanged,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> displaySmsSubscriptionAlert(
      {required BuildContext context,
      // ignore: inference_failure_on_function_return_type
      required Function(String phoneNumber, String message) redirectToSMSApp,
      required CountryConfigPopupEntity config}) async {
    await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
              contentPadding: EdgeInsets.zero,
              insetPadding: Platform.isAndroid
                  ? const EdgeInsets.all(20)
                  : EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Platform.isIOS ? 10 : 0),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: Container(
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(Platform.isIOS ? 10 : 0),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          config.title!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  overflow: TextOverflow.clip,
                                  fontSize: WidgetStyles.title1Size),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            config.topText!.join("\n"),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    overflow: TextOverflow.clip,
                                    fontSize: WidgetStyles.title3Size - 2),
                          ),
                        ),
                        Column(
                          children: [
                            ...List.generate(config.buttons!.length, (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      displayCustomAlert(
                                          isOneButton: true,
                                          content: AppLocalizations.of(context)!
                                              .smsSubscriptionEndMessage,
                                          context: context);
                                      redirectToSMSApp(
                                          config
                                              .buttons![index].smsPhoneNumber!,
                                          config.buttons![index].smsCode!);
                                    },
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        )),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          YouScribeColors.primaryAppColor,
                                        ),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                          YouScribeColors.whiteColor,
                                        )),
                                    child: Text(
                                      config.buttons![index].text!
                                          .toUpperCase(),
                                    )),
                              );
                            }),
                          ],
                        ),
                        Text(
                          config.bottomText!.join("\n"),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  overflow: TextOverflow.clip,
                                  fontSize: WidgetStyles.subBodySize),
                        ),
                        const SizedBox(height: 10)
                      ],
                    )),
              ),
            ));
  }

  static Future<void> showStarRateDialog(BuildContext context) {
    return rateMyApp.showRateDialog(
      context,
      barrierDismissible: false,
      title: AppLocalizations.of(context)!.requestRatings,
      message: AppLocalizations.of(context)!.requestRatingsMessage,
      rateButton: 'RATE',
      laterButton: 'MAYBE LATER',
      listener: (button) {
        switch (button) {
          case RateMyAppDialogButton.rate:
            AnalyticsTracker.instance.trackRatingRequestAccepted();
            rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
          case RateMyAppDialogButton.later:
            AnalyticsTracker.instance.trackRatingRequestDeclined();
          case RateMyAppDialogButton.no:
            AnalyticsTracker.instance.trackRatingRequestDeclined();
        }

        return true;
      },
      actionsBuilder: (context) => [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Ink(
                child: InkWell(
              onTap: () async {
                await AnalyticsTracker.instance.trackRatingRequestDeclined();
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  AppLocalizations.of(context)!.notNow.toUpperCase(),
                  style: const TextStyle(
                    color: YouScribeColors.accentColor,
                  ),
                ),
              ),
            )),
            Ink(
                child: InkWell(
              onTap: () async {
                Navigator.pop(context);
                await AnalyticsTracker.instance.trackRatingRequestAccepted();
                await rateMyApp.launchStore();
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  AppLocalizations.of(context)!.letsGo.toUpperCase(),
                  style: const TextStyle(
                    color: YouScribeColors.accentColor,
                  ),
                ),
              ),
            )),
          ],
        ),
      ],
      ignoreNativeDialog: false,
      dialogStyle: DialogStyle(
        titleStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w600, fontSize: WidgetStyles.title2Size),
        titlePadding: const EdgeInsets.all(3),
        messagePadding: const EdgeInsets.all(3),
        messageStyle: const TextStyle(overflow: TextOverflow.clip),
      ),
      onDismissed: () =>
          rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
    );
  }

  static Future<void> displayNotificationsAlert(
      {required BuildContext context,
      // ignore: inference_failure_on_function_return_type
      required Function(BuildContext, NotificationOption)
          openNotification}) async {
    return showDialog(
        context: context,
        builder: (subContext) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            insetPadding: const EdgeInsets.all(20),
            shape: const RoundedRectangleBorder(),
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: Container(
              height: 220,
              width: MediaQuery.of(context).size.width - 30,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                        AppLocalizations.of(context)!.followActionSheetTitle,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            overflow: TextOverflow.clip,
                            fontSize: WidgetStyles.title3Size,
                            fontWeight: FontWeight.w600)),
                  ),
                  Material(
                    child: Ink(
                      child: InkWell(
                        onTap: () {
                          openNotification(
                              context, NotificationOption.authorsOption);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 13),
                          child: Text(
                              AppLocalizations.of(context)!
                                  .authorNotificationOption,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(overflow: TextOverflow.clip)),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    child: Ink(
                      child: InkWell(
                        onTap: () {
                          openNotification(
                              context, NotificationOption.editorsOption);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 13),
                          child: Text(
                              AppLocalizations.of(context)!
                                  .editorsNotificationOption,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(overflow: TextOverflow.clip)),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    child: Ink(
                      child: InkWell(
                        onTap: () {
                          openNotification(
                              context, NotificationOption.themesOption);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 13),
                          child: Text(
                              AppLocalizations.of(context)!
                                  .subThemeNotificationsOption,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(overflow: TextOverflow.clip)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(subContext);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(AppLocalizations.of(context)!.cancel,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: YouScribeColors.accentColor,
                                      fontWeight: FontWeight.w500)),
                        ),
                      ),
                      const SizedBox(width: 4),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  static Future<void> displayInAppSubscriptionAlert(
      {required BuildContext context,
      required Function termsOfServices,
      required Function termsPrivacyPolicy,
      required Function cancel,
      required Future<bool> Function() startFreeTrial,
      // ignore: inference_failure_on_function_return_type
      required Function(String phoneNumber, String message) redirectToSMSApp,
      required String price,
      required bool isBusy}) async {
    await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (childContext) => AlertDialog(
              contentPadding: EdgeInsets.zero,
              insetPadding: Platform.isAndroid
                  ? const EdgeInsets.all(20)
                  : EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Platform.isIOS ? 10 : 0),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: Container(
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Platform.isIOS ? 10 : 0),
                ),
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200.withOpacity(0.7),
                        borderRadius:
                            BorderRadius.circular(Platform.isIOS ? 10 : 0),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .inAppPurchaseTitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: YouScribeColors.accentColor,
                                        overflow: TextOverflow.clip,
                                        fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 10),
                              RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .inAppPurchaseInfoFirstSentence,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                overflow: TextOverflow.clip,
                                                color: YouScribeColors
                                                    .blackColor)),
                                    TextSpan(
                                        text: """
                                   $price${AppLocalizations.of(context)!.perMonth}\r\n""",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                overflow: TextOverflow.clip,
                                                fontWeight: FontWeight.w800,
                                                color: YouScribeColors
                                                    .blackColor)),
                                    TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .inAppPurchaseInfoPart2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                overflow: TextOverflow.clip,
                                                height: 1.4,
                                                fontSize:
                                                    WidgetStyles.caption1Size,
                                                color: YouScribeColors
                                                    .blackColor)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () => termsOfServices(),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .inAppPurchaseTermsOfService,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          decorationColor: Colors.blue,
                                          decoration: TextDecoration.underline,
                                          overflow: TextOverflow.clip,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue),
                                ),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () => termsPrivacyPolicy(),
                                child: Text(
                                  AppLocalizations.of(context)!.privacyPolicy,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          decorationColor: Colors.blue,
                                          overflow: TextOverflow.clip,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: ElevatedButton(
                                          onPressed: !isBusy
                                              ? () {
                                                  Navigator.pop(childContext);
                                                  cancel();
                                                }
                                              : null,
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              )),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                YouScribeColors.primaryAppColor,
                                              ),
                                              foregroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                YouScribeColors.whiteColor,
                                              )),
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .cancel,
                                              style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: YouScribeColors
                                                      .whiteColor))),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: ElevatedButton(
                                          onPressed: !isBusy
                                              ? () async {
                                                  Navigator.pop(childContext);
                                                  final result =
                                                      await startFreeTrial();

                                                  if (result) {
                                                    unawaited(Provider.of<
                                                                YouScribePremium>(
                                                            // ignore: use_build_context_synchronously
                                                            context,
                                                            listen: false)
                                                        .changepPremiunState());
                                                  }
                                                }
                                              : null,
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              )),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                YouScribeColors.primaryAppColor,
                                              ),
                                              foregroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                YouScribeColors.whiteColor,
                                              )),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .startFreeTrial,
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color:
                                                    YouScribeColors.whiteColor),
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ),
            ));
  }

  static Future<bool> displayBackAlert({
    required BuildContext context,
    required String content,
    String? leftButtonText,
    String? rightButtonText,
  }) async {
    final bool? state = await showDialog<bool>(
        context: context,
        builder: (context) {
          return Platform.isAndroid
              ? AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  insetPadding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  content: Container(
                    width: MediaQuery.of(context).size.width - 30,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Flexible(
                            child: Text(content,
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(overflow: TextOverflow.clip)),
                          ),
                          // const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 8),
                                    child: Center(
                                      child: Text(
                                          leftButtonText ??
                                              AppLocalizations.of(context)!.ok,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: YouScribeColors
                                                      .primaryAppColor)),
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 32, vertical: 8),
                                    child: Center(
                                        child: Text(
                                            rightButtonText ??
                                                AppLocalizations.of(context)!
                                                    .cancel,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: YouScribeColors
                                                        .primaryAppColor))),
                                  ),
                                ),
                              )
                            ],
                          )
                        ]),
                  ),
                )
              : AlertDialog.adaptive(
                  content: Text(content,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(overflow: TextOverflow.clip)),
                  actions: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                            child: Text(AppLocalizations.of(context)!.yes,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, false);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                            child: Text(AppLocalizations.of(context)!.cancel,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium)),
                      ),
                    )
                  ],
                );
        });

    return state ?? false;
  }

  static Future<PremiumSuggestionsResult> displayPremiumSuggestion(
      {required BuildContext context, int? productId}) async {
    final PremiumSuggestionsResult? state =
        await showDialog<PremiumSuggestionsResult>(
      context: context,
      builder: (context) {
        return BlocProvider<PremiumSuggestionBloc>.value(
          value: PremiumSuggestionBloc()
            ..add(InitPremiumSuggestionEvent(productId ?? 0)),
          child: PremiumSuggestionScreen(
            productId: productId!,
          ),
        );
      },
    );
    return state ?? PremiumSuggestionsResult.noResult;
  }

  static Future<void> displayExtractionWaittingAlert(
      {required BuildContext context}) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog.adaptive(
              shape: const RoundedRectangleBorder(),
              surfaceTintColor: YouScribeColors.whiteColor,
              contentPadding: const EdgeInsets.all(10),
              titlePadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              insetPadding: Platform.isAndroid
                  ? const EdgeInsets.all(20)
                  : EdgeInsets.zero,
              actionsPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              elevation: 0,
              content: Row(
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        YouScribeColors.primaryAppColor),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                        AppLocalizations.of(context)!.extractDocumentMsg,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            overflow: TextOverflow.clip,
                            fontSize: WidgetStyles.subBodySize)),
                  ),
                ],
              ));
        });
  }
}
