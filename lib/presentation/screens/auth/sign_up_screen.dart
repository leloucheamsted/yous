// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wyatt_bloc_helper/wyatt_bloc_helper.dart';
import 'package:youscribe/core/entities/sign_up_with_email_entity.dart';
import 'package:youscribe/core/extensions/build_context_extension.dart';
import 'package:youscribe/presentation/blocs/auth/signup/sign_up_cubit.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/styles/youscribe_theme.dart';
import 'package:youscribe/utilities/constants.dart';

class SignUpScreen extends CubitScreen<SignUpCubit, SignUpState> {
  const SignUpScreen({super.key});

  @override
  Future<void> onListen(BuildContext context, SignUpState state) async {
    if (state is SignUpSuccess) {
      // ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(
      //     backgroundColor: Colors.green,
      //     content: Text(AppLocalizations.of(context)!.accountCreated)));
    } else if (state is SignUpError) {
      if (state.errorType == SignupErrorType.noInternetConnection) {
        await context.showAuthNetworkErrorAlert();
        return;
      }

      if (state.errorType == SignupErrorType.verifyEmailAddress) {
        await context.showErrorSnackBar(
          AppLocalizations.of(context)!.authBadEmailFormatError,
        );
      } else if (state.errorType == SignupErrorType.accountAlreadyExists) {
        await context.showErrorSnackBar(
          AppLocalizations.of(context)!.authAccountAlreadyExistsError,
        );
      } else {
        await context.showErrorSnackBar(
          AppLocalizations.of(context)!.authUnknownError,
        );
      }
    }
  }

  @override
  SignUpCubit create(BuildContext context) => SignUpCubit()..init();

  @override
  Widget parent(BuildContext context, Widget child) => Scaffold(
        appBar: AppBar(
            title: Image(
                height: 35,
                image: Provider.of<YouScribeTheme>(context).isDarkMode
                    ? const AssetImage(ImagesName.appLogoDark)
                    : const AssetImage(ImagesName.appLogoWhite))),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: child,
        ),
      );

  @override
  Widget onBuild(BuildContext context, SignUpState state) =>
      SignupScreenContent(
        state: state,
        cubit: bloc(context),
      );
}

class SignupScreenContent extends StatefulWidget {
  const SignupScreenContent(
      {required this.state, required this.cubit, super.key});

  final SignUpState state;
  final SignUpCubit cubit;

  @override
  State<SignupScreenContent> createState() => _SignupScreenContentState();
}

class _SignupScreenContentState extends State<SignupScreenContent> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _giftCodeEditingController =
      TextEditingController();
  final ExpansionTileController _expansionTileController =
      ExpansionTileController();
  bool _buttonEnabled = false;

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _giftCodeEditingController.dispose();
    super.dispose();
  }

  bool _isEmailValid(String email) {
    return RegExp(r"^[\w-\.\+]+@([\w-]+\.)+[\w-]+$").hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.state is SignUpInitial) {
      if ((widget.state as SignUpInitial).isGiftCodeViewExpanded) {
        _expansionTileController.expand();
      }
    } else if (widget.state is SignUpLoading) {
      _buttonEnabled = false;
    } else {
      _buttonEnabled = _emailTextEditingController.text.isNotEmpty &&
          _isEmailValid(_emailTextEditingController.text);
    }

    return Column(
      children: [
        //TODO: Facebook login button here:,
        // Apple login button here:,
        //canal+ login button here:
        // ElevatedButton(
        //   onPressed: () {
        //     bloc(context).loginWithCanalPlus();
        //   },
        //   child: const Text('Login with Canal Plus'),
        // ),
        const SizedBox(
          height: 10,
        ),

        Text(AppLocalizations.of(context)!.withCredentials,
            style: WidgetStyles.textStyle.copyWith(
              fontSize: WidgetStyles.title2Size,
            )),

        const SizedBox(
          height: 20,
        ),

        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _buttonEnabled = value.isNotEmpty && _isEmailValid(value);
              });
            },
            decoration: WidgetStyles.textFieldInputDecoration
                .copyWith(hintText: AppLocalizations.of(context)!.email),
            enabled: widget.state is! SignUpLoading,
            controller: _emailTextEditingController,
            keyboardType: TextInputType.emailAddress,
          ),
        ),

        const SizedBox(
          height: 30,
        ),

        if (widget.state is SignUpInitial) ...[
          if ((widget.state as SignUpInitial).isGiftCodeViewVisible)
            Padding(
              padding: const EdgeInsets.only(left: 2, right: 2),
              child: ExpansionTile(
                controller: _expansionTileController,
                title: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.useGiftCode,
                      style: const TextStyle(overflow: TextOverflow.clip),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(AppLocalizations.of(context)!.optional,
                        style: WidgetStyles.secondaryTextStyle),
                  ],
                ),
                children: [
                  TextField(
                    decoration: WidgetStyles.textFieldInputDecoration.copyWith(
                        hintText: AppLocalizations.of(context)!
                            .enterGiftCodePlaceholder),
                    enabled: widget.state is! SignUpLoading,
                    controller: _giftCodeEditingController,
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
            ),
        ],

        const SizedBox(
          height: 30,
        ),

        SizedBox(
          width: 300,
          child: ElevatedButton(
            style: WidgetStyles.buttonStyle,
            onPressed: !_buttonEnabled
                ? null
                : () async {
                    if (widget.state is! SignUpLoading) {
                      await widget.cubit.signUp(
                        SignUpWithEmailEntity(
                          email: _emailTextEditingController.text.trim(),
                          countryCode:
                              Localizations.localeOf(context).countryCode ?? "",
                          giftCode: _giftCodeEditingController.text.trim(),
                          createSubscription: false,
                        ),
                      );
                    }
                  },
            child: switch (widget.state) {
              SignUpLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              _ => Text(AppLocalizations.of(context)!.validate,
                  style: WidgetStyles.textStyle.copyWith(
                    color: YouScribeColors.whiteColor,
                  )),
            },
          ),
        ),

        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
