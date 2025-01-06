import 'package:flutter/material.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/presentation/screens/products/widgets/simple_product_view.dart';
import 'package:youscribe/styles/widget_styles.dart';

class CollectionProductItemView extends StatelessWidget {
  const CollectionProductItemView(
      {required this.productId,
      required this.onProductSelected,
      required this.isPremium,
      required this.imgurl,
      required this.productType,
      required this.title,
      this.width,
      this.height,
      super.key});
  final int productId;
  final String imgurl;
  final String title;
  final bool isPremium;
  final double? width;
  final double? height;
  final ProductType productType;
  final void Function(int) onProductSelected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: GestureDetector(
        child: SizedBox(
          width: 120,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SimpleProductView(
                  isPremium: isPremium,
                  floatingWidgetSize: 25,
                  productId: productId,
                  productImageUrl: imgurl,
                  height: height ?? 140,
                  width: width ?? 120,
                  productType: productType,
                  onProductSelected: (val) async {
                    onProductSelected(val);
                  }),
            ),
            const SizedBox(height: 3),
            Text(
              title,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: WidgetStyles.bodySize,
                  color: Theme.of(context).textTheme.titleSmall?.color),
            ),
          ]),
        ),
      ),
    );
  }
}
