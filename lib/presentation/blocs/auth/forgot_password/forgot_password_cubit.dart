import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/use_cases/authentication/forgot_passsword_use_case.dart';
import 'package:youscribe/presentation/blocs/auth/base_auth_cubit.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState>
    with Debuggable, Loggable, BaseAuthCubit {
  ForgotPasswordCubit() : super(ForgotPasswordStateInitial());

  final ForgotPasswordUseCase _forgotPasswordUseCase =
      locator<ForgotPasswordUseCase>();

  @override
  String get debugName => 'ForgotPasswordCubit';

  Future<void> resetPassword(String username) async {
    emit(ForgotPasswordLoading());

    if (!await isInternetAvailable()) {
      return emit(ForgotPasswordError(
          message: "No internet connection",
          errorType: ForgotPasswordErrorType.noInternetConnection));
    }
    try {
      final result = await _forgotPasswordUseCase(username);

      if (result.isOk) {
        emit(ForgotPasswordSuccess());
      }
      if (result.isErr) {
        Exception(result.err);
        if (result.err!.message!.contains("404")) {
          return emit(ForgotPasswordError(
              message: "Email not found",
              errorType: ForgotPasswordErrorType.emailNotFound));
        } else {
          logError("API Error while executing reset password.",
              error: Exception(result.err));
          return emit(ForgotPasswordError(
              message: "API Error while executing reset password",
              errorType: ForgotPasswordErrorType.apiError));
        }
      }
    } catch (e) {
      logError("Unknown Error while executing reset password.",
          error: Exception(e));
      return emit(ForgotPasswordError(
          message: "Unknown Error",
          errorType: ForgotPasswordErrorType.unknown));
    }
  }
}
