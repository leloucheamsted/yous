part of 'suggestion_bloc.dart';

@immutable
sealed class SuggestionState extends Equatable {
  @override
  List<Object> get props => [];
}

final class SuggestionInitialState extends SuggestionState {}

final class SuggestionStateLoadedState extends SuggestionState {
  SuggestionStateLoadedState({required this.products, this.isBusy = false});

  SuggestionStateLoadedState copyWith(
      {List<ProductEntity>? products, bool? isBusy}) {
    return SuggestionStateLoadedState(
        products: products ?? this.products, isBusy: isBusy ?? this.isBusy);
  }

  final List<ProductEntity> products;

  final bool isBusy;

  @override
  List<Object> get props => [products, isBusy];
}

// ignore: must_be_immutable
final class SuggestionErrorState extends SuggestionState {
  SuggestionErrorState(this.previousState, this.errorType);

  SuggestionState previousState;
  ErrorType errorType;

  @override
  List<Object> get props => [];
}
