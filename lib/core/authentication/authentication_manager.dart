// ignore_for_file: lines_longer_than_80_chars, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/app_settings.dart';
import 'package:youscribe/core/authentication/authentication_status.dart';
import 'package:youscribe/core/entities/current_user_account_entity.dart';
import 'package:youscribe/core/entities/session.dart';
import 'package:youscribe/core/entities/sign_up_with_email_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/use_cases/authentication/login_use_case.dart';
import 'package:youscribe/core/use_cases/authentication/login_with_apple_use_case.dart';
import 'package:youscribe/core/use_cases/authentication/login_with_canalplus.dart';
import 'package:youscribe/core/use_cases/authentication/login_with_facebook.dart';
import 'package:youscribe/core/use_cases/authentication/login_with_gar_use_case.dart';
import 'package:youscribe/core/use_cases/authentication/logout_from_gar_use_case.dart';
import 'package:youscribe/core/use_cases/authentication/logout_use_case.dart';
import 'package:youscribe/core/use_cases/authentication/on_authentication_status_change_use_case.dart';
import 'package:youscribe/core/use_cases/authentication/sign_up_use_case.dart';
import 'package:youscribe/core/use_cases/authentication/startup_authentication_use_case.dart';
import 'package:youscribe/data/data_sources/user_acount_data_sources/user_account_local_data_source.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe_analytics/youscribe_analytics.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

typedef Auth = AuthenticationManager;

class AuthenticationManager with Debuggable, Loggable, Trackable {
  AuthenticationManager(
      {required LogoutUseCase logoutUseCase,
      required LoginUseCase loginUseCase,
      required SignUpUseCase signUpUseCase,
      required LoginWithCanalPlusUseCase loginWithCanalPlusUseCase,
      required LoginWithFacebookUseCase loginWithFacebookUseCase,
      required LoginWithAppleUseCase loginWithAppleUseCase,
      required StartupAuthenticationUseCase stusecase,
      required LoginWithGARUseCase loginWithGARUseCase,
      required LogoutFromGARUseCase logoutFromGARUseCase,
      required OnAuthenticationStatusChangeUseCase
          onAuthenticationStatusChangeUseCase})
      : _loginUseCase = loginUseCase,
        _logoutUseCase = logoutUseCase,
        _startupAuthenticationUseCase = stusecase,
        _signUpUseCase = signUpUseCase,
        _loginWithCanalPlusUseCase = loginWithCanalPlusUseCase,
        _loginWithFacebookUseCase = loginWithFacebookUseCase,
        _loginWithAppleUseCase = loginWithAppleUseCase,
        _loginWithGARUseCase = loginWithGARUseCase,
        _logoutFromGARUseCase = logoutFromGARUseCase,
        _onAuthenticationStatusChangeUseCase =
            onAuthenticationStatusChangeUseCase {
    _authController.listen(_onAuthenticationStatusChangeUseCase.call);
  }

  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final SignUpUseCase _signUpUseCase;
  final StartupAuthenticationUseCase _startupAuthenticationUseCase;
  final LoginWithCanalPlusUseCase _loginWithCanalPlusUseCase;
  final LoginWithGARUseCase _loginWithGARUseCase;
  final LogoutFromGARUseCase _logoutFromGARUseCase;
  final LoginWithFacebookUseCase _loginWithFacebookUseCase;
  final LoginWithAppleUseCase _loginWithAppleUseCase;
  final OnAuthenticationStatusChangeUseCase
      _onAuthenticationStatusChangeUseCase;

  @override
  String get debugName => 'AuthenticationManager';

  static ValueNotifier<Session?> currentSessionNotifier() =>
      locator<AuthenticationManager>().sessionNotifier;

  static Session? currentSession() =>
      locator<AuthenticationManager>().sessionNotifier.value;

  static AuthenticationManager get instance => locator<AuthenticationManager>();

  final _authController = BehaviorSubject<AuthenticationStatus>()
    ..add(AuthenticationStatus.unknown);

  ValueNotifier<Session?> sessionNotifier = ValueNotifier(null);
  Session? get session => sessionNotifier.value;

  Stream<AuthenticationStatus> get authenticationStatusSteam =>
      _authController.stream.asBroadcastStream();

  AuthenticationStatus get authenticationStatus => _authController.value;

