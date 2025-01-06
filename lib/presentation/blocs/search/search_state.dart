part of 'search_bloc.dart';

@immutable
sealed class SearchState extends Equatable {
  @override
  List<Object> get props => [];
}

final class SearchInitialState extends SearchState {}

final class SearchEmptyState extends SearchState {}

final class SearchLoadedState extends SearchState {
  SearchLoadedState({required this.searchResults, required this.isBusy});
  final MultiTypeSearchOutPutEntity searchResults;
  final bool isBusy;

  @override
  List<Object> get props => [searchResults, isBusy];
}

final class SearchErrorState extends SearchState {
  SearchErrorState(this.previousState, {required this.errorType});
  final ErrorType errorType;
  final SearchState previousState;

  @override
  List<Object> get props => [errorType, previousState];
}
