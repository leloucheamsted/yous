import 'package:flutter/material.dart';
import 'package:youscribe/core/entities/base/base_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/presentation/screens/products/widgets/collection_product_item_view.dart';
import 'package:youscribe/presentation/screens/products/widgets/see_more_button.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class ProductDetailsCollectionWidget extends StatefulWidget {
  const ProductDetailsCollectionWidget(
      {required this.title,
      required this.collections,
      required this.seeMoreAction,
      required this.onProductSelected,
      super.key});
  final String title;
  final List<BaseEntity> collections;
  final void Function() seeMoreAction;
  final void Function(int) onProductSelected;
  @override
  State<ProductDetailsCollectionWidget> createState() =>
      _ProductDetailsCollectionWidgetState();
}

class _ProductDetailsCollectionWidgetState
    extends State<ProductDetailsCollectionWidget>
    with TickerProviderStateMixin {
  late TabController collectionController;

  @override
  void initState() {
    // TODO: implement initState
    collectionController = TabController(
      length: 1,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    collectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 30,
          child: Stack(
            children: [
              Positioned(
                bottom: 1,
                right: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    height: 2,
                    thickness: 2,
                    color: YouScribeColors.secondaryTextColor.withOpacity(0.5),
                  ),
                ),
              ),
              TabBar(
                onTap: (index) {},
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                controller: collectionController,
                labelColor: YouScribeColors.primaryAppColor,
                unselectedLabelColor: YouScribeColors.secondaryTextColor,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                      width: 4, color: YouScribeColors.primaryAppColor),
                ),
                labelStyle: WidgetStyles.title3TextStyle.copyWith(
                    fontSize: WidgetStyles.bodySize,
                    fontWeight: FontWeight.w600),
                unselectedLabelStyle:
                    const TextStyle(fontSize: WidgetStyles.caption1Size),
                tabs: [
                  Tab(
                    text: widget.title,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Builder(builder: (_) {
            return SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...List.generate(widget.collections.length, (index) {
                      final product =
                          widget.collections[index] as ProductEntity;
                      return CollectionProductItemView(
                        onProductSelected: widget.onProductSelected,
                        productId: product.id!,
                        imgurl: product.imageUrl!,
                        isPremium: product.isPremium!,
                        title: product.title!,
                        productType: product.productType,
                      );
                    }),
                    SeeMoreButton(callBackAction: () => widget.seeMoreAction())
                  ],
                ));
          }),
        ),
      ],
    );
  }
}
