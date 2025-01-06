part of 'premium_suggestion_bloc.dart';

@immutable
sealed class PremiumSuggestionState extends Equatable {
  @override
  List<Object> get props => [];
}

final class PremiumSuggestionStateInitial extends PremiumSuggestionState {}

final class PremiumSuggestionStateLoading extends PremiumSuggestionState {
  PremiumSuggestionStateLoading({
    this.hasTokenSubscription = false,
    this.hasAvailableToken = false,
    this.products = const [],
    this.isLoading = false,
  });
  final bool hasTokenSubscription;
  final bool hasAvailableToken;
  final List<ProductEntity> products;
  final bool isLoading;

  // copyWith method
  PremiumSuggestionStateLoading copyWith({
    bool? hasTokenSubscription,
    bool? hasAvailableToken,
    List<ProductEntity>? products,
    bool? isLoading,
  }) {
    return PremiumSuggestionStateLoading(
      hasTokenSubscription: hasTokenSubscription ?? this.hasTokenSubscription,
      hasAvailableToken: hasAvailableToken ?? this.hasAvailableToken,
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [hasTokenSubscription, hasAvailableToken, products];
}

final class PremiumSuggestionErrorState extends PremiumSuggestionState {
  PremiumSuggestionErrorState(this.previousState, this.errorType);

  PremiumSuggestionState previousState;
  ErrorType errorType;

  @override
  List<Object> get props => [];
}
