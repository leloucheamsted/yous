import 'package:flutter/material.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class SearchItemTag extends StatelessWidget {
  const SearchItemTag(
      {required this.productType, required this.title, super.key});
  final ProductType productType;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: YouScribeColors.primaryAppColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FontAwesomeTextIcon(
                  font: getFontAwesomeIconForCategory(),
                  fontSize: 15,
                  color: Colors.white),
              const SizedBox(width: 5),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: YouScribeColors.whiteColor,
                    fontWeight: FontWeight.w800),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getFontAwesomeIconForCategory() {
    switch (productType) {
      case ProductType.audioBook:
        return FontIcons.fontAwesomeHeadphonesAlt;
      case ProductType.comic:
        return FontIcons.fontAwesomeComments;
      case ProductType.document:
        return FontIcons.fontAwesomeFileAlt;
      case ProductType.book:
        return FontIcons.fontAwesomeBookOpen;
      case ProductType.podcast:
        return FontIcons.fontAwesomePodcast;
      case ProductType.news:
        return FontIcons.fontAwesomeNewsPaper;
      case ProductType.partition:
        return FontIcons.fontAwesomeFileAudio;
      default:
        return FontIcons.fontAwesomeBookOpen;
    }
  }
}
