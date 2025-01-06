part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeEmpty extends HomeState {}

// ignore: must_be_immutable
final class HomeLoadedState extends HomeState {
  HomeLoadedState(
      {required this.editorials,
      required this.selections,
      required this.gleephSeggestions,
      required this.shouldShowSubscriptionBanner,
      required this.isRefreshedData});

  List<EditorialEntity> editorials;
  List<SelectionEntity> selections;
  List<ProductEntity> gleephSeggestions;
  final bool isRefreshedData;
  final bool shouldShowSubscriptionBanner;

  @override
  List<Object> get props => [
        editorials,
        selections,
        gleephSeggestions,
        isRefreshedData,
        shouldShowSubscriptionBanner
      ];
}

// ignore: must_be_immutable
final class HomeExceptionState extends HomeState {
  HomeExceptionState(this.previousState);

  HomeLoadedState previousState;

  @override
  List<Object> get props => [];
}

final class HomeShowRateState extends HomeState {
  HomeShowRateState(this.previousState);

  HomeLoadedState previousState;

  @override
  List<Object> get props => [];
}
