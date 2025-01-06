part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {
  const SearchEvent();

  List<Object> get props => [];
}

final class SearchErrorDisplayedEvent extends SearchEvent {}

class SearchTextChangedEvent extends SearchEvent {
  const SearchTextChangedEvent(
      {required this.searchText, required this.language});
  final String searchText;
  final String language;
  @override
  List<Object> get props => [searchText, language];
}

class CollectionGroupSelectedEvent extends SearchEvent {
  const CollectionGroupSelectedEvent();
}

class AuthorGroupSelectedEvent extends SearchEvent {
  const AuthorGroupSelectedEvent();
}

class ProductGroupSelectedEvent extends SearchEvent {
  const ProductGroupSelectedEvent();
}

class CollectionSelectedEvent extends SearchEvent {
  const CollectionSelectedEvent({required this.collectionId});
  final int collectionId;
  @override
  List<Object> get props => [collectionId];
}

class AuthorSelectedEvent extends SearchEvent {
  const AuthorSelectedEvent({required this.authorId});
  final int authorId;
  @override
  List<Object> get props => [authorId];
}

class ProductSelectedEvent extends SearchEvent {
  const ProductSelectedEvent({required this.productId});
  final int productId;
  @override
  List<Object> get props => [productId];
}
