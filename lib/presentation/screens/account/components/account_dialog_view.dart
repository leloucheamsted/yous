import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountDialoView {
  static Future<bool> logoutAlert({
    required BuildContext context,
  }) async {
    bool state = false;
    // ignore: inference_failure_on_function_invocation
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            content: Text(AppLocalizations.of(context)!.logOutAlterMsg,
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
                          style: Theme.of(context).textTheme.bodyMedium)),
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
                      child: Text(AppLocalizations.of(context)!.confirm,
                          style: Theme.of(context).textTheme.bodyMedium)),
                ),
              )
            ],
          );
        });

    return state;
  }

  static Future<bool?> ratingAppAlert({required BuildContext context}) async {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            content: Text(AppLocalizations.of(context)!.requestRatings,
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
                    Navigator.pop(context, true);
                  },
                  child: Center(
                      child: Text(AppLocalizations.of(context)!.letsGo,
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
                      child: Text(AppLocalizations.of(context)!.notNow,
                          style: Theme.of(context).textTheme.bodyMedium)),
                ),
              )
            ],
          );
        });
  }

  static Future<bool> deleteAccountAlert(
      {required BuildContext context}) async {
    final bool? state = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
              contentPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              // backgroundColor: Colors.transparent,
              elevation: 0,
              content: Text(
                AppLocalizations.of(context)!.accountDeletionHaltMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(overflow: TextOverflow.clip),
              ),
              actions: [
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
                            child: Text(AppLocalizations.of(context)!.cancel,
                                style:
                                    Theme.of(context).textTheme.bodyMedium))),
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
                            child: Text(AppLocalizations.of(context)!.ok,
                                style:
                                    Theme.of(context).textTheme.bodyMedium))),
                  ),
                )
              ]);
        });
    return state!;
  }
}
