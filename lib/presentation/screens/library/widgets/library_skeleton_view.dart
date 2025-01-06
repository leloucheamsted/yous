
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/styles/youscribe_theme.dart';
import 'package:youscribe/utilities/constants.dart';

class LibrarySkeletonView extends StatelessWidget {
  const LibrarySkeletonView({super.key});

  @override
  Widget build(BuildContext context) {
    const double headerHeight = 180;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: headerHeight,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(ImagesName.headerBackground)),
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: const Alignment(0, 0.2),
                          end: Alignment.topCenter,
                          colors: [
                            YouScribeColors.primaryAppColor,
                            YouScribeColors.primaryAppColor.withOpacity(0.65),
                          ]),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 55),
                        Text(
                          AppLocalizations.of(context)!.explorerPageTitle,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: YouScribeColors.whiteColor,
                                  fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 45,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ...List.generate(6, (index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Container(
                                    height: 40,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                        border: Border.all(
                                            color: YouScribeColors.whiteColor)),
                                  ),
                                );
                              })
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: headerHeight - 30,
            left: 0,
            right: 0,
            child: SizedBox(
                height: MediaQuery.of(context).size.height - headerHeight,
                child: ClipRRect(
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(40)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 40),
                            Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              children: [
                                ...List.generate(12, (index) {
                                  return _explorerItemViewSkeleton(context);
                                })
                              ],
                            )
                          ],
                        ),
                      ),
                    ))),
          )
        ],
      ),
    );
  }

  Widget _explorerItemViewSkeleton(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Shimmer.fromColors(
        baseColor: Provider.of<YouScribeTheme>(context).isDarkMode
            ? YouScribeColors.blackColor.withOpacity(0.2)
            : Colors.grey.shade300,
        highlightColor: Provider.of<YouScribeTheme>(context).isDarkMode
            ? YouScribeColors.blackColor.withOpacity(0.7)
            : Colors.grey.shade100,
        child: Material(
          borderRadius: BorderRadius.circular(12),
          child: Ink(
            decoration: BoxDecoration(
              color: Provider.of<YouScribeTheme>(context).isDarkMode
                  ? YouScribeColors.backgroundColorDark
                  : const Color(0xFFf2f2f2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  height: 80,
                  width: (MediaQuery.of(context).size.width - 70) / 2,
                  child: const Column(
                    
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
