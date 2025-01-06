import 'package:flutter/material.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class AccountItem extends StatelessWidget {
  const AccountItem(
      {required this.font,
      required this.title,
      required this.callback,
      super.key});
  final String font;
  final String title;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FontAwesomeTextIcon(
                font: font,
                fontSize: 20,
                color: YouScribeColors.primaryAppColor),
            const SizedBox(width: 15),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
      ),
    );
  }
}
