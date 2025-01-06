part of 'my_favorites_bloc.dart';

sealed class MyFavoritesEvent extends Equatable {
  const MyFavoritesEvent();

  @override
  List<Object> get props => [];
}

class InitMyFavoritesEvent extends MyFavoritesEvent {}

class RefreshMyFavoritesEvent extends MyFavoritesEvent {}

class RemoveFavoriteBookFromFavoritesEvent extends MyFavoritesEvent {
  const RemoveFavoriteBookFromFavoritesEvent(this.productId);

  final int productId;

  @override
  List<Object> get props => [productId];
}

class FavoriteBookDownloadCompletedEvent extends MyFavoritesEvent {
  const FavoriteBookDownloadCompletedEvent(this.productId);

  final int productId;

  @override
  List<Object> get props => [productId];
}

class LoadNewFavoriteBooksPageEvent extends MyFavoritesEvent {
  const LoadNewFavoriteBooksPageEvent(this.productsCount);

  final int productsCount;

  @override
  List<Object> get props => [productsCount];
}
