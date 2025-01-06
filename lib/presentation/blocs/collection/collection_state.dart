part of 'collection_bloc.dart';

@immutable
sealed class CollectionState extends Equatable {
  @override
  List<Object> get props => [];
}

final class CollectionInitialState extends CollectionState {}

final class CollectionLoadedState extends CollectionState {
  CollectionLoadedState(
      {required this.products,
      required this.hasNextPage,
      this.collectionTitle,
      this.collectionId});
  final List<BaseEntity> products;
  final String? collectionTitle;
  final int? collectionId;
  final bool hasNextPage;
  @override
  List<Object> get props => [products, collectionId!, collectionTitle!];
}

final class CollectionErrorState extends CollectionState {
  CollectionErrorState(this.errorType);
  ErrorType errorType;

  @override
  List<Object> get props => [];
}
