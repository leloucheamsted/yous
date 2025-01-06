part of 'notification_bloc.dart';

@immutable
sealed class NotificationEvent {
  const NotificationEvent();

  List<Object> get props => [];
}

class InitNotificationEvent extends NotificationEvent {
  const InitNotificationEvent({required this.options});
  final NotificationOption options;
  @override
  List<Object> get props => [options];
}

class NotificationDoneEvent extends NotificationEvent {
  const NotificationDoneEvent(this.options);
  final NotificationOption options;
  @override
  List<Object> get props => [options];
}

class DisplayedModalEvent extends NotificationEvent {
  const DisplayedModalEvent();
}
