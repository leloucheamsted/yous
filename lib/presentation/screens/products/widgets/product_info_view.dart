import 'package:flutter/material.dart';
import 'package:youscribe/presentation/screens/products/widgets/base_product_widget.dart';
import 'package:youscribe/styles/widget_styles.dart';

class ProductInfoView extends StatefulWidget {
  const ProductInfoView(
      {required this.productWidget,
      required this.title,
      required this.author,
      this.titleFontWeight,
      this.titleTextAlign,
      super.key,
      this.showAuthor,
      this.titleColor,
      this.titleSize});

  final BaseProductWidget productWidget;
  final String title;
  final String author;
  final TextAlign? titleTextAlign;
  final bool? showAuthor;
  final Color? titleColor;
  final double? titleSize;
  final FontWeight? titleFontWeight;
  @override
  State<ProductInfoView> createState() => _ProductInfoViewState();
}

class _ProductInfoViewState extends State<ProductInfoView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: SizedBox(
        width: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            widget.productWidget as Widget,
            const SizedBox(height: 3),
            Text(
              widget.title,
              textAlign: widget.titleTextAlign,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: widget.titleSize ?? WidgetStyles.bodySize,
                  fontWeight: widget.titleFontWeight,
                  color: widget.titleColor ??
                      Theme.of(context).textTheme.titleSmall!.color),
            ),
            SizedBox(
              child: widget.showAuthor != null
                  ? Row(
                      children: [
                        Flexible(
                          child: Text(
                            widget.author,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(fontSize: WidgetStyles.caption1Size),
                          ),
                        ),
                      ],
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
