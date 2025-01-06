part of 'library_bloc.dart';

sealed class LibraryEvent extends Equatable {
  const LibraryEvent();

  @override
  List<Object> get props => [];
}

class LibraryInitEvent extends LibraryEvent {
  const LibraryInitEvent();
  @override
  List<Object> get props => [];
}

class FirstSearchOptionSelectedEvent extends LibraryEvent {
  const FirstSearchOptionSelectedEvent({required this.firstLevelOption});

  final BaseProductFacetEntity firstLevelOption;

  @override
  List<Object> get props => [firstLevelOption];
}

class ErrorDisplayedEvent extends LibraryEvent {}
