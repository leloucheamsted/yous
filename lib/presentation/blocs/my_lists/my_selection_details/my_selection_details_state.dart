part of 'my_selection_details_bloc.dart';

@immutable
sealed class MySelectionDetailsState extends Equatable {
  const MySelectionDetailsState();

  @override
  List<Object> get props => [];
}

final class InitMySelectionDetails extends MySelectionDetailsState {}

final class MySelectionDetailsLoadedState extends MySelectionDetailsState {
  const MySelectionDetailsLoadedState({required this.products});

  final List<MySelectionProductEntity> products;

  @override
  List<Object> get props => [products];
}

final class MySelectionDetailsEmptyState extends MySelectionDetailsState {}

final class MySelectionDetailsErrorState extends MySelectionDetailsState {
  MySelectionDetailsErrorState(this.previousState, this.errorType);

  MySelectionDetailsState previousState;
  ErrorType errorType;

  @override
  List<Object> get props => [];
}
