part of 'library_bloc.dart';

sealed class LibraryState extends Equatable {
  const LibraryState();

  @override
  List<Object> get props => [];
}

final class LibraryInitialState extends LibraryState {}

final class LibraryLoadedState extends LibraryState {
  const LibraryLoadedState(this.productFacets, this.secondproductFacets,
      this.currentThemeIndex, this.isYsClassfification);
  final List<BaseProductFacetEntity> productFacets;
  final List<BaseProductFacetEntity> secondproductFacets;
  final int currentThemeIndex;
  final bool isYsClassfification;
  @override
  List<Object> get props => [
        productFacets,
        secondproductFacets,
        currentThemeIndex,
        isYsClassfification
      ];
}

class SecondSearchOptionSelectedEvent extends LibraryEvent {
  const SecondSearchOptionSelectedEvent({required this.secondLevelOption});

  final BaseProductFacetEntity secondLevelOption;

  @override
  List<Object> get props => [secondLevelOption];
}

final class LibraryExceptionState extends LibraryState {
  LibraryExceptionState(this.previousState, this.errorType);

  LibraryLoadedState previousState;
  ErrorType errorType;

  @override
  List<Object> get props => [previousState, errorType];
}
