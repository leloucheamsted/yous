part of 'help_cubit.dart';

sealed class HelpState extends Equatable {
  const HelpState();

  @override
  List<Object> get props => [];
}

final class HelpInitialState extends HelpState {
  HelpInitialState(this.isBusy);
  bool isBusy;

  @override
  List<Object> get props => [isBusy];
}

final class LoadingState extends HelpState {}

final class HelpExceptionErrorState extends HelpState {}