  static Future<String> getAuthToken() async {
    if (instance.session?.currentUserAccountEntity?.token.isNotNullOrEmpty ??
        false) {
      return instance.session!.currentUserAccountEntity!.token!;
    }
    final userAccDataSource = locator<UserAccountLocalDataSource>();
    final userAcc = await userAccDataSource.retrieve();
    return userAcc?.token ?? '';
  }

  static Future<CurrentUserAccountEntity?> getCurrentUser() async {
    if (instance.session?.currentUserAccountEntity?.token.isNotNullOrEmpty ??
        false) {
      return instance.session!.currentUserAccountEntity!;
    }
    final userAccDataSource = locator<UserAccountLocalDataSource>();
    final userAcc = await userAccDataSource.retrieve();
    return userAcc;
  }

  static Future<String> openLegalNotices() async {
    final dio = Dio();
    final appSettings = locator<AppSettings>();
    final result = await dio.get<dynamic>(appSettings.legalNoticesGarUrl);
    return result.data['Content'] as String;
  }

  static Future<String> openPersonalDataCharter() async {
    final dio = Dio();
    final appSettings = locator<AppSettings>();
    final result =
        await dio.get<dynamic>(appSettings.personnalDataCharterGarUrl);
    return result.data['Content'] as String;
  }

  static void setFirebaseToken(String firebaseToken) {
    if (instance.session != null) {
      instance.sessionNotifier.value = Session(
          currentUserAccountEntity: instance.session!.currentUserAccountEntity!
              .copyWith(firebaseToken: firebaseToken));
    }
  }

  FutureOrResult<CurrentUserAccountEntity> login([
    ({String userName, String password})? credentials,
  ]) async =>
      Result.tryCatchAsync(
        () async {
          final logInResult = await _loginUseCase(
            credentials,
          );

          if (logInResult.isErr) {
            throw logInResult.err!;
          }

          sessionNotifier.value =
              Session(currentUserAccountEntity: logInResult.ok);

          _authController.add(AuthenticationStatus.authenticated);
          await tracker.setUserId(logInResult.ok!.id.toString());
          await tracker.trackEmailLogin();
          await logger.setUserInfos(
            id: logInResult.ok?.id?.toString(),
            email: logInResult.ok?.email,
          );
          final SharedPreferences _prefs = await prefs;
          await _prefs.setBool(PreferenceKey.isGarUserConnected, false);
          return logInResult.ok!;
        },
        (error) {
          logError(
            "Error while logging in",
            error: error as Exception?,
            methodName: 'login',
          );
          if (error is APIRequestException) {
            return error;
          }
          if (error is AppException) {
            return error;
          }
          return ClientException(error.toString());
        },
      );

  FutureOrResult<CurrentUserAccountEntity> loginWithFacebook(
          [({
            String accessToken,
            String countryCode,
            String? giftCode,
            bool createSubscription
          })? credentials]) async =>
      await Result.tryCatchAsync(
        () async {
          final loginWithFacebookPlusResult =
              await _loginWithFacebookUseCase(credentials);

          if (loginWithFacebookPlusResult.isErr) {
            throw loginWithFacebookPlusResult.err!;
          }

          sessionNotifier.value =
              Session(currentUserAccountEntity: loginWithFacebookPlusResult.ok);
          _authController.add(AuthenticationStatus.authenticated);

          await tracker
              .setUserId(loginWithFacebookPlusResult.ok!.id.toString());
          await tracker.trackFacebookAuthentication();
          await logger.setUserInfos(
            id: loginWithFacebookPlusResult.ok?.id?.toString(),
            email: loginWithFacebookPlusResult.ok?.email,
          );
          final SharedPreferences _prefs = await prefs;
          await _prefs.setBool(PreferenceKey.isGarUserConnected, false);
          return loginWithFacebookPlusResult.ok!;
        },
        (error) {
          logError(
            '''An unknown error occurred while performing Facebook authentication.''',
            error: Exception(error),
            methodName: 'loginWithFacebook',
          );
          if (error is AppException) {
            return error;
          }
          if (error is APIRequestException) {
            logError(
              "An API error occurred while performing Facebook authentication.",
              error: Exception(error),
              methodName: 'loginWithFacebook',
            );
            return error;
          }
          return ClientException(error.toString());
        },
      );

