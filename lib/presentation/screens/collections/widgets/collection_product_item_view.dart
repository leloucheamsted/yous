import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/presentation/screens/products/widgets/product_info_view.dart';
import 'package:youscribe/presentation/screens/products/widgets/simple_product_view.dart';

class CollectionItemView extends StatelessWidget {
  const CollectionItemView({required this.product, super.key});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return ProductInfoView(
      title: product.title!,
      author: product.author!,
      productWidget: SimpleProductView(
        productId: product.id!,
        productImageUrl: product.imageUrl!,
        height: 150,
        width: MediaQuery.of(context).size.width / 2,
        floatingWidgetSize: 30,
        imgBorderRadius: BorderRadius.circular(5),
        productType: product.productType,
        onProductSelected: (val) async {
          await context.pushNamed(Routes.productDetails,
              queryParameters: {Routes.productIdParamName: val.toString()});
        },
      ),
    );
  }
}
