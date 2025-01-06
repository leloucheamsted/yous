import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/presentation/blocs/my_lists/product_list_items/product_list_item_cubit.dart';
import 'package:youscribe/presentation/screens/my_lists/widgets/product_list_item_view.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class ProductsListView extends StatefulWidget {
  const ProductsListView(
      {required this.products,
      required this.onRefresh,
      required this.onInfiniteScroll,
      required this.hasNextPage,
      required this.scrollController,
      this.isInOfflineList = false,
      this.isInFavoriteList = false,
      super.key});

  final void Function() onRefresh;
  final bool hasNextPage;
  final void Function() onInfiniteScroll;
  final List<ProductEntity> products;
  final ScrollController scrollController;
  final bool isInOfflineList;
  final bool isInFavoriteList;

  @override
  State<ProductsListView> createState() => _ProductsListViewState();
}

class _ProductsListViewState extends State<ProductsListView> {
  @override
  void initState() {
    widget.scrollController.addListener(_onScrollListener);
    super.initState();
  }

  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    var totalItems = widget.products.length;

    if (widget.hasNextPage) {
      totalItems++;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: _buildRefreshView(
          ListView.builder(
            controller: widget.scrollController,
            itemCount: totalItems,
            itemBuilder: (context, index) {
              if (index == widget.products.length) {
                return const Center(
                  child: SizedBox(
                      height: 50,
                      child: Center(child: CircularProgressIndicator())),
                );
              }

              final productListItemCubit =
                  ProductListItemCubit(widget.products[index]);

              return BlocProvider.value(
                value: productListItemCubit,
                child: ProductListItemView(
                  isInOfflineList: widget.isInOfflineList,
                  isInFavoriteList: widget.isInFavoriteList,
                  cubit: productListItemCubit,
                ),
              );
            },
          ),
          _refreshController),
    );
  }

  void _onScrollListener() {
    if (!widget.hasNextPage) {
      return;
    }
    if (widget.scrollController.position.pixels ==
        widget.scrollController.position.maxScrollExtent) {
      widget.onInfiniteScroll();
    }
  }

  Widget _buildRefreshView(Widget child, RefreshController refreshController) {
    return SmartRefresher(
      scrollController: widget.scrollController,
      controller: refreshController,
      header: const WaterDropMaterialHeader(
        backgroundColor: YouScribeColors.primaryAppColor,
      ),
      onRefresh: () async {
        widget.onRefresh();
        refreshController.refreshCompleted();
      },
      child: child,
    );
  }
}
