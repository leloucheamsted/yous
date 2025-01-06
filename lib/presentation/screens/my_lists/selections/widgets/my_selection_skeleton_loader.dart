import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/styles/youscribe_theme.dart';

class MySelectionSkeletonLoading extends StatelessWidget {
  const MySelectionSkeletonLoading({
    super.key,
    this.reverse = false,
    this.countElements = false,
    this.itemCount = 4,
  });
  final int itemCount;
  final bool countElements;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: [
              ...List.generate(4, (index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: FakeBox(
                    width: double.infinity,
                    height: 160,
                  ),
                );
              })
            ],
          ),
        ),
        Positioned(
            bottom: 140,
            right: 10,
            child: Shimmer.fromColors(
                baseColor: Provider.of<YouScribeTheme>(context).isDarkMode
                    ? YouScribeColors.blackColor.withOpacity(0.2)
                    : Colors.grey.shade300,
                highlightColor: Provider.of<YouScribeTheme>(context).isDarkMode
                    ? YouScribeColors.blackColor.withOpacity(0.7)
                    : Colors.grey.shade100,
                child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE2D8D7),
                      borderRadius: BorderRadius.all(
                        Radius.circular(60),
                      ),
                    )))),
      ],
    );
  }
}

class FakeBox extends StatelessWidget {
  const FakeBox({
    required this.width,
    required this.height,
    super.key,
    this.child,
  });
  final Widget? child;

  final double width;
  final double height;

  static const _boxDecoration = BoxDecoration(
    color: Color(0xFFE2D8D7),
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Provider.of<YouScribeTheme>(context).isDarkMode
            ? YouScribeColors.blackColor.withOpacity(0.2)
            : Colors.grey.shade300,
        highlightColor: Provider.of<YouScribeTheme>(context).isDarkMode
            ? YouScribeColors.blackColor.withOpacity(0.7)
            : Colors.grey.shade100,
        child: Container(
          width: width,
          height: height,
          decoration: _boxDecoration.copyWith(color: Colors.white),
          child: child,
        ));
  }
}
