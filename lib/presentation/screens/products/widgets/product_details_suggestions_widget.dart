import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/entities/base/base_entity.dart';
import 'package:youscribe/core/entities/collection_search_output_item_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/presentation/screens/collections/widgets/collection_view.dart';
import 'package:youscribe/presentation/screens/products/widgets/collection_product_item_view.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class ProductDetailsSuggestionsWidget extends StatefulWidget {
  const ProductDetailsSuggestionsWidget({required this.suggestions, super.key});
  final List<BaseEntity> suggestions;
  @override
  State<ProductDetailsSuggestionsWidget> createState() =>
      _ProductDetailsSuggestionsWidgetState();
}

class _ProductDetailsSuggestionsWidgetState
    extends State<ProductDetailsSuggestionsWidget>
    with TickerProviderStateMixin {
  late TabController suggestionsController;

  @override
  void initState() {
    // TODO: implement initState
    suggestionsController = TabController(
      length: 1,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    suggestionsController.dispose();
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
                controller: suggestionsController,
                tabAlignment: TabAlignment.start,
                labelColor: YouScribeColors.primaryAppColor,
                unselectedLabelColor: YouScribeColors.secondaryTextColor,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                      width: 4, color: YouScribeColors.primaryAppColor),
                ),
                labelStyle: WidgetStyles.title3TextStyle.copyWith(
                    fontSize: WidgetStyles.title3Size,
                    fontWeight: FontWeight.w600),
                unselectedLabelStyle:
                    const TextStyle(fontSize: WidgetStyles.title3Size),
                tabs: [
                  Tab(
                    text: AppLocalizations.of(context)!.suggestionsTitle,
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
                    ...List.generate(widget.suggestions.length, (index) {
                      final suggestion = widget.suggestions[index];
                      return SizedBox(
                        child: suggestion is ProductEntity
                            ? CollectionProductItemView(
                                onProductSelected: (id) async {
                                  await context.pushNamed(Routes.productDetails,
                                      queryParameters: {
                                        Routes.productIdParamName:
                                            id.toString(),
                                      });
                                },
                                isPremium: suggestion.isPremium!,
                                productId: suggestion.id!,
                                imgurl: suggestion.imageUrl!,
                                title: suggestion.title!,
                                productType: suggestion.productType,
                              )
                            : suggestion is CollectionSearchOutputItemEntity
                                ? CollectionView(
                                    collectioImgUrl: suggestion.thumbnailUrlM!,
                                    collectionId: suggestion.id!,
                                    title: suggestion.title!,
                                  )
                                : null,
                      );
                    }),
                  ],
                ));
          }),
        ),
      ],
    );
  }
}
