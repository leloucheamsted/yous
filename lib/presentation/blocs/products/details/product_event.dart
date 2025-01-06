// ignore_for_file: must_be_immutable

part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {
  const ProductEvent();

  List<Object> get props => [];
}

class InitProductEvent extends ProductEvent {
  InitProductEvent(this.productId, this.language);
  int productId;
  String language;

  @override
  List<Object> get props => [];
}

class RefreshProductEvent extends ProductEvent {
  RefreshProductEvent(this.productId);
  int productId;
  @override
  List<Object> get props => [];
}

class IsOfflineEvent extends ProductEvent {
  const IsOfflineEvent({required this.isOffline});
  final bool isOffline;

  @override
  List<Object> get props => [isOffline];
}

class SyncEvent extends ProductEvent {
  const SyncEvent();
}

class RetreiveSelectionsEvent extends ProductEvent {
  const RetreiveSelectionsEvent();
}

class FavoriteEvent extends ProductEvent {
  const FavoriteEvent({required this.isFavorite});
  final bool isFavorite;

  @override
  List<Object> get props => [isFavorite];
}

class FollowEvent extends ProductEvent {
  const FollowEvent({required this.followType});
  final FollowType followType;

  @override
  List<Object> get props => [followType];
}

class AddToSelectionEvent extends ProductEvent {
  const AddToSelectionEvent(
      {required this.name,
      required this.productId,
      required this.isSelectionExist,
      this.libraryId,
      this.isPublic});

  final String name;
  final int? libraryId;
  final int productId;
  final bool? isPublic;
  final bool isSelectionExist;
  @override
  List<Object> get props =>
      [name, libraryId!, productId, isPublic!, isSelectionExist];
}

//Once the UI displays the error message, this event is fired
//to send the previous state to the UI
class ErrorDisplayedEvent extends ProductEvent {
  const ErrorDisplayedEvent();
}

class RequestSyncDisplayedEvent extends ProductEvent {
  const RequestSyncDisplayedEvent();
}

class RequestSyncEvent extends ProductEvent {
  const RequestSyncEvent();
}

class SelectionDisplayedEvent extends ProductEvent {
  const SelectionDisplayedEvent();
}

class AddToSelectionDisplayedEvent extends ProductEvent {
  const AddToSelectionDisplayedEvent();
}

enum FollowType {
  followEditor,
  unFollowEditor,
  followAuthor,
  unFollowAuthor,
  followTheme,
  unfollowTheme
}
