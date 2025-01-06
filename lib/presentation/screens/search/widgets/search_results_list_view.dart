import 'package:flutter/material.dart';
import 'package:youscribe/core/entities/collection_search_output_item_entity.dart';
import 'package:youscribe/core/entities/people_search_output_item_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/presentation/blocs/search/shared.dart';
import 'package:youscribe/presentation/screens/collections/widgets/collection_view.dart';
import 'package:youscribe/presentation/screens/products/widgets/product_info_view.dart';
import 'package:youscribe/presentation/screens/products/widgets/simple_product_view.dart';
import 'package:youscribe/presentation/widgets/item_image_view.dart';
import 'package:youscribe/styles/widget_styles.dart';

class SearchResultsListView extends StatefulWidget {
  const SearchResultsListView(
      {required this.onInfiniteScroll,
      required this.hasNextPage,
      required this.onProductSelected,
      required this.onCollectionSelected,
      required this.onAuthorSelected,
      required this.isLargeTile,
      required this.searchContext,
      required this.scrollViewController,
      this.products,
      this.collections,
      this.authors,
      super.key});

  final Future<void> Function() onInfiniteScroll;
  final bool hasNextPage;
  final List<ProductEntity>? products;
  final List<CollectionSearchOutputItemEntity>? collections;
  final List<PeopleSearchOutputItemEntity>? authors;
  final bool isLargeTile;
  final SearchContext searchContext;
  final ScrollController scrollViewController;

  final Future<void> Function(int productId) onProductSelected;
  final Future<void> Function(int collectionId, String collectionTitle)
      onCollectionSelected;
  final Future<void> Function(int authorId, String authorTitle)
      onAuthorSelected;

  @override
  State<SearchResultsListView> createState() => _SearchResultsListViewState();
}

class _SearchResultsListViewState extends State<SearchResultsListView> {

  @override
  void initState() {
    widget.scrollViewController.addListener(_onScrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: widget.isLargeTile ? 0.75 : 0.63,
      crossAxisCount: widget.isLargeTile ? 2 : 3,
      controller: widget.scrollViewController,
      primary: false,
      children: [
        ..._buildListChildren(),
        if (widget.hasNextPage)
          const Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: SizedBox(
                height: 100, child: Center(child: CircularProgressIndicator())),
          ),
      ],
    );
  }

  Iterable<Widget> _buildListChildren() {
    if (widget.searchContext == SearchContext.product &&
        widget.products != null) {
      return widget.products!.map((product) => ProductInfoView(
            title: product.title!,
            author: product.author!,
            showAuthor: true,
            productWidget: SimpleProductView(
                isPremium: product.isPremium ?? false,
                productId: product.id!,
                productImageUrl: product.imageUrl!,
                height: widget.isLargeTile ? 200 : 130,
                width: widget.isLargeTile
                    ? MediaQuery.of(context).size.width / 2
                    : MediaQuery.of(context).size.width / 3,
                floatingWidgetSize: 30,
                imgBorderRadius: BorderRadius.circular(5),
                productType: product.productType,
                onProductSelected: widget.onProductSelected),
          ));
    } else if (widget.searchContext == SearchContext.collection &&
        widget.collections != null) {
      return widget.collections!.map((collection) => Material(
          child: InkWell(
              onTap: () => widget.onCollectionSelected(
                  collection.id ?? 0, collection.title ?? ''),
              child: SizedBox(
                height: widget.isLargeTile ? 200 : 130,
                width: widget.isLargeTile
                    ? MediaQuery.of(context).size.width / 2
                    : MediaQuery.of(context).size.width / 3,
                child: CollectionView(
                    height: widget.isLargeTile ? 200 : 130,
                    width: widget.isLargeTile
                        ? MediaQuery.of(context).size.width / 2
                        : MediaQuery.of(context).size.width / 3,
                    collectioImgUrl: collection.thumbnailUrlM ?? '',
                    collectionId: collection.id ?? 0,
                    title: collection.title ?? ''),
              ))));
    } else {
      return widget.authors!.map((author) => Material(
            child: InkWell(
              onTap: () =>
                  widget.onAuthorSelected(author.id ?? 0, author.name ?? ''),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(children: [
                  Expanded(
                    child: ItemImageView(
                      height: widget.isLargeTile ? 190 : 130,
                      productImageUrl: author.image ?? '',
                      width: widget.isLargeTile
                          ? MediaQuery.of(context).size.width / 2
                          : MediaQuery.of(context).size.width / 3,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  Text(
                    author.name ?? '',
                    style: WidgetStyles.textStyle.copyWith(
                        color: Theme.of(context).textTheme.titleMedium?.color),
                  )
                ]),
              ),
            ),
          ));
    }
  }

  void _onScrollListener() {
    if (!widget.hasNextPage) {
      return;
    }
    if (widget.scrollViewController.position.pixels ==
        widget.scrollViewController.position.maxScrollExtent) {
      widget.onInfiniteScroll();
    }
  }
}
