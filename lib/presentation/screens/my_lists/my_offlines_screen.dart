import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youscribe/presentation/blocs/my_lists/my_offlines/my_offlines_bloc.dart';
import 'package:youscribe/presentation/screens/my_lists/widgets/product_list.dart';
import 'package:youscribe/presentation/screens/my_lists/widgets/skeleton_loader.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class MyOfflinesScreen extends StatefulWidget {
  const MyOfflinesScreen(
      {required this.scrollController,
      required this.isFirstOpenMyListTab,
      required this.occurence0fflineScreen,
      super.key});
  final ScrollController scrollController;
  final bool isFirstOpenMyListTab;
  final int occurence0fflineScreen;

  @override
  State<MyOfflinesScreen> createState() => _MyOfflinesScreenState();
}

class _MyOfflinesScreenState extends State<MyOfflinesScreen> {
  bool isShowHelp = false;
  @override
  void initState() {
    isShowHelp = widget.isFirstOpenMyListTab;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyOfflinesBloc, MyOfflinesState>(
        builder: (context, state) {
      if (state is MyOfflinesLoadedState) {
        final products = state.products;
        final bloc = context.read<MyOfflinesBloc>();
        if (isShowHelp &&
            widget.occurence0fflineScreen == 1 &&
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
                        child: Text(
                            AppLocalizations.of(context)!.swipeOfflineHint,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    overflow: TextOverflow.clip,
                                    color: YouScribeColors.whiteColor))),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
            isInOfflineList: true,
            scrollController: widget.scrollController,
            onRefresh: () {
              bloc.add(RefreshMyOfflinesEvent());
            },
            hasNextPage: state.hasNextPage,
            onInfiniteScroll: () {
              bloc.add(LoadNewOfflineBooksPageEvent(products.length));
            },
            products: products);
      }

      return const SkeletonLoader();
    });
  }
}
