part of 'publisher_bloc.dart';

@immutable
sealed class PublisherEvent {
  const PublisherEvent();

  List<Object> get props => [];
}

class FollowEvent extends PublisherEvent {
  const FollowEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class InitPublisherEvent extends PublisherEvent {
  InitPublisherEvent(this.publisherId, this.language, this.displayName);

  int publisherId;
  String language;
  String displayName;

  @override
  List<Object> get props => [];
}

class ErrorDisplayedEvent extends PublisherEvent {
  const ErrorDisplayedEvent();
}

class LoadNewPageEvent extends PublisherEvent {
  const LoadNewPageEvent();

  @override
  List<Object> get props => [];
}
