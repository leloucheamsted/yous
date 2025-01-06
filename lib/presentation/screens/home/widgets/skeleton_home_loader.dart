import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/styles/youscribe_theme.dart';

class SkeletonHomeLoader extends StatelessWidget {
  const SkeletonHomeLoader({
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
    return ListView(
      children: const [
        Padding(
          padding: EdgeInsets.all(8),
          child: FakeBox(
            width: double.infinity,
            height: 140,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FakeBox(width: 10, height: 10),
            SizedBox(width: 2),
            FakeBox(width: 10, height: 10),
          ],
        ),
        SizedBox(height: 10),
        SkeletonProductList(),
        SizedBox(height: 10),
        SkeletonProductList(),
        SizedBox(height: 10),
        // SkeletonProductList(),
      ],
    );
  }
}

class SkeletonHorilList extends StatelessWidget {
  const SkeletonHorilList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(
          parent: ClampingScrollPhysics(),
        ),
        children: [
          ...List.generate(5, (index) {
            return const SkeletonProduct();
          }),
        ],
      ),
    );
  }
}

class SkeletonProductList extends StatelessWidget {
  const SkeletonProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FakeBox(
                  width: MediaQuery.of(context).size.width / 1.5, height: 8),
              const FakeBox(height: 10, width: 30),
            ],
          ),
        ),
        SizedBox(
          height: 170,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(
              parent: ClampingScrollPhysics(),
            ),
            children: [
              ...List.generate(5, (index) {
                return const SkeletonProduct();
              }),
            ],
          ),
        )
      ],
    );
  }
}

class SkeletonProduct extends StatelessWidget {
  const SkeletonProduct({super.key});

  static const _boxDecoration = BoxDecoration(
    // color: Provider.of<YouScribeTheme(context) Colors.white,
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
          margin: const EdgeInsets.all(4),
          decoration: _boxDecoration.copyWith(
              color: Provider.of<YouScribeTheme>(context).isDarkMode
                  ? YouScribeColors.backgroundColorDark
                  : Colors.white),
          height: 150,
          width: 105,
        ));
  }
}

class Element extends StatelessWidget {
  const Element({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FakeBox(height: 80, width: 80, child: child),
          const SizedBox(width: 20),
          const Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FakeBox(height: 8, width: double.infinity),
                FakeBox(height: 8, width: double.infinity),
                FakeBox(height: 8, width: 200),
              ],
            ),
          ),
        ],
      ),
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
          margin: const EdgeInsets.only(bottom: 10),
          width: width,
          height: height,
          decoration: _boxDecoration.copyWith(color: Colors.white),
          child: child,
        ));
  }
}

class SkeletonHorizontalList extends StatelessWidget {
  const SkeletonHorizontalList({
    super.key,
    this.reverse = false,
    this.itemCount = 4,
    this.isHorizontal = true,
  });
  final int itemCount;
  final bool reverse;
  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Colors.black12,
              spreadRadius: 0.5,
            )
          ],
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(
            parent: ClampingScrollPhysics(),
          ),
          reverse: reverse,
          children: const [
            FakeBox(
              width: 300,
              height: 300,
            ),
          ],
        ));
  }
}
