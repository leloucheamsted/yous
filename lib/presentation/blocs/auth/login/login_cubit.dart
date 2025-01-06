import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/app_settings.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/current_user_account_entity.dart';
import 'package:youscribe/core/errors/api_error.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/use_cases/configurations/get_user_settings_use_case.dart';
import 'package:youscribe/presentation/blocs/auth/base_auth_cubit.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState>
    with Debuggable, Loggable, BaseAuthCubit {
  LoginCubit() : super(LoginInitial());

  final GetUserSettingsUseCase _getUserSettingsUseCase =
      locator<GetUserSettingsUseCase>();

  bool facebookAllowed = false;
  bool garAllowed = false;
  bool canalplusAllowed = false;
  bool appleAllowed = false;

  @override
  String get debugName => 'LoginCubit';

  Future<void> login(String userName, String password) async {
    emit(LoginLoading());

    if (!await isInternetAvailable()) {
      return emit(LoginError(
          message: "No internet connection",
          errorType: LoginErrorType.noInternetConnection));
    }

    return emit(
      (await locator<AuthenticationManager>().login((
        userName: userName,
        password: password,
      )))
          .fold(
        (value) => LoginSuccess(currentUserAccountEntity: value),
        (error) {
          LoginErrorType errorType = LoginErrorType.unknown;
          if (error is ApiError || error is APIRequestException) {
            errorType = LoginErrorType.authenticationFailed;
          }

          return LoginError(message: error.toString(), errorType: errorType);
        },
      ),
    );
  }

  Future<void> loginWithCanalPlus() async {
    emit(LoginLoading());
    return emit(
      (await locator<AuthenticationManager>().loginWithCanalPlus()).fold(
        (value) => LoginSuccess(currentUserAccountEntity: value),
        (error) => LoginError(
            message: error.toString(), errorType: LoginErrorType.unknown),
      ),
    );
  }

  Future<void> loginWithGAR(BuildContext context) async {
    emit(LoginLoading());
    return emit(
      (await locator<AuthenticationManager>().loginWithGARSSO(context)).fold(
        (value) {
          return LoginSuccess(currentUserAccountEntity: value);
        },
        (error) => LoginError(
            message: error.toString(), errorType: LoginErrorType.garAuthFailed),
      ),
    );
  }

  Future<void> forgotPassword() async {}

  Future<void> difficultiesSigningIn({required String clientInfo}) async {
    final appSettings = locator<AppSettings>();

    final path = await logger.logFilePath;
    final file = File(path);
    final Email sendEmail = Email(
      subject: clientInfo,
      recipients: [appSettings.supportEmail],
      attachmentPaths: [file.path],
    );

    try {
      await FlutterEmailSender.send(sendEmail);
      return;
    } catch (e) {
      logError("Error occurred while mailing to Youscribe.",
          error: Exception(e));
    }

    try {
      await FlutterEmailSender.send(Email(
        subject: clientInfo,
        recipients: [appSettings.supportEmail],
      ));
      return;
    } catch (e) {
      logError("Error occurred while mailing to Youscribe.",
          error: Exception(e));
    }
  }

  Future<void> init() async {
    final result = await getAuthButtonsVisibility(_getUserSettingsUseCase);

    facebookAllowed = result.$1;
    canalplusAllowed = result.$2;
    appleAllowed = result.$3;
    garAllowed = result.$4;

    emit(LoginInitial(
        canShowFacebookButton: facebookAllowed,
        canShowCanalplusButton: canalplusAllowed,
        canShowAppleButton: appleAllowed,
        garAllowed: garAllowed));
  }

  Future<void> loginWithApple({required String giftCode}) async {
    if (!await isInternetAvailable()) {
      return emit(LoginError(
          message: "No internet connection",
          errorType: LoginErrorType.noInternetConnection));
    }
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final settingns = await _getUserSettingsUseCase(null);
    return emit(
      (await locator<AuthenticationManager>().loginWithApple((
        appleUserId: credential.userIdentifier ?? "",
        countryCode: settingns.ok!.countryConfiguration?.countryCode ?? "",
        userName: credential.givenName ?? "",
        languageCode: settingns.ok!.preferredLanguageCode,
        subscriptionCode: "",
        createSubscription: true,
        tokenId: credential.identityToken ?? '',
        email: credential.email ?? ""
      )))
          .fold(
        (value) => LoginSuccess(currentUserAccountEntity: value),
        (error) => LoginError(
            message: error.toString(), errorType: LoginErrorType.unknown),
      ),
    );
  }
}
