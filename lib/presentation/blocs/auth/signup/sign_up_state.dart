part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState extends Equatable {
  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {
  SignUpInitial({
    this.canShowFacebookButton = false,
    this.canShowCanalplusButton = false,
    this.canShowAppleButton = false,
    this.isGiftCodeViewExpanded = false,
    this.isGiftCodeViewVisible = false,
  });

  final bool canShowFacebookButton;
  final bool canShowCanalplusButton;
  final bool canShowAppleButton;
  final bool isGiftCodeViewExpanded;
  final bool isGiftCodeViewVisible;

  @override
  // TODO: implement props
  List<Object> get props => super.props
    ..addAll([
      canShowFacebookButton,
      canShowCanalplusButton,
      canShowAppleButton,
    ]);
}

final class SignUpLoading extends SignUpState {}

final class SignUpError extends SignUpState {
  SignUpError({required this.message, required this.errorType});

  final String message;
  final SignupErrorType errorType;

  @override
  List<Object> get props => [message, errorType];
}

final class SignUpSuccess extends SignUpState {
  SignUpSuccess({
    required this.currentUserAccountEntity,
  });

  final CurrentUserAccountEntity currentUserAccountEntity;

  @override
  List<Object> get props => [currentUserAccountEntity];
}

enum SignupErrorType {
  accountAlreadyExists,
  noInternetConnection,
  verifyEmailAddress,
  unknown,
}
