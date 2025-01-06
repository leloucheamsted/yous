import 'package:flutter/material.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class ExplorerTabItem extends StatelessWidget {
  const ExplorerTabItem(
      {required this.exploreName,
      required this.onCategorySelected,
      required this.fontIcon,
      required this.currentThemeIndex,
      required this.id,
      required this.isYsClassificationTree,
      super.key});
  final String exploreName;
  final String fontIcon;
  final int currentThemeIndex;
  final bool isYsClassificationTree;
  final int id;

  final void Function() onCategorySelected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
                width: currentThemeIndex == id ? 0 : 1,
                color: currentThemeIndex == id
                    ? Colors.transparent
                    : YouScribeColors.whiteColor)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Material(
            borderRadius: BorderRadius.circular(13),
            color: currentThemeIndex == id
                ? YouScribeColors.whiteColor.withOpacity(0.3)
                : Colors.transparent,
            child: Ink(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(13)),
              child: InkWell(
                borderRadius: BorderRadius.circular(13),
                onTap: onCategorySelected,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const SizedBox(height: 5),
                      if (isYsClassificationTree)
                        FontAwesomeTextIcon(
                            font: fontIcon,
                            fontSize: 14,
                            color: YouScribeColors.whiteColor),
                      Text(
                        exploreName.contains("Comic") ? "Comic" : exploreName,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: YouScribeColors.whiteColor,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
