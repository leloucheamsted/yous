import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/styles/youscribe_theme.dart';

class ProductDetailsSkeleton extends StatelessWidget {
  const ProductDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    const double headerSize = 0;
    const double headerHeight = 250;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: headerSize,
          left: 0,
          right: 0,
          child: SizedBox(
            height: headerHeight > 0 ? headerHeight : 0,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: const Alignment(0, 0.2),
                          end: Alignment.topCenter,
                          colors: [
                        YouScribeColors.primaryAppColor,
                        YouScribeColors.primaryAppColor.withOpacity(0.65),
                      ])),
                )
              ],
            ),
          ),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Platform.isIOS ? 100 : 65),
                  SizedBox(
                    height: 235,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(50)),
                              child: Container(
                                height: 90,
                                color: Colors.white,
                                child: Container(
                                  height: 200,
                                  width: 100,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const FakeBox(width: 130, height: 200),
                              const SizedBox(width: 30),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(height: 25),
                                  const FakeBox(width: 200, height: 10),
                                  const SizedBox(height: 10),
                                  const FakeBox(width: 200, height: 10),
                                  const SizedBox(height: 30),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      FakeBox(width: 40, height: 40),
                                      FakeBox(width: 40, height: 40),
                                      FakeBox(width: 40, height: 40),
                                      FakeBox(width: 40, height: 40),
                                    ],
                                  ),
                                  const Spacer(),
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: const FakeBox(
                                          width: 100, height: 50)),
                                  const SizedBox(height: 20),
                                ],
                              ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        FakeBox(width: double.infinity, height: 15),
                        SizedBox(height: 8),
                        FakeBox(width: double.infinity, height: 300),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        FakeBox(width: double.infinity, height: 15),
                        SizedBox(height: 8),
                        FakeBox(width: double.infinity, height: 300),
                      ],
                    ),
                  )
                  //
                ],
              ),
            )),
        Positioned(
          top: Platform.isIOS ? 60 : 30,
          left: 10,
          child: Material(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60),
            ),
            child: InkWell(
              onTap: () {
                context.pop(context);
              },
              borderRadius: BorderRadius.circular(60),
              child: Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // color: YouScribeColors.primaryAppColor
                  //     .withOpacity(_floatingButonOpacity),
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
                    fontSize: 28,
                    color: YouScribeColors.whiteColor),
              ),
            ),
          ),
        )
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

  final double? width;
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
