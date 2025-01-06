import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/presentation/blocs/home/home_product_item/home_product_item_cubit.dart';
import 'package:youscribe/presentation/screens/products/widgets/product_info_view.dart';
import 'package:youscribe/presentation/screens/products/widgets/product_view.dart';

// ignore: must_be_immutable
class ProductListViewItem extends StatelessWidget {
  const ProductListViewItem({
    required this.product,
    required this.cubit,
    super.key,
  });
  final ProductEntity product;
  final HomeProductListItemCubit cubit;
  @override
  Widget build(BuildContext context) {
    return ProductInfoView(
      title: product.title!,
      author: product.author!,
      showAuthor: true,
      productWidget: ProductView(
        productId: product.id!,
        productImageUrl: product.imageUrl!,
        height: 130,
        width: 100,
        floatingWidgetSize: 30,
        imgBorderRadius: BorderRadius.circular(5),
        productType: product.productType,
        onProductSelected: (val) async {
          if (context.mounted) {
            await context.pushNamed(Routes.productDetails, queryParameters: {
              Routes.productIdParamName: product.id.toString(),
            });
          }
        },
        downloadProgressStream: cubit.downloadProgressStream,
      ),
    );
  }
}
