import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class RecommandationDialog<T> extends Page<T> {
  const RecommandationDialog({
    this.anchorPoint,
    this.barrierColor = Colors.black54,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.useSafeArea = true,
    this.themes,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });
  final Offset? anchorPoint;
  final Color? barrierColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final bool useSafeArea;
  final CapturedThemes? themes;

  @override
  Route<T> createRoute(BuildContext context) => DialogRoute<T>(
        context: context,
        settings: this,
        builder: (context) {
          if (Platform.isIOS) {
            return AlertDialog.adaptive(
                contentPadding: EdgeInsets.zero,
                insetPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                // backgroundColor: Colors.transparent,
                elevation: 0,
                content: Text(
                    AppLocalizations.of(context)!.inActiveSessionAlertTitle,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        overflow: TextOverflow.clip,
                        fontWeight: FontWeight.w600)),
                actions: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context, true);
                        context.pushNamed(Routes.suggestions);
                      },
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: Center(
                              child: Text(
                                  AppLocalizations.of(context)!
                                      .inActiveSessionCTA,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: YouScribeColors
                                              .primaryAppColor)))),
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
                              horizontal: 20, vertical: 8),
                          child: Center(
                              child: Text(
                                  AppLocalizations.of(context)!.noThanks,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: YouScribeColors
                                              .primaryAppColor)))),
                    ),
                  )
                ]);
          }
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                width: MediaQuery.of(context).size.width - 30,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          AppLocalizations.of(context)!
                              .inActiveSessionAlertTitle,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  overflow: TextOverflow.clip,
                                  fontWeight: FontWeight.w600)),
                      const SizedBox(height: 10),
                      Text(
                          AppLocalizations.of(context)!
                              .inActiveSessionAlertDescription,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(overflow: TextOverflow.clip)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context, true);
                                context.pushNamed(Routes.suggestions);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: Center(
                                  child: Text(
                                      AppLocalizations.of(context)!
                                          .inActiveSessionCTA,
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
                                    horizontal: 8, vertical: 8),
                                child: Center(
                                    child: Text(
                                        AppLocalizations.of(context)!.noThanks,
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
                    ],
                  ),
                )),
          );
        },
        anchorPoint: anchorPoint,
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
        barrierLabel: barrierLabel,
        useSafeArea: useSafeArea,
        themes: themes,
      );
}
