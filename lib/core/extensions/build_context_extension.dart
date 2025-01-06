import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

typedef Callback<R> = R Function();

extension BuildContextExtension on BuildContext {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 4),
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    int maxLines = 4,
  }) {
    return ScaffoldMessenger.maybeOf(this)?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: textColor),
        ),
        duration: duration,
        backgroundColor: backgroundColor,
      ),
    );
  }

  void hideSnackBar() {
    ScaffoldMessenger.maybeOf(this)?.hideCurrentSnackBar();
  }

  Future<T?> showAlert<T>({
    required String title,
    required String content,
    List<Widget> Function(BuildContext context)? actionsBuilder,
  }) {
    final theme = Theme.of(this);

    return showDialog<T>(
      context: this,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge!.copyWith(
              overflow: TextOverflow.clip,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Text(
            content,
            style: theme.textTheme.bodyMedium!.copyWith(
              overflow: TextOverflow.clip,
            ),
          ),
          actions: actionsBuilder?.call(context) ?? [],
        );
      },
    );
  }

  Future<T?> showOkAlert<T>({
    required String title,
    required String content,
    Callback<T>? onOkPressed,
    String? okText,
  }) {
    final localizations = AppLocalizations.of(this)!;
    final theme = Theme.of(this);

    return showAlert(
      title: title,
      content: content,
      actionsBuilder: (context) => [
        TextButton(
          onPressed: () {
            final value = onOkPressed?.call();
            Navigator.of(context).pop(value);
          },
          child: Text(
            okText ?? localizations.ok,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Future<T?> showYesNoAlert<T>({
    required String title,
    required String content,
    Callback<T>? onYesPressed,
    Callback<T>? onNoPressed,
    String? yesText,
    String? noText,
  }) {
    final localizations = AppLocalizations.of(this)!;
    final theme = Theme.of(this);

    return showAlert(
      title: title,
      content: content,
      actionsBuilder: (context) => [
        TextButton(
          onPressed: () {
            final value = onNoPressed?.call();
            Navigator.of(context).pop(value);
          },
          child: Text(
            noText ?? localizations.cancel,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        ),
        TextButton(
          onPressed: () {
            final value = onYesPressed?.call();
            Navigator.of(context).pop(value);
          },
          child: Text(
            yesText ?? localizations.yes,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Future<void> showAuthNetworkErrorAlert() async {
    final localizations = AppLocalizations.of(this)!;

    return showOkAlert<void>(
      title: localizations.internetRequiredTitle,
      content: localizations.authNetworkError,
    );
  }

  Future<void> showAuthFacebookErrorAlert() async {
    final localizations = AppLocalizations.of(this)!;

    return showOkAlert<void>(
      title: '',
      content: localizations.authFacebookError,
    );
  }

  Future<void> showAuthGarErrorAlert() async {
    final localizations = AppLocalizations.of(this)!;

    return showOkAlert<void>(
      title: '',
      content: localizations.authGarError,
    );
  }

  Future<void> showErrorSnackBar(String message) async {
    hideSnackBar();
    showSnackBar(
      message,
      backgroundColor: YouScribeColors.errorColor,
    );
  }
}