  FutureOrResult<void> logOut() async => Result.tryCatchAsync(() async {
        final logOutResult = await _logoutUseCase(null);

        if (logOutResult.isErr) {
          throw logOutResult.err!;
        }

        _authController.add(AuthenticationStatus.unauthenticated);

        await tracker.trackSignout();
        await tracker.resetUserId();
        await logger.unsetUserInfos();
      }, (error) {
        logError(
          "Error while logging out",
          error: error as Exception?,
          methodName: 'logOut',
        );
        return error is AppException
            ? error
            : ClientException(error.toString());
      });

  FutureOrResult<CurrentUserAccountEntity?> offlineLogin() async =>
      Result.tryCatchAsync(() async {
        final user = await _startupAuthenticationUseCase(null);

        if (user.isOk && user.ok != null) {
          sessionNotifier.value = Session(currentUserAccountEntity: user.ok);
          _authController.add(AuthenticationStatus.authenticated);
          await tracker.setUserId(user.ok!.id.toString());
          await logger.setUserInfos(
            id: user.ok?.id?.toString(),
            email: user.ok?.email,
          );

          return user.ok;
        }

        _authController.add(AuthenticationStatus.unauthenticated);
        return user.ok;
      }, (error) {
        _authController.add(AuthenticationStatus.unauthenticated);
        if (error is AppException) {
          return error;
        }
        if (error is APIRequestException) {
          return error;
        }
        return ClientException(error.toString());
      });

  FutureOrResult<CurrentUserAccountEntity> signUp(
          SignUpWithEmailEntity signUpRequest) async =>
      Result.tryCatchAsync(
        () async {
          final signUpResult = await _signUpUseCase(signUpRequest);

          if (signUpResult.isErr) {
            throw signUpResult.err!;
          }

          sessionNotifier.value =
              Session(currentUserAccountEntity: signUpResult.ok);
          _authController.add(AuthenticationStatus.authenticated);

          await tracker.setUserId(signUpResult.ok!.id.toString());
          await tracker.trackEmailSignup();
          await logger.setUserInfos(
            id: signUpResult.ok?.id?.toString(),
            email: signUpResult.ok?.email,
          );
          return signUpResult.ok!;
        },
        (error) {
          logError(
            "Error while signing up",
            error: error as Exception?,
            methodName: 'signUp',
          );

          if (error is AppException) {
            return error;
          }
          if (error is APIRequestException) {
            return error;
          }
          return ClientException(error.toString());
        },
      );

  FutureOrResult<CurrentUserAccountEntity> loginWithCanalPlus() async =>
      Result.tryCatchAsync(
        () async {
          final loginWithCanalPlusResult =
              await _loginWithCanalPlusUseCase(null);

          if (loginWithCanalPlusResult.isErr) {
            throw loginWithCanalPlusResult.err!;
          }

          sessionNotifier.value =
              Session(currentUserAccountEntity: loginWithCanalPlusResult.ok);
          _authController.add(AuthenticationStatus.authenticated);

          await tracker.setUserId(loginWithCanalPlusResult.ok!.id.toString());
          await tracker.trackCanalPlusAuthentication();
          await logger.setUserInfos(
            id: loginWithCanalPlusResult.ok?.id?.toString(),
            email: loginWithCanalPlusResult.ok?.email,
          );

          return loginWithCanalPlusResult.ok!;
        },
        (error) {
          logError(
            "Error while logging in with canal+",
            error: error as Exception?,
            methodName: 'loginWithCanalPlus',
          );
          if (error is AppException) {
            return error;
          }
          if (error is APIRequestException) {
            return error;
          }
          return ClientException(error.toString());
        },
      );

  FutureOrResult<CurrentUserAccountEntity> loginWithApple(
          [({
            String countryCode,
            String tokenId,
            String languageCode,
            String userName,
            String email,
            bool createSubscription,
            String subscriptionCode,
            String appleUserId,
          })? credentials]) async =>
      await Result.tryCatchAsync(
        () async {
          final loginWithAppleResult =
              await _loginWithAppleUseCase(credentials);

          if (loginWithAppleResult.isErr) {
            throw loginWithAppleResult.err!;
          }

          sessionNotifier.value =
              Session(currentUserAccountEntity: loginWithAppleResult.ok);
          _authController.add(AuthenticationStatus.authenticated);

          await tracker.setUserId(loginWithAppleResult.ok!.id.toString());
          await tracker.trackAppleAuthentication();
          await logger.setUserInfos(
            id: loginWithAppleResult.ok?.id?.toString(),
            email: loginWithAppleResult.ok?.email,
          );
          final SharedPreferences _prefs = await prefs;
          await _prefs.setBool(PreferenceKey.isGarUserConnected, false);
          return loginWithAppleResult.ok!;
        },
        (error) {
          logError(
            'An unknown error occurred while performing Apple authentication.',
            error: Exception(error),
            methodName: 'loginWithApple',
          );
          if (error is AppException) {
            return error;
          }
          if (error is APIRequestException) {
            logError(
              "An API error occurred while performing apple authentication.",
              error: Exception(error),
              methodName: 'loginWithApple',
            );
            return error;
          }
          return ClientException(error.toString());
        },
      );

