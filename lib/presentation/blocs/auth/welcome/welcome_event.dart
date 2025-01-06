part of 'welcome_bloc.dart';

sealed class WelcomeEvent extends Equatable {
  const WelcomeEvent();

  @override
  List<Object> get props => [];
}

class InitWelcomeScreenEvent extends WelcomeEvent {
  const InitWelcomeScreenEvent();
}
