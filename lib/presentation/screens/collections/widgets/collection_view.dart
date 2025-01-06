import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/presentation/widgets/item_image_view.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class CollectionView extends StatelessWidget {
  const CollectionView(
      {required this.collectioImgUrl,
      required this.collectionId,
      required this.title,
      super.key,
      this.width,
      this.height});
  final String collectioImgUrl;
  final String title;
  final int collectionId;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (context.mounted) {
          await context.pushNamed(Routes.collectionDetails, queryParameters: {
            Routes.collectionIdParamName: collectionId.toString(),
            Routes.collectionTitleParamName: title
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: SizedBox(
          width: width ?? 118,
          height: height ?? 140,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              width: width ?? 118,
              height: height ?? 140,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: ItemImageView(
                      productImageUrl: collectioImgUrl,
                      width: width ?? 118,
                      height: height ?? 140,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                      child: ColoredBox(
                          color: YouScribeColors.accentColor,
                          child: SizedBox(
                            height: 30,
                            width: width ?? 118,
                            child: Row(
                              children: [
                                const SizedBox(width: 4),
                                const FontAwesomeTextIcon(
                                    font: FontIcons.fontAwesomeRectangleHistory,
                                    fontSize: 18,
                                    color: YouScribeColors.whiteColor),
                                const SizedBox(width: 4),
                                Text(
                                  AppLocalizations.of(context)!.collections,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: YouScribeColors.whiteColor),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 3),
            Text(
              title,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: WidgetStyles.bodySize,
                  color: Theme.of(context).textTheme.displaySmall?.color),
            ),
          ]),
        ),
      ),
    );
  }
}
