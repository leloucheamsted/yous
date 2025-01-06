part of 'classifications_bloc.dart';

sealed class ClassificationsEvent extends Equatable {
  const ClassificationsEvent();

  @override
  List<Object> get props => [];
}

class SeeAllSelectedEvent extends ClassificationsEvent {}

class FacetSelectedEvent extends ClassificationsEvent {
  const FacetSelectedEvent({required this.selectedFacet});

  final BaseProductFacetEntity selectedFacet;

  @override
  List<Object> get props => [selectedFacet];
}

class ClassificationsInitialEvent extends ClassificationsEvent {
  const ClassificationsInitialEvent(
      {required this.previousFacets, required this.selectedFacetId});

  final List<BaseProductFacetEntity> previousFacets;
  final int selectedFacetId;
}

class ErrorDisplayedEvent extends ClassificationsEvent {
  const ErrorDisplayedEvent();
}
