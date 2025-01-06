import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youscribe/presentation/blocs/my_lists/my_favorites/my_favorites_bloc.dart';
import 'package:youscribe/presentation/screens/my_lists/widgets/product_list.dart';
import 'package:youscribe/presentation/screens/my_lists/widgets/skeleton_loader.dart';
import 'package:youscribe/presentation/screens/shared/empty_view.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class MyFavoritesScreen extends StatefulWidget {
  const MyFavoritesScreen(
      {required this.scrollController,
      required this.isFirstOpenMyListTab,
      required this.isFirstOpenTab,
      required this.occurenceFavoriteScreen,
      super.key});
  final ScrollController scrollController;
  final bool isFirstOpenMyListTab;
  final bool isFirstOpenTab;
  final int occurenceFavoriteScreen;

  @override
  State<MyFavoritesScreen> createState() => _MyFavoritesScreenState();
}

class _MyFavoritesScreenState extends State<MyFavoritesScreen> {
  bool isShowHelp = false;
  @override
  void initState() {
    isShowHelp = widget.isFirstOpenMyListTab;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyFavoritesBloc, MyFavoritesState>(
        builder: (context, state) {
      if (state is MyFavoritesLoadedState) {
        final bloc = context.read<MyFavoritesBloc>();

        final products = state.products;
        if (isShowHelp &&
            widget.occurenceFavoriteScreen == 1 &&
            !state.dontDisplaySwipeProductsListHelp) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(
                backgroundColor: YouScribeColors.accentColor,
                behavior: SnackBarBehavior.floating,
                // margin: const EdgeInsets.only(bottom: 0),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(AppLocalizations.of(context)!.swipeFavsHint,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    overflow: TextOverflow.clip,
                                    color: YouScribeColors.whiteColor))),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        bloc.onSetAccountDisplayHelpHint(true);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.donotShowThisAgain,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            overflow: TextOverflow.clip,
                            fontWeight: FontWeight.w600,
                            color: YouScribeColors.whiteColor),
                      ),
                    )
                  ],
                )));
          });
          isShowHelp = false;
        }
        return ProductsListView(
          isInFavoriteList: true,
          scrollController: widget.scrollController,
          onRefresh: () {
            bloc.add(RefreshMyFavoritesEvent());
          },
          hasNextPage: state.hasNextPage,
          onInfiniteScroll: () {
            bloc.add(LoadNewFavoriteBooksPageEvent(products.length));
          },
          products: products,
        );
      }
      if (state is MyFavoritesEmptyState) {
        return const Center(
          child: EmptyView(message: ""),
        );
      }

      return const SkeletonLoader();
    });
  }
}
