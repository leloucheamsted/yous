import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class YsBackButton extends StatelessWidget {
  const YsBackButton({this.floatingButonOpacity = 0, super.key});
  final double floatingButonOpacity;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: YouScribeColors.primaryAppColor.withOpacity(floatingButonOpacity),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(60),
      ),
      child: InkWell(
        onTap: () {
          context.pop(context);
        },
        borderRadius: BorderRadius.circular(60),
        child: Container(
          height: 40,
          width: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(60),
          ),
          child: const FontAwesomeTextIcon(
              font: FontIcons.fontAwesomeArrowLeft,
              fontSize: 24,
              color: YouScribeColors.whiteColor),
        ),
      ),
    );
  }
}
