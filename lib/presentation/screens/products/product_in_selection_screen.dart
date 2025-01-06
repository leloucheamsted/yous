import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:readmore/readmore.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe/presentation/blocs/products/in_selection/products_in_selection_bloc.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/screens/products/widgets/light_product_list_item_view.dart';
import 'package:youscribe/presentation/screens/products/widgets/light_product_list_skeleton_loader.dart';
import 'package:youscribe/presentation/screens/shared/empty_view.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/styles/youscribe_theme.dart';

class ProductInSelectionScreen extends StatefulWidget {
  const ProductInSelectionScreen({required this.selectionId, super.key});

  final String selectionId;

  @override
  State<ProductInSelectionScreen> createState() =>
      _ProductInSelectionScreenState();
}

class _ProductInSelectionScreenState extends State<ProductInSelectionScreen> {
  final RefreshController _refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 0.5,
          title: Image(
              height: 35,
              image: AssetImage(Provider.of<YouScribeTheme>(context).brand)),
        ),
        body: BlocBuilder<ProductsInSelectionBloc, ProductsInSelectionState>(
          builder: (context, state) {
            final bloc = context.read<ProductsInSelectionBloc>();

            if (state is ProductsInSelectionErrorState) {
              //We only show an error on internet not available.
              //The user doesn't care about the rest
              if (state.errorType == ErrorType.noInternet) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Dialogs.displayInternetNeededAlert(context: context);
                });
              }

              bloc.add(ErrorDisplayedEvent());
              state = state.previousState;
            }

            if (state is ProductsInSelectionLoadedState) {
              final ProductsInSelectionLoadedState currentState = state;

              if (state.products.isEmpty) {
                return SmartRefresher(
                  controller: _refreshController,
                  header: const WaterDropMaterialHeader(
                    backgroundColor: YouScribeColors.primaryAppColor,
                  ),
                  onRefresh: () async {
                    bloc.add(RefreshProductsInSelectionEvent());
                  },
                  child: EmptyView(
                      message: AppLocalizations.of(context)!.emptyListText),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        state.title,
                        style: WidgetStyles.title2TextStyle
                            .copyWith(color: YouScribeColors.accentColor),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                              child: InfiniteScrollListView(
                            products: currentState.products,
                            header: ReadMoreText(
                              state.description,
                              trimLines: 3,
                              preDataTextStyle:
                                  const TextStyle(fontWeight: FontWeight.w500),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 15),
                              colorClickableText:
                                  YouScribeColors.secondaryTextColor,
                              trimMode: TrimMode.Line,
                              trimCollapsedText:
                                  AppLocalizations.of(context)!.readMore,
                              trimExpandedText:
                                  AppLocalizations.of(context)!.readLess,
                            ),
                            hasNextPage: currentState.hasNextPage,
                            onInfiniteScroll: () {
                              context.read<ProductsInSelectionBloc>().add(
                                  ProductsInSelectionInfiniteScrollEvent());
                            },
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            return const LightProductListSkeletonLoader();
          },
        ));
  }
}

class InfiniteScrollListView extends StatefulWidget {
  const InfiniteScrollListView(
      {required this.onInfiniteScroll,
      required this.hasNextPage,
      required this.products,
      this.header,
      super.key});

  final void Function() onInfiniteScroll;
  final bool hasNextPage;
  final List<ProductEntity> products;
  final Widget? header;
  @override
  State<InfiniteScrollListView> createState() => _InfiniteScrollListViewState();
}

class _InfiniteScrollListViewState extends State<InfiniteScrollListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_onScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.hasNextPage
          ? widget.products.length + 1
          : widget.products.length,
      itemBuilder: (context, index) {
        if (index == widget.products.length) {
          return const Center(
            child: SizedBox(
                height: 50, child: Center(child: CircularProgressIndicator())),
          );
        }
        if (index == 0) {
          return Column(
            children: <Widget>[
              SizedBox(
                child: widget.header,
              ),
              Container(
                  padding: const EdgeInsets.all(5),
                  height: 140,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        color: YouScribeColors.secondaryTextColor
                            .withOpacity(0.3)),
                  ]),
                  child:
                      LightProductListItemView(product: widget.products[index]))
            ],
          );
        }
        return Container(
            padding: const EdgeInsets.all(5),
            height: 140,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  color: YouScribeColors.secondaryTextColor.withOpacity(0.3)),
            ]),
            child: LightProductListItemView(product: widget.products[index]));
      },
    );
  }

  void _onScrollListener() {
    if (!widget.hasNextPage) {
      return;
    }

    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      widget.onInfiniteScroll();
    }
  }
}
