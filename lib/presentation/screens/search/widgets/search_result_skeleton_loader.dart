import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/styles/youscribe_theme.dart';
import 'package:youscribe/utilities/constants.dart';

class SearchResultSkeletonLoader extends StatelessWidget {
  const SearchResultSkeletonLoader({required this.title, super.key});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      _searchOptionsView(context),
      const SkeletonProductList()
    ]));
  }

  Widget _searchOptionsView(BuildContext context) {
    return SizedBox(
        height: 297,
        child: Stack(clipBehavior: Clip.none, children: [
          ShaderMask(
            shaderCallback: YouScribeColors.ysGradient.createShader,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImagesName.headerBackground),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const SizedBox(height: 30),

            Container(
              height: 80,
              margin: const EdgeInsets.only(top: 15, left: 15),
              alignment: Alignment.center,
              child: SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: Row(children: [
                  BackButton(
                      onPressed: () {
                        context.pop();
                      },
                      color: YouScribeColors.whiteColor),
                  Expanded(
                      child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedOpacity(
                            opacity: 1,
                            duration: const Duration(milliseconds: 250),
                            child: Text(title,
                                maxLines: 2,
                                style: WidgetStyles.title3TextStyle.copyWith(
                                    color: YouScribeColors.whiteColor)),
                          ),
                        ],
                      )
                    ],
                  )),
                  IconButton(
                    onPressed: () {},
                    icon: const FontAwesomeTextIcon(
                      fontSize: 30,
                      color: YouScribeColors.whiteColor,
                      font: FontIcons.fontAwesomeSearch,
                    ),
                  )
                ]),
              ),
            ),

            //Search options
            ClipRRect(
              borderRadius:
                  const BorderRadius.only(topLeft: Radius.circular(50)),
              child: Container(
                  padding: const EdgeInsets.only(left: 25),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 4, 0),
                      child: Column(children: [
                        //Row 1
                        Row(
                          children: [
                            Expanded(
                                child: FakeBox(
                                    width: double.infinity, height: 30)),
                            SizedBox(width: 5),
                            Expanded(
                                child: FakeBox(
                                    width: double.infinity, height: 30)),
                            SizedBox(width: 5),
                            Flexible(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FakeBox(width: 35, height: 35),
                                FakeBox(width: 35, height: 35)
                              ],
                            )),
                          ],
                        ),
                        SizedBox(height: 10),

                        //Row 2
                        Row(children: [
                          Expanded(
                              child:
                                  FakeBox(width: double.infinity, height: 30)),
                          SizedBox(width: 10),

                          Expanded(
                              child:
                                  FakeBox(width: double.infinity, height: 30)),

                          SizedBox(width: 10),

                          //Column 3 Row 2
                          Expanded(
                              child:
                                  FakeBox(width: double.infinity, height: 30)),
                        ]),

                        //Row 3
                        SizedBox(height: 10),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Row(children: [
                                    FakeBox(
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(width: 3),
                                    FakeBox(width: 100, height: 30)
                                  ]),
                                ),
                                Expanded(
                                  child: Row(children: [
                                    FakeBox(
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(width: 3),
                                    FakeBox(width: 100, height: 30)
                                  ]),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Divider(
                              color: YouScribeColors.primaryAppColor,
                              thickness: 2,
                            ),
                          ],
                        ),
                      ]),
                    ),
                  )),
            ),
            //const SizedBox(height: 10),
            // const SkeletonProductList()
          ])
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
          decoration: _boxDecoration.copyWith(
              color: Theme.of(context).scaffoldBackgroundColor),
          child: child,
        ));
  }
}

class SkeletonProductList extends StatelessWidget {
  const SkeletonProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(3, (index) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  height: 170,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...List.generate(3, (index) {
                        return const Expanded(child: SkeletonProduct());
                      })
                    ],
                  ),
                ));
          })
        ],
      ),
    );
  }
}

class SkeletonProduct extends StatelessWidget {
  const SkeletonProduct({super.key});

  static const _boxDecoration = BoxDecoration(
    // color: Provider.of<YouScribeTheme(context) Colors.white,
    borderRadius: BorderRadius.all(
      Radius.circular(8),
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
        ));
  }
}
