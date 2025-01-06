part of 'suggestion_bloc.dart';

@immutable
sealed class SuggestionEvent {
  const SuggestionEvent();

  List<Object> get props => [];
}

class InitSuggestionEvent extends SuggestionEvent {
  const InitSuggestionEvent();
  @override
  List<Object> get props => [];
}

class ErrorDisplayedEvent extends SuggestionEvent {
  const ErrorDisplayedEvent();
}
