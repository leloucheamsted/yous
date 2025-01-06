import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youscribe/core/entities/follow_item_entity.dart';

part 'notification_item_state.dart';

class NotificationItemCubit extends Cubit<NotificationItemState> {
  NotificationItemCubit(this.follow) : super(NotificationItemInitial());

  final FollowItemEntity follow;
}
