part of 'app_loading_bloc.dart';

sealed class AppLoadingState extends Equatable {
  const AppLoadingState();

  @override
  List<Object> get props => [];
}

final class AppLoadingInitial extends AppLoadingState {}
