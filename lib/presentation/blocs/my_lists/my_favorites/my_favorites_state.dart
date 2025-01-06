part of 'my_favorites_bloc.dart';

sealed class MyFavoritesState extends Equatable {
  const MyFavoritesState();

  @override
  List<Object> get props => [];
}

final class MyFavoritesInitialState extends MyFavoritesState {}

final class MyFavoritesLoadedState extends MyFavoritesState {
  const MyFavoritesLoadedState(
      {required this.products,
      required this.hasNextPage,
      required this.isRefreshedData,
      required this.dontDisplaySwipeProductsListHelp});

  final List<ProductEntity> products;
  final bool isRefreshedData;
  final bool hasNextPage;
  final bool dontDisplaySwipeProductsListHelp;

  @override
  List<Object> get props =>
      [products, isRefreshedData, dontDisplaySwipeProductsListHelp];
}

final class MyFavoritesEmptyState extends MyFavoritesState {
  const MyFavoritesEmptyState();

  @override
  List<Object> get props => [];
}
