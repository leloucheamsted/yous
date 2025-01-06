part of 'product_list_item_cubit.dart';

sealed class ProductListItemState extends Equatable {
  const ProductListItemState();

  @override
  List<Object> get props => [];
}

final class ProductListItemInitial extends ProductListItemState {}

final class ProductListItemAttributeChanged extends ProductListItemState {
  const ProductListItemAttributeChanged({
    required this.isFavorite,
    required this.isOffline,
    required this.isLastRead,
    required this.isFileAvailable,
  });
  final bool isFavorite;
  final bool isOffline;
  final bool isLastRead;
  final bool isFileAvailable;

  @override
  List<Object> get props =>
      [isFavorite, isOffline, isLastRead, isFileAvailable];
}
