part of 'collection_bloc.dart';

@immutable
sealed class CollectionEvent {
  const CollectionEvent();

  List<Object> get props => [];
}

class InitCollectionEvent extends CollectionEvent {
  InitCollectionEvent(this.collectionId, this.language, this.collectionTitle);
  int collectionId;
  String language;
  String collectionTitle;
  @override
  List<Object> get props => [];
}

class LoadNewPageEvent extends CollectionEvent {
  LoadNewPageEvent(this.collectionId, this.collectionTitle);
  int collectionId;
  String collectionTitle;

  @override
  List<Object> get props => [];
}

class ErrorDisplayedEvent extends CollectionEvent {
  const ErrorDisplayedEvent();
}
