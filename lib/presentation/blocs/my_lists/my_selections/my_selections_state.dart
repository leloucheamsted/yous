part of 'my_selections_bloc.dart';

sealed class MySelectionsState extends Equatable {
  const MySelectionsState();

  @override
  List<Object> get props => [];
}

final class MySelectionsInitial extends MySelectionsState {
  const MySelectionsInitial();
  @override
  List<Object> get props => [];
}

final class MySelectionsLoadedState extends MySelectionsState {
  MySelectionsLoadedState(
      {this.mySelections = const [], this.isLoading = false});

  List<SimpleLibraryEntity> mySelections;
  bool? isLoading;

  @override
  List<Object> get props => [mySelections, isLoading!];
}

final class MySelectionsExceptionState extends MySelectionsState {
  const MySelectionsExceptionState();

  @override
  List<Object> get props => [];
}

final class MySelectionsEmptyState extends MySelectionsState {
  const MySelectionsEmptyState();

  @override
  List<Object> get props => [];
}
