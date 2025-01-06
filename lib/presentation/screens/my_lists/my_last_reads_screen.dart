// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/use_cases/downloads/download_product_usecase.dart';
import 'package:youscribe/presentation/blocs/my_lists/my_last_reads/my_last_reads_bloc.dart';
import 'package:youscribe/presentation/screens/my_lists/widgets/product_list.dart';
import 'package:youscribe/presentation/screens/my_lists/widgets/skeleton_loader.dart';
import 'package:youscribe/presentation/screens/shared/empty_view.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class MyLastReadScreen extends StatefulWidget {
  const MyLastReadScreen(
      {required this.scrollController,
      required this.isFirstOpenMyListTab,
      required this.occurenceLatReadScreen,
      super.key});
  final ScrollController scrollController;
  final bool isFirstOpenMyListTab;
  final int occurenceLatReadScreen;

  @override
  State<MyLastReadScreen> createState() => _MyLastReadScreenState();
}

class _MyLastReadScreenState extends State<MyLastReadScreen> {
  StreamSubscription<DownloadProgressWithStatus>? _downloadProgressSubscription;
  bool isShowHelp = false;
  @override
  void initState() {
    super.initState();
    isShowHelp = widget.isFirstOpenMyListTab;
    _downloadProgressSubscription = context
        .read<MyLastReadsBloc>()
        .downloadProgressStream
        .listen(_downloadProgressChanged);
  }

  @override
  void dispose() {
    _downloadProgressSubscription?.cancel();
    super.dispose();
  }

  void _downloadProgressChanged(DownloadProgressWithStatus progressData) {
    //TODO: Display appropriate views and messages to the user.
    if (progressData.state == DownloadProgressState.completed) {
    } else if (progressData.state == DownloadProgressState.failed) {
    } else if (progressData.state == DownloadProgressState.cancelled) {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyLastReadsBloc, MyLastReadsState>(
      builder: (context, state) {
        if (state is MyLastReadsLoadedState) {
          final products = state.products;
          final bloc = context.read<MyLastReadsBloc>();
          if (isShowHelp &&
              widget.occurenceLatReadScreen == 1 &&
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
                              AppLocalizations.of(context)!.swipeLastReadHint,
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
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  overflow: TextOverflow.clip,
                                  fontWeight: FontWeight.w600,
                                  color: YouScribeColors.whiteColor),
                        ),
                      )
                    ],
                  )));
            });
            //  setState(() {
            isShowHelp = false;
            // });
          }

          return ProductsListView(
              scrollController: widget.scrollController,
              onRefresh: () {
                bloc.add(RefreshMyLastReadsEvent());
              },
              hasNextPage: state.hasNextPage,
              onInfiniteScroll: () {
                //Last reads do not have infinite scroll.
              },
              products: products);
        }
        if (state is MyLastReadsEmptyState) {
          return const Center(
            child: EmptyView(message: ""),
          );
        }
        return const SkeletonLoader();
      },
    );
  }
}
