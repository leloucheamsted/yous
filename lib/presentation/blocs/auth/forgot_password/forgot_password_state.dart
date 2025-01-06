part of 'forgot_password_cubit.dart';

@immutable
sealed class ForgotPasswordState extends Equatable {
  @override
  List<Object> get props => [];
}

final class ForgotPasswordStateInitial extends ForgotPasswordState {
  ForgotPasswordStateInitial();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

final class ForgotPasswordError extends ForgotPasswordState {
  ForgotPasswordError({required this.message, required this.errorType});

  final String message;
  final ForgotPasswordErrorType errorType;

  @override
  List<Object> get props => [message];
}

final class ForgotPasswordSuccess extends ForgotPasswordState {
  ForgotPasswordSuccess();

  @override
  List<Object> get props => [];
}

final class ForgotPasswordLoading extends ForgotPasswordState {}

enum ForgotPasswordErrorType {
  noInternetConnection,
  apiError,
  emailNotFound,
  unknown,
}
