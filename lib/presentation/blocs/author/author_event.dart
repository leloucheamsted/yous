part of 'author_bloc.dart';

@immutable
sealed class AuthorEvent {
  const AuthorEvent();

  List<Object> get props => [];
}

class InitAuthorEvent extends AuthorEvent {
  InitAuthorEvent(this.authorId, this.language, this.displayName);

  int authorId;
  String language;
  String displayName;

  @override
  List<Object> get props => [];
}

class FollowEvent extends AuthorEvent {
  const FollowEvent();

  @override
  List<Object> get props => [];
}

class ErrorDisplayedEvent extends AuthorEvent {
  const ErrorDisplayedEvent();
}

class LoadNewPageEvent extends AuthorEvent {
  const LoadNewPageEvent();

  @override
  List<Object> get props => [];
}
