import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

//This is an image view that will be used to display the product, collections
//and other images anywhere in the app.
// ignore: must_be_immutable
class ItemImageView extends StatelessWidget {
  ItemImageView(
      {required this.productImageUrl,
      required this.height,
      required this.width,
      this.placeholderSize,
      this.borderRadius = const BorderRadius.all(Radius.circular(10)),
      super.key});

  String productImageUrl;
  double height;
  double width;
  double? placeholderSize;
  BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final placeholderWidget = ColoredBox(
      color: YouScribeColors.primaryAppColor,
      child: Center(
          child: FontAwesomeTextIcon(
        font: FontIcons.fontAwesomeBookOpen,
        color: YouScribeColors.whiteColor,
        fontSize: placeholderSize ?? 50,
      )),
    );

    return SizedBox(
      height: height,
      width: width,
      child: PhysicalModel(
        color: Colors.transparent,
        elevation: 3,
        shadowColor: YouScribeColors.primaryAppColor,
        child: CachedNetworkImage(
          color: YouScribeColors.primaryAppColor,
          errorWidget: (context, url, error) {
            return placeholderWidget;
          },
          imageUrl: productImageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
              borderRadius: borderRadius,
            ),
          ),
          placeholder: (context, url) => ColoredBox(
              color: YouScribeColors.primaryAppColor, child: placeholderWidget),
        ),
      ),
    );
  }
}
