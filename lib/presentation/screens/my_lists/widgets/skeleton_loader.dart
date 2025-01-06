import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/styles/youscribe_theme.dart';

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Provider.of<YouScribeTheme>(context).isDarkMode
            ? YouScribeColors.blackColor.withOpacity(0.2)
            : Colors.grey.shade300,
        highlightColor: Provider.of<YouScribeTheme>(context).isDarkMode
            ? YouScribeColors.blackColor.withOpacity(0.7)
            : Colors.grey.shade100,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(style: BorderStyle.none)),
              margin: const EdgeInsets.all(10),
              height: 150,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(style: BorderStyle.none)),
              margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
              height: 150,
            ),
          ],
        ));
  }
}
