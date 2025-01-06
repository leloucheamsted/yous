import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/current_user_account_entity.dart';
import 'package:youscribe/core/entities/sign_up_with_email_entity.dart';
import 'package:youscribe/core/errors/api_error.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/use_cases/configurations/get_user_settings_use_case.dart';
import 'package:youscribe/presentation/blocs/auth/base_auth_cubit.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState>
    with Debuggable, Loggable, BaseAuthCubit {
  SignUpCubit() : super(SignUpInitial());

  final GetUserSettingsUseCase _getUserSettingsUseCase =
      locator<GetUserSettingsUseCase>();

  @override
  String get debugName => 'SignUpCubit';

  Future<void> signUp(SignUpWithEmailEntity signUpRequest) async {
    emit(SignUpLoading());
    if (!await isInternetAvailable()) {
      return emit(SignUpError(
          message: "No internet connection",
          errorType: SignupErrorType.noInternetConnection));
    }

    return emit(
      (await locator<AuthenticationManager>().signUp(signUpRequest)).fold(
        (value) => SignUpSuccess(currentUserAccountEntity: value),
        (error) {
          SignupErrorType errorType = SignupErrorType.unknown;
          if (error is ApiError) {
            if (error.statusCode == 400) {
              errorType = SignupErrorType.verifyEmailAddress;
            } else if (error.statusCode == 409) {
              errorType = SignupErrorType.accountAlreadyExists;
            }
          }

          if (error is APIRequestException) {
            if (error.statusCode == 409) {
              errorType = SignupErrorType.accountAlreadyExists;
            } else if (error.statusCode == 400) {
              errorType = SignupErrorType.verifyEmailAddress;
            }
          }

          return SignUpError(message: error.toString(), errorType: errorType);
        },
      ),
    );
  }

  Future<void> init() async {
    final result = await getAuthButtonsVisibility(_getUserSettingsUseCase);

    final facebookAllowed = result.$1;
    final canalplusAllowed = result.$2;
    final appleAllowed = result.$3;

    emit(SignUpInitial(
      canShowFacebookButton: facebookAllowed,
      canShowCanalplusButton: canalplusAllowed,
      canShowAppleButton: appleAllowed,
      isGiftCodeViewVisible: !Platform.isIOS,
    ));
  }
}
