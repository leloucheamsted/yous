import 'package:flutter/material.dart';
import 'package:youscribe/core/entities/follow_item_entity.dart';
import 'package:youscribe/presentation/blocs/notifications/notification_item/notification_item_cubit.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class NotificationViewItem extends StatefulWidget {
  const NotificationViewItem(
      {required this.follow,
      required this.cubit,
      required this.notificationChecked,
      super.key});
  final FollowItemEntity follow;
  final NotificationItemCubit cubit;
  // ignore: inference_failure_on_function_return_type
  final Function(FollowItemEntity) notificationChecked;
  @override
  State<NotificationViewItem> createState() => _NotificationViewItemState();
}

class _NotificationViewItemState extends State<NotificationViewItem> {
  bool isFollow = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFollow = !isFollow;
          widget.notificationChecked(widget.follow);
        });
      },
      child: Row(
        children: [
          Checkbox(
              checkColor: YouScribeColors.accentColor.withOpacity(0.6),
              activeColor: Colors.white,
              side:
                  const BorderSide(width: 2, color: YouScribeColors.whiteColor),
              value: isFollow,
              onChanged: (value) {
                setState(() {
                  isFollow = !isFollow;
                  widget.notificationChecked(widget.follow);
                });
              }),
          Text(
            widget.follow.name!,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: YouScribeColors.whiteColor,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.clip),
          )
        ],
      ),
    );
  }
}
