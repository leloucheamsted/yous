import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class AuthentificationDialogView {
  static Future<bool> contactUsAlert({
    required BuildContext context,
  }) async {
    bool state = false;
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: Text(AppLocalizations.of(context)!.contactUs,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: YouScribeColors.blackColor,
                    fontWeight: FontWeight.w600)),
            content: Text(
                AppLocalizations.of(context)!.errorReportAdditionalMessage,
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
                    state = false;
                    Navigator.pop(context);
                  },
                  child: Center(
                      child: Text(AppLocalizations.of(context)!.cancel,
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
                onTap: () {
                  state = true;
                  Navigator.pop(context);
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

    return state;
  }
}