  FutureOrResult<CurrentUserAccountEntity> loginWithGARSSO(
          BuildContext context) async =>
      Result.tryCatchAsync(
        () async {
          final loginWithGarResult = await _loginWithGARUseCase(context);

          if (loginWithGarResult.isErr) {
            throw loginWithGarResult.err!;
          }

          sessionNotifier.value =
              Session(currentUserAccountEntity: loginWithGarResult.ok);
          _authController.add(AuthenticationStatus.authenticated);

          await tracker.setUserId(loginWithGarResult.ok!.id.toString());
          await tracker.trackGarAuthentication();
          await logger.setUserInfos(
            id: loginWithGarResult.ok?.id?.toString(),
            email: loginWithGarResult.ok?.email,
          );
          final SharedPreferences _prefs = await prefs;
          final hasLastConnectionGAR =
              _prefs.getBool(PreferenceKey.isGarUserConnected) ?? false;
          if (hasLastConnectionGAR) {
            if (_prefs.getInt(PreferenceKey.lastUserAccountId) ==
                loginWithGarResult.ok!.id) {
              final lastLogin =
                  DateTime.parse(_prefs.getString(PreferenceKey.lastlLogin)!);
              final lastLoginDiff =
                  DateTime.now().difference(lastLogin).inMinutes;
              if (lastLoginDiff >= 360) {
                // new session
                final dio = Dio();
                final appSettings = locator<AppSettings>();
                final logoutUrl = appSettings.logoutGarUrl;
                await _prefs.setString(
                    PreferenceKey.lastlLogin, DateTime.now().toString());
                // ignore: inference_failure_on_function_invocation
                await dio.post(logoutUrl.replaceAll(
                    'userId', loginWithGarResult.ok?.id.toString() ?? ''));
                await _prefs.setString(
                    PreferenceKey.lastlLogin, DateTime.now().toString());
              } else {}
            } else {
              await _prefs.setInt(
                  PreferenceKey.lastUserAccountId, loginWithGarResult.ok!.id!);
              await _prefs.setString(
                  PreferenceKey.lastlLogin, DateTime.now().toString());
            }
          } else {
            await _prefs.setInt(
                PreferenceKey.lastUserAccountId, loginWithGarResult.ok!.id!);
            await _prefs.setString(
                PreferenceKey.lastlLogin, DateTime.now().toString());
            await _prefs.setBool(PreferenceKey.isGarUserConnected, true);
          }
          return loginWithGarResult.ok!;
        },
        (error) {
          logError(
            "Error while logging in with gar sso+",
            error: error as Exception?,
            methodName: 'loginWithGARSSO',
          );
          if (error is AppException) {
            return error;
          }
          if (error is APIRequestException) {
            return error;
          }
          return ClientException(error.toString());
        },
      );

  FutureOrResult<void> logOutWithGAR() async => Result.tryCatchAsync(() async {
        final currentUser = await getCurrentUser();

        final logout = await _logoutFromGARUseCase(currentUser);

        // ignore: avoid_dynamic_calls
        if (logout.isOk) {
          final SharedPreferences _prefs = await prefs;
          await _prefs.setString(
              PreferenceKey.lastLogout, DateTime.now().toString());
          final auth = locator<AuthenticationManager>();
          await auth.logOut();
        }
        final logOutResult = await _logoutUseCase(null);

        if (logOutResult.isErr) {
          throw logOutResult.err!;
        }

        _authController.add(AuthenticationStatus.unauthenticated);

        await tracker.trackSignout();
        await tracker.resetUserId();
        await logger.unsetUserInfos();
      }, (error) {
        logError(
          "Error while logging out GAR SSO user",
          error: error as Exception?,
          methodName: 'logOutWithGAR',
        );
        return error is AppException
            ? error
            : ClientException(error.toString());
      });
}
