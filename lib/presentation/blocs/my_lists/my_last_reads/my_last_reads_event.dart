part of 'my_last_reads_bloc.dart';

sealed class MyLastReadsEvent extends Equatable {
  const MyLastReadsEvent();

  @override
  List<Object> get props => [];
}

class InitMyLastReadsEvent extends MyLastReadsEvent {}

class RefreshMyLastReadsEvent extends MyLastReadsEvent {}

class RemoveLastReadBookFromFavoritesEvent extends MyLastReadsEvent {
  const RemoveLastReadBookFromFavoritesEvent(this.productId);

  final int productId;

  @override
  List<Object> get props => [productId];
}

class LastReadBookDownloadCompletedEvent extends MyLastReadsEvent {
  const LastReadBookDownloadCompletedEvent(this.productId);

  final int productId;

  @override
  List<Object> get props => [productId];
}
