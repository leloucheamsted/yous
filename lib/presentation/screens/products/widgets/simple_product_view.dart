import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/presentation/screens/products/widgets/base_product_widget.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/presentation/widgets/item_image_view.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

// ignore: must_be_immutable
class SimpleProductView extends StatefulWidget with BaseProductWidget {
  SimpleProductView(
      {required this.productId,
      required this.productImageUrl,
      required this.height,
      required this.width,
      required this.productType,
      required this.onProductSelected,
      this.imgBorderRadius,
      this.floatingWidgetSize,
      this.isPremium = false,
      super.key});

  final int productId;
  final String productImageUrl;
  final double height;
  final double width;
  final ProductType productType;
  final BorderRadius? imgBorderRadius;
  final double? floatingWidgetSize;

  final bool isPremium;
  Future<void> Function(int productId) onProductSelected;

  @override
  State<SimpleProductView> createState() => _SimpleProductViewState();
}

class _SimpleProductViewState extends State<SimpleProductView> {
  double _scale = 1;

  Future<void> _playScale() async {
    setState(() {
      _scale = 0.93;
    });
    await Future<void>.delayed(const Duration(milliseconds: 50));
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final premiumBannerHeight = widget.isPremium ? 35.0 : 0.0;
    final productImage = ItemImageView(
        productImageUrl: widget.productImageUrl,
        height: widget.height - premiumBannerHeight,
        borderRadius: widget.imgBorderRadius ??
            const BorderRadius.vertical(top: Radius.circular(10)),
        width: widget.width);
    if (widget.isPremium) {
      productImage.borderRadius =
          const BorderRadius.vertical(top: Radius.circular(10));
    }
    final column = Column(children: [
      Expanded(
        child: Stack(
          children: [
            productImage,
            Align(
              alignment: Alignment.bottomLeft,
              child: buildProductCategoryWidget(
                  size: widget.floatingWidgetSize ?? 45),
            ),
          ],
        ),
      ),
    ]);
    if (widget.isPremium) {
      column.children.add(
        SizedBox(
          height: premiumBannerHeight,
          width: widget.width,
          child: DecoratedBox(
              decoration: const BoxDecoration(
                  color: YouScribeColors.primaryAppColor,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10))),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.premiumBook,
                  style: const TextStyle(color: Colors.white),
                ),
              )),
        ),
      );
    }

    return GestureDetector(
      onTap: () async {
        // late final ConnectivityService connectivityService = locator();
        // if (!await connectivityService.isInternetAvailable) {
        //   if (context.mounted) {
        //     await Dialogs.displayInternetNeededAlert(context: context);
        //   }
        //   return;
        // }
        await _playScale();

        await widget.onProductSelected(widget.productId);
      },
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 10),
        child: SizedBox(
          height: widget.height,
          width: widget.width,
          child: column,
        ),
      ),
    );
  }

  Widget buildProductCategoryWidget({double size = 45}) {
    return Container(
      decoration: BoxDecoration(
        color: YouScribeColors.primaryAppColor,
        borderRadius: BorderRadius.circular(90),
      ),
      height: size,
      width: size,
      margin: const EdgeInsets.only(left: 10, bottom: 10),
      padding: const EdgeInsets.all(2),
      child: Center(
        child: FontAwesomeTextIcon(
            font: getFontAwesomeIconForCategory(),
            fontSize: size / 2,
            color: Colors.white),
      ),
    );
  }

  String getFontAwesomeIconForCategory() {
    switch (widget.productType) {
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
    }
  }
}
