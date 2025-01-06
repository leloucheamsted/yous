part of 'my_offlines_bloc.dart';

sealed class MyOfflinesEvent extends Equatable {
  const MyOfflinesEvent();

  @override
  List<Object> get props => [];
}

class InitMyOfflinesEvent extends MyOfflinesEvent {}

class RefreshMyOfflinesEvent extends MyOfflinesEvent {}

class RemoveOfflineBookFromOfflinesEvent extends MyOfflinesEvent {
  const RemoveOfflineBookFromOfflinesEvent(this.productId);

  final int productId;

  @override
  List<Object> get props => [productId];
}

class LoadNewOfflineBooksPageEvent extends MyOfflinesEvent {
  const LoadNewOfflineBooksPageEvent(this.productsCount);

  final int productsCount;

  @override
  List<Object> get props => [productsCount];
}
