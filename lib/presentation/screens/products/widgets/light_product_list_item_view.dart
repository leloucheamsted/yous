import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/presentation/screens/products/widgets/simple_product_view.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class LightProductListItemView extends StatelessWidget {
  const LightProductListItemView({required this.product, super.key});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () async {
          await context.pushNamed(Routes.productDetails, queryParameters: {
            Routes.productIdParamName: product.id.toString(),
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: SimpleProductView(
                    productId: product.id!,
                    productImageUrl: product.imageUrl!,
                    height: 150,
                    floatingWidgetSize: 30,
                    width: 90,
                    productType: product.productType,
                    onProductSelected: (value) async {
                       await context
                          .pushNamed(Routes.productDetails, queryParameters: {
                        Routes.productIdParamName: product.id.toString(),
                      });
                    }),
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.author ?? '',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 15,
                            color: YouScribeColors.secondaryTextColor),
                      ),
                      Text(
                        product.humanizedDuration,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 15,
                            color: YouScribeColors.secondaryTextColor),
                      ),
                      Text(
                        product.plainDescription ?? '',
                        maxLines: 2,
                        style: WidgetStyles.caption1TextStyle.copyWith(
                            color: YouScribeColors.secondaryTextColor),
                      ),
                      const SizedBox(height: 10),
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
