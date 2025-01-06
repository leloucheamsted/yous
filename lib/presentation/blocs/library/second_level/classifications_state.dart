part of 'classifications_bloc.dart';

sealed class ClassificationsState extends Equatable {
  const ClassificationsState();

  @override
  List<Object> get props => [];
}

final class ClassificationsInitialState extends ClassificationsState {}

final class ClassificationsLoadedState extends ClassificationsState {
  const ClassificationsLoadedState(
      {required this.productFacets, required this.currentFacetId});

  final List<BaseProductFacetEntity> productFacets;
  final int currentFacetId;

  @override
  List<Object> get props => [currentFacetId, productFacets];
}

final class ClassificationErrorState extends ClassificationsState {
  ClassificationErrorState(this.previousState, this.errorType);

  ClassificationsState previousState;
  ErrorType errorType;

  @override
  List<Object> get props => [];
}
