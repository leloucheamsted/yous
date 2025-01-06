part of 'my_offlines_bloc.dart';

sealed class MyOfflinesState extends Equatable {
  const MyOfflinesState();

  @override
  List<Object> get props => [];
}

final class MyOfflinesInitialState extends MyOfflinesState {}

final class MyOfflinesLoadedState extends MyOfflinesState {
  const MyOfflinesLoadedState(
      {required this.products,
      required this.hasNextPage,
      required this.dontDisplaySwipeProductsListHelp,
      required this.isRefreshedData});

  final List<ProductEntity> products;
  final bool isRefreshedData;
  final bool hasNextPage;
  final bool dontDisplaySwipeProductsListHelp;

  @override
  List<Object> get props =>
      [products, isRefreshedData, dontDisplaySwipeProductsListHelp];
}

final class MyOfflinesEmptyState extends MyOfflinesState {
  const MyOfflinesEmptyState();

  @override
  List<Object> get props => [];
}
