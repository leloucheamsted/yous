import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/styles/youscribe_theme.dart';

class ClassificationsSkelethonView extends StatelessWidget {
  const ClassificationsSkelethonView({required this.facetName, super.key});
  final String facetName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ColoredBox(
            color: YouScribeColors.primaryAppColor,
            child: SizedBox(
              height: 90,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      color: YouScribeColors.primaryAppColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: InkWell(
                        onTap: () {
                          context.pop(context);
                        },
                        borderRadius: BorderRadius.circular(40),
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
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: FontAwesomeTextIcon(
                              font: FontIcons.fontAwesomeArrowLeft,
                              fontSize: 24,
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Provider.of<YouScribeTheme>(context)
                                    .isDarkMode
                                ? YouScribeColors.blackColor.withOpacity(0.2)
                                : Colors.grey.shade300,
                            highlightColor: Provider.of<YouScribeTheme>(context)
                                    .isDarkMode
                                ? YouScribeColors.blackColor.withOpacity(0.7)
                                : Colors.grey.shade100,
                            child: Material(
                                borderRadius: BorderRadius.circular(20),
                                child: const Row(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                      width: 200,
                                    )
                                  ],
                                )),
                          ),
                          // Text(
                          //   facetName,
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .titleMedium!
                          //       .copyWith(
                          //           fontWeight: FontWeight.w700,
                          //           color: YouScribeColors.whiteColor),
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Shimmer.fromColors(
                    baseColor: Provider.of<YouScribeTheme>(context).isDarkMode
                        ? YouScribeColors.blackColor.withOpacity(0.2)
                        : Colors.grey.shade300,
                    highlightColor:
                        Provider.of<YouScribeTheme>(context).isDarkMode
                            ? YouScribeColors.blackColor.withOpacity(0.7)
                            : Colors.grey.shade100,
                    child: Material(
                        borderRadius: BorderRadius.circular(20),
                        child: const Row(
                          children: [
                            Expanded(
                                child: SizedBox(
                              height: 40,
                              width: double.infinity,
                            ))
                          ],
                        )),
                  ),
                  const SizedBox(height: 40),
                  ...List.generate(15, (index) {
                    return _facetItemListView(context);
                  }),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ))
        ],
      ),
    ));
  }

  Widget _facetItemListView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(
          thickness: 1,
          height: 1,
          color: YouScribeColors.secondaryTextColor,
        ),
        const SizedBox(height: 10),
        Shimmer.fromColors(
          baseColor: Provider.of<YouScribeTheme>(context).isDarkMode
              ? YouScribeColors.blackColor.withOpacity(0.2)
              : Colors.grey.shade300,
          highlightColor: Provider.of<YouScribeTheme>(context).isDarkMode
              ? YouScribeColors.blackColor.withOpacity(0.7)
              : Colors.grey.shade100,
          child: const Material(
              child: Row(
            children: [
              Expanded(
                  child: SizedBox(
                height: 40,
                width: double.infinity,
              ))
            ],
          )),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
