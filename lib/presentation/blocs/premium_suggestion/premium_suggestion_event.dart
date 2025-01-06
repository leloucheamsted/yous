part of 'premium_suggestion_bloc.dart';

@immutable
sealed class PremiumSuggestionEvent {
  const PremiumSuggestionEvent();

  List<Object> get props => [];
}

class InitPremiumSuggestionEvent extends PremiumSuggestionEvent {
  const InitPremiumSuggestionEvent(this.productId);

  final int productId;
  @override
  List<Object> get props => [productId];
}

class UseTokenEvent extends PremiumSuggestionEvent {
  const UseTokenEvent(this.productId);

  final int productId;
  @override
  List<Object> get props => [productId];
}

class ErrorDisplayedEvent extends PremiumSuggestionEvent {
  const ErrorDisplayedEvent();
}
