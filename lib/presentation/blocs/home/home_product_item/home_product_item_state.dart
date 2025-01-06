part of 'home_product_item_cubit.dart';

sealed class HomeProductListItemState extends Equatable {
  const HomeProductListItemState();

  @override
  List<Object> get props => [];
}

final class HomeProductListItemInitial extends HomeProductListItemState {}

final class HomeProductListItemAttributeChanged
    extends HomeProductListItemState {
  const HomeProductListItemAttributeChanged();

  @override
  List<Object> get props => [];
}
