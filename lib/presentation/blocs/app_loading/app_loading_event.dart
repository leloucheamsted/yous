part of 'app_loading_bloc.dart';

sealed class AppLoadingEvent extends Equatable {
  const AppLoadingEvent();

  @override
  List<Object> get props => [];
}

final class AppLoadingInitialEvent extends AppLoadingEvent {}
