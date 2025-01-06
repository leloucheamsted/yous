part of 'my_last_reads_bloc.dart';

sealed class MyLastReadsState extends Equatable {
  const MyLastReadsState();

  @override
  List<Object> get props => [];
}

final class MyLastReadsInitialState extends MyLastReadsState {}

final class MyLastReadsLoadedState extends MyLastReadsState {
  const MyLastReadsLoadedState(
      {required this.products,
      required this.hasNextPage,
      required this.dontDisplaySwipeProductsListHelp,
      required this.isRefreshedData});

  final List<ProductEntity> products;
  final bool isRefreshedData;
  final bool hasNextPage;
  final bool dontDisplaySwipeProductsListHelp;

  @override
  List<Object> get props => [
        products,
        isRefreshedData,
        hasNextPage,
        dontDisplaySwipeProductsListHelp
      ];
}

final class MyLastReadsEmptyState extends MyLastReadsState {
  const MyLastReadsEmptyState();

  @override
  List<Object> get props => [];
}
