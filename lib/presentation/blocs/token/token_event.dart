part of 'token_bloc.dart';

@immutable
sealed class TokenEvent {
  const TokenEvent();

  List<Object> get props => [];
}

class InitTokenEvent extends TokenEvent {
  const InitTokenEvent();
  @override
  List<Object> get props => [];
}

class ErrorDisplayedEvent extends TokenEvent {
  const ErrorDisplayedEvent();
}
