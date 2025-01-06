part of 'products_in_selection_bloc.dart';

sealed class ProductsInSelectionState extends Equatable {
  const ProductsInSelectionState();

  @override
  List<Object> get props => [];
}

final class ProductsInSelectionInitialState extends ProductsInSelectionState {}

final class ProductsInSelectionErrorState extends ProductsInSelectionState {
  const ProductsInSelectionErrorState(this.errorType, this.previousState);
  final ErrorType errorType;
  final ProductsInSelectionState previousState;

  @override
  List<Object> get props => [errorType, previousState];
}

final class ProductsInSelectionLoadedState extends ProductsInSelectionState {
  const ProductsInSelectionLoadedState(
      {required this.products,
      required this.title,
      required this.description,
      required this.hasNextPage,
      required this.selectionId});
  final List<ProductEntity> products;
  final String title;
  final String description;
  final String selectionId;
  final bool hasNextPage;

  ProductsInSelectionLoadedState copyWith({
    List<ProductEntity>? products,
    String? title,
    String? description,
    bool? hasNextPage,
    String? selectionId,
  }) {
    final state = ProductsInSelectionLoadedState(
      products: products ?? this.products,
      title: title ?? this.title,
      description: description ?? this.description,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      selectionId: selectionId ?? this.selectionId,
    );
    return state;
  }

  @override
  List<Object> get props =>
      [products, title, description, selectionId, hasNextPage];
}
