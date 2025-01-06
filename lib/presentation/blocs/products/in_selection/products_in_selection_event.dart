part of 'products_in_selection_bloc.dart';

sealed class ProductsInSelectionEvent extends Equatable {
  const ProductsInSelectionEvent();

  @override
  List<Object> get props => [];
}

class InitProductInSelectionEvent extends ProductsInSelectionEvent {
  const InitProductInSelectionEvent(this.selectionId);

  final String selectionId;

  @override
  List<Object> get props => [selectionId];
}

class RefreshProductsInSelectionEvent extends ProductsInSelectionEvent {}

class ErrorDisplayedEvent extends ProductsInSelectionEvent {}

class ProductsInSelectionInfiniteScrollEvent extends ProductsInSelectionEvent {}
