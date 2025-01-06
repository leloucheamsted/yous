part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {
  const HomeEvent();

  List<Object> get props => [];
}

class InitHomeEvent extends HomeEvent {
  const InitHomeEvent({this.language = ''});
  final String language;
  @override
  List<Object> get props => [language];
}

class RefreshHomeEvent extends HomeEvent {
  const RefreshHomeEvent({required this.language});
  final String language;
  @override
  List<Object> get props => [language];
}

class DialogsDisplayedEvent extends HomeEvent {}
