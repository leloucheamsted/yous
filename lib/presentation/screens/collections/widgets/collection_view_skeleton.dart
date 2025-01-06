import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/styles/youscribe_theme.dart';

class CollectionViewSkeleton extends StatelessWidget {
  const CollectionViewSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const FakeBox(width: 200, height: 20),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.count(
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.96,
                crossAxisCount: 2,
                primary: false,
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  ...List.generate(8, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FakeBox(
                          height: 150,
                          width: MediaQuery.of(context).size.width / 2,
                        ),
                        const FakeBox(
                          height: 10,
                          width: 150,
                        ),
                      ],
                    );
                  })
                ]),
          ),
        ]));
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
          margin: const EdgeInsets.only(bottom: 10),
          width: width,
          height: height,
          decoration: _boxDecoration.copyWith(color: Colors.white),
          child: child,
        ));
  }
}
