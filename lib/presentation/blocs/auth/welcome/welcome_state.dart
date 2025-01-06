part of 'welcome_bloc.dart';

sealed class WelcomeState extends Equatable {
  const WelcomeState();

  @override
  List<Object> get props => [];
}

final class WelcomeInitialState extends WelcomeState {
  const WelcomeInitialState(this.carouselImages);
  final List<String> carouselImages;

  @override
  List<Object> get props => [carouselImages];
}
