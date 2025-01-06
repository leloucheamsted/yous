// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:wyatt_bloc_helper/wyatt_bloc_helper.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/extensions/build_context_extension.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe/presentation/blocs/app/app_bloc_bloc.dart';
import 'package:youscribe/presentation/blocs/app_loading/app_loading_bloc.dart';
import 'package:youscribe/presentation/blocs/auth/login/login_cubit.dart';
import 'package:youscribe/presentation/blocs/home/home_bloc.dart';
import 'package:youscribe/presentation/blocs/library/first_level/library_bloc.dart';
import 'package:youscribe/presentation/screens/auth/widgets/authentification_dialog_view.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/styles/youscribe_theme.dart';
import 'package:youscribe/utilities/constants.dart';

class SignInScreen extends CubitScreen<LoginCubit, LoginState> {
  const SignInScreen({super.key});

  @override
  Future<void> onListen(BuildContext context, LoginState state) async {
    if (state is LoginSuccess) {
      //DO nothing
      final RxSharedPreferences rx = locator();
      await rx.setBool(PreferenceKey.libraryIsReloaded, true);
      final UserAccountRepository userAccountRepository = locator();

      await userAccountRepository
          .saveUserAccount(state.currentUserAccountEntity);
      context.read<AppLoadingBloc>().add(AppLoadingInitialEvent());
      context.read<HomeBloc>().add(const InitHomeEvent());
      context.read<LibraryBloc>().add(const LibraryInitEvent());
      context.read<AppBloc>().add(InitAppEvent());
    } else if (state is LoginError) {
      if (state.errorType == LoginErrorType.noInternetConnection) {
        await context.showAuthNetworkErrorAlert();
        return;
      }
      if (state.errorType == LoginErrorType.facebookAuthFailed) {
        await context.showAuthFacebookErrorAlert();
        return;
      }
      if (state.errorType == LoginErrorType.garAuthFailed) {
        await context.showAuthGarErrorAlert();
        return;
      }

      final message = state.errorType == LoginErrorType.authenticationFailed
          ? AppLocalizations.of(context)!.loginErrorMessage
          : AppLocalizations.of(context)!.unexpectedAuthError;

      await context.showErrorSnackBar(message);
    }
  }

  @override
  LoginCubit create(BuildContext context) => LoginCubit()..init();

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
  Widget onBuild(BuildContext context, LoginState state) => SigninScreenContent(
        state: state,
        cubit: bloc(context),
      );
}

class SigninScreenContent extends StatefulWidget {
  const SigninScreenContent(
      {required this.state, required this.cubit, super.key});

  final LoginState state;
  final LoginCubit cubit;

  @override
  State<SigninScreenContent> createState() => _SigninScreenContentState();
}

class _SigninScreenContentState extends State<SigninScreenContent> {
  final TextEditingController _userNameTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  bool _isButtonEnabled = false;

  bool _checkIfButtonIsEnabled() {
    return _userNameTextEditingController.text.isNotEmpty &&
        _passwordTextEditingController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.state is LoginLoading) {
      _isButtonEnabled = false;
    } else {
      _isButtonEnabled = _checkIfButtonIsEnabled();
    }

    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        if (widget.cubit.garAllowed)
          Material(
            color: Colors.transparent,
            child: Ink(
              child: InkWell(
                onTap: () async {
                  await widget.cubit.loginWithGAR(context);
                },
                child: SvgPicture.asset(
                  AssetsName.garButton,
                  width: MediaQuery.of(context).size.width - 30,
                  height: 48,
                ),
              ),
            ),
          ),
        SizedBox(
          child: widget.cubit.appleAllowed
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SignInWithAppleButton(
                    onPressed: () async {
                      await widget.cubit.loginWithApple(giftCode: '');
                    },
                  ),
                )
              : null,
        ),
        // Facebook login button here:,
        // ElevatedButton(
        //   onPressed: () {
        //     widget.cubit.loginWithFacebook(giftCode: '');
        //   },
        //   child: const Text('Login with Facebook'),
        // ),
        // Apple login button here:,
        //canal+ login button here:
        // ElevatedButton(
        //   onPressed: () {
        //  bloc(context).loginWithCanalPlus();
        //   },
        //   child: const Text('Login with Canal Plus'),
        // ),
        // if (widget.cubit.facebookAllowed)
        const SizedBox(
          height: 10,
        ),

        if (widget.cubit.appleAllowed ||
            widget.cubit.facebookAllowed ||
            widget.cubit.garAllowed)
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
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            onChanged: (value) {
              setState(() {
                _isButtonEnabled = _checkIfButtonIsEnabled();
              });
            },
            decoration: WidgetStyles.textFieldInputDecoration
                .copyWith(hintText: AppLocalizations.of(context)!.username),
            controller: _userNameTextEditingController,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: TextField(
            keyboardType: TextInputType.visiblePassword,
            autofillHints: const [AutofillHints.password],
            obscureText: true,
            onChanged: (value) {
              setState(() {
                _isButtonEnabled = _checkIfButtonIsEnabled();
              });
            },
            decoration: WidgetStyles.textFieldInputDecoration
                .copyWith(hintText: AppLocalizations.of(context)!.password),
            controller: _passwordTextEditingController,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 300,
          child: ElevatedButton(
            style: WidgetStyles.buttonStyle,
            onPressed: !_isButtonEnabled
                ? null
                : () async {
                    await widget.cubit.login(
                        _userNameTextEditingController.text.trim(),
                        _passwordTextEditingController.text.trim());
                  },
            child: switch (widget.state) {
              LoginLoading() => const Center(
                    child: CircularProgressIndicator(
                  color: YouScribeColors.accentColor,
                )),
              _ => Text(AppLocalizations.of(context)!.validate,
                  style: WidgetStyles.textStyle.copyWith(
                    color: YouScribeColors.whiteColor,
                  )),
            },
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        GestureDetector(
          onTap: () async {
            //TODO: Implement this UI portion.
            await context.pushNamed(Routes.forgotPassword);
          },
          child: Text(AppLocalizations.of(context)!.forgotPassword,
              style: WidgetStyles.textStyle.copyWith(
                decoration: TextDecoration.underline,
              )),
        ),

        const SizedBox(
          height: 10,
        ),

        GestureDetector(
          onTap: () async {
            final result = await AuthentificationDialogView.contactUsAlert(
                context: context);

            if (result) {
              final runtimePlatform = Platform.isAndroid ? 'Android' : 'iOS';
              String osVersion = "";
              final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
              final PackageInfo packageInfo = await PackageInfo.fromPlatform();
              final appVersion = packageInfo.version;
              if (Platform.isAndroid) {
                final androidInfo = await deviceInfoPlugin.androidInfo;
                osVersion = androidInfo.version.release;
              }
              if (Platform.isIOS) {
                final iosInfo = await deviceInfoPlugin.iosInfo;
                osVersion = iosInfo.systemVersion;
              }
              final clientInfo = """
${AppLocalizations.of(context)!.authIssue} OS: $runtimePlatform, AppVersion: $appVersion, OSVersion: $osVersion""";

              await widget.cubit.difficultiesSigningIn(clientInfo: clientInfo);
            }
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(AppLocalizations.of(context)!.havingDifficultiesText,
                style: WidgetStyles.caption1TextStyle),
            const SizedBox(
              width: 3,
            ),
            Text(AppLocalizations.of(context)!.contactUs,
                style: WidgetStyles.caption1TextStyle.copyWith(
                    decoration: TextDecoration.underline,
                    color: Colors.blueAccent)),
          ]),
        )
      ],
    );
  }
}
