part of 'login_cubit.dart';

@immutable
sealed class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {
  LoginInitial({
    this.canShowFacebookButton = false,
    this.canShowCanalplusButton = false,
    this.canShowAppleButton = false,
    this.garAllowed = false,
  });

  final bool canShowFacebookButton;
  final bool canShowCanalplusButton;
  final bool canShowAppleButton;
  final bool garAllowed;

  @override
  // TODO: implement props
  List<Object> get props => super.props
    ..addAll([
      canShowFacebookButton,
      canShowCanalplusButton,
      canShowAppleButton,
      garAllowed,
    ]);
}

final class LoginLoading extends LoginState {}

final class LoginError extends LoginState {
  LoginError({required this.message, required this.errorType});

  final String message;
  final LoginErrorType errorType;

  @override
  List<Object> get props => [message];
}

final class LoginSuccess extends LoginState {
  LoginSuccess({
    required this.currentUserAccountEntity,
  });

  final CurrentUserAccountEntity currentUserAccountEntity;

  @override
  List<Object> get props => [currentUserAccountEntity];
}

enum LoginErrorType {
  noInternetConnection,
  authenticationFailed,
  facebookAuthFailed,
  garAuthFailed,
  unknown,
}
