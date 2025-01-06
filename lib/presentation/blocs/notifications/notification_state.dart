part of 'notification_bloc.dart';

@immutable
sealed class NotificationState extends Equatable {
  @override
  List<Object> get props => [];
}

final class NotificationInitialState extends NotificationState {}

final class NotificationEmptyState extends NotificationState {}

final class NotificationLoadedState extends NotificationState {
  NotificationLoadedState(
      {this.followed = const [],
      this.isBusy = false,
      this.isNotifEmpty = false});
  List<FollowItemEntity> followed;
  bool isBusy;
  bool isNotifEmpty;

  NotificationLoadedState copyWith(
      {List<FollowItemEntity>? followed, bool? isBusy, bool? isNotifEmpty}) {
    return NotificationLoadedState(
        followed: this.followed,
        isBusy: this.isBusy,
        isNotifEmpty: this.isNotifEmpty);
  }

  @override
  List<Object> get props => [followed, isBusy, isNotifEmpty];
}

final class NotificationErrorState extends NotificationState {
  NotificationErrorState(
    this.previousState,
    this.errorType,
  );

  NotificationState previousState;
  ErrorType errorType;

  @override
  List<Object> get props => [];
}
