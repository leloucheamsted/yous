part of 'notification_item_cubit.dart';

sealed class NotificationItemState extends Equatable {
  const NotificationItemState();

  @override
  List<Object> get props => [];
}

final class NotificationItemInitial extends NotificationItemState {}

final class NotificationItemAttributeChanged extends NotificationItemState {
  const NotificationItemAttributeChanged();

  @override
  List<Object> get props => [];
}
