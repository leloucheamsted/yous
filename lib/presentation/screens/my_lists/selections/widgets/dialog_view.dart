// ignore_for_file: inference_failure_on_function_return_type

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youscribe/core/entities/simple_library_entity.dart';
import 'package:youscribe/presentation/screens/my_lists/selections/widgets/create_selection_dialog.dart';

class MySelectionDialogView {
  static Future<dynamic> addSelection(
      {required BuildContext context,
      SimpleLibraryEntity? selection,
      Function(SimpleLibraryEntity)? onUpdate,
      Function(String name, bool isPublic)? onCreate}) async {
    // ignore: inference_failure_on_function_invocation
    final dialog = await showDialog(
        context: context,
        builder: (context) {
          return CreateSelectionDialog(
              selection: selection, onUpdate: onUpdate, onCreate: onCreate);
        });

    return dialog;
  }

  static Future<bool> deleteSelectionAlert({
    required BuildContext context,
  }) async {
    bool state = false;
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            content: Text(
                AppLocalizations.of(context)!.deleteSelectionGuardMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(overflow: TextOverflow.clip)),
            actions: <Widget>[
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    state = false;
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                        child: Text(AppLocalizations.of(context)!.cancel,
                            style: Theme.of(context).textTheme.bodyMedium)),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    state = true;
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                        child: Text(AppLocalizations.of(context)!.ok,
                            style: Theme.of(context).textTheme.bodyMedium)),
                  ),
                ),
              )
            ],
          );
        });

    return state;
  }

  static Future<bool> deleteSelectionProductAlert({
    required BuildContext context,
  }) async {
    bool state = false;
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            content: Text(
                AppLocalizations.of(context)!.removeProductFromSelectionsGuard,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(overflow: TextOverflow.clip)),
            actions: <Widget>[
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    state = false;
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                        child: Text(AppLocalizations.of(context)!.cancel,
                            style: Theme.of(context).textTheme.bodyMedium)),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    state = true;
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                        child: Text(AppLocalizations.of(context)!.ok,
                            style: Theme.of(context).textTheme.bodyMedium)),
                  ),
                ),
              )
            ],
          );
        });

    return state;
  }
}
