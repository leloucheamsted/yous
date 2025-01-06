import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wyatt_bloc_helper/wyatt_bloc_helper.dart';
import 'package:youscribe/core/extensions/build_context_extension.dart';
import 'package:youscribe/presentation/blocs/auth/forgot_password/forgot_password_cubit.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/styles/youscribe_theme.dart';

class ForgotPasswordScreen
    extends CubitScreen<ForgotPasswordCubit, ForgotPasswordState> {
  const ForgotPasswordScreen({super.key});

  @override
  Future<void> onListen(BuildContext context, ForgotPasswordState state) async {
    if (state is ForgotPasswordSuccess) {
      await Dialogs.displaySimpleAlert(
          context: context,
          title: AppLocalizations.of(context)!.forgotPasswordSentTitle,
          message: AppLocalizations.of(context)!.forgotPasswordSentMessage);
      if (context.mounted) {
        Navigator.pop(context);
      }
    } else if (state is ForgotPasswordError) {
      debugPrint('Error ! ${state.message}');
      if (state.errorType == ForgotPasswordErrorType.noInternetConnection) {
        await Dialogs.displayInternetNeededAlert(context: context);
        return;
      }
      if (state.errorType == ForgotPasswordErrorType.apiError) {
        await Dialogs.displayGeneralAPIErrorAlert(context: context);
        return;
      }
      if (state.errorType == ForgotPasswordErrorType.emailNotFound) {
        await Dialogs.displaySimpleAlert(
            context: context,
            title: AppLocalizations.of(context)!.emailNotFoundTitle,
            message: AppLocalizations.of(context)!.emailNotFoundMessage);
        return;
      }
      if (state.errorType == ForgotPasswordErrorType.unknown) {
        await context.showErrorSnackBar(
          AppLocalizations.of(context)!.unknownErrorOccuredGeneralDescription,
        );
      }
    }
  }

  @override
  ForgotPasswordCubit create(BuildContext context) {
    return ForgotPasswordCubit();
  }

  @override
  Widget parent(BuildContext context, Widget child) => Scaffold(
        appBar: AppBar(
            title: Image(
                height: 35,
                image: AssetImage(Provider.of<YouScribeTheme>(context).brand))),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: child,
        ),
      );
  @override
  Widget onBuild(BuildContext context, ForgotPasswordState state) {
    return ForgotPasswordScreenContent(
      state: state,
      cubit: bloc(context),
    );
  }
}

class ForgotPasswordScreenContent extends StatefulWidget {
  const ForgotPasswordScreenContent(
      {required this.state, required this.cubit, super.key});
  final ForgotPasswordState state;
  final ForgotPasswordCubit cubit;
  @override
  State<ForgotPasswordScreenContent> createState() =>
      _ForgotPasswordScreenContentState();
}

class _ForgotPasswordScreenContentState
    extends State<ForgotPasswordScreenContent> {
  final TextEditingController _userNameTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(AppLocalizations.of(context)!.reinitializePassword,
              textAlign: TextAlign.center,
              style: WidgetStyles.textStyle.copyWith(
                fontSize: WidgetStyles.title3Size,
              )),
          const SizedBox(
            height: 20,
          ),
          Text(AppLocalizations.of(context)!.reinitializePasswordDescription,
              textAlign: TextAlign.center,
              style: WidgetStyles.textStyle.copyWith(
                  fontSize: WidgetStyles.caption1Size,
                  overflow: TextOverflow.clip)),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                setState(() {});
              },
              decoration: WidgetStyles.textFieldInputDecoration
                  .copyWith(hintText: AppLocalizations.of(context)!.username),
              controller: _userNameTextEditingController,
            ),
          ),
          SizedBox(
              child: _userNameTextEditingController.text.isNotEmpty &&
                      !isEmail(_userNameTextEditingController.text)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 2),
                      child: Text(
                        AppLocalizations.of(context)!.badEmailFormatMessage,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: YouScribeColors.errorColor),
                      ),
                    )
                  : null),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              width: 300,
              child: ElevatedButton(
                style: WidgetStyles.buttonStyle,
                onPressed: _userNameTextEditingController.text.isNotEmpty &&
                        isEmail(_userNameTextEditingController.text)
                    ? () async {
                        await widget.cubit.resetPassword(
                            _userNameTextEditingController.text.trim());
                      }
                    : null,
                child: switch (widget.state) {
                  ForgotPasswordLoading() => const Center(
                        child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: YouScribeColors.accentColor,
                    )),
                  _ => Text(AppLocalizations.of(context)!.validate,
                      style: WidgetStyles.textStyle.copyWith(
                        color: YouScribeColors.whiteColor,
                      )),
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isEmail(String em) {
    const String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    final RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }
}
