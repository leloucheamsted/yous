import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:youscribe/core/entities/simple_library_entity.dart';
import 'package:youscribe/presentation/blocs/my_lists/my_selection_list_items/selection_list_item_cubit.dart';
import 'package:youscribe/presentation/screens/my_lists/selections/widgets/my_selection_list_item_view.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class MySelectionListView extends StatefulWidget {
  const MySelectionListView(
      {required this.mySelections,
      required this.refresh,
      required this.scrollController,
      super.key});
  final List<SimpleLibraryEntity> mySelections;
  final VoidCallback refresh;
  final ScrollController scrollController;

  @override
  State<MySelectionListView> createState() => _MySelectionListViewState();
}

class _MySelectionListViewState extends State<MySelectionListView> {
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: _buildRefreshView(
          ListView.builder(
            controller: widget.scrollController,
            itemCount: widget.mySelections.length,
            itemBuilder: (context, index) {
              if (index == widget.mySelections.length) {
                return const Center(
                  child: SizedBox(
                      height: 50,
                      child: Center(child: CircularProgressIndicator())),
                );
              }
              final selection = widget.mySelections[index];
              final selectionListItemCubit =
                  SelectionListItemCubit(widget.mySelections[index]);
              return BlocProvider.value(
                  value: selectionListItemCubit,
                  child: MySelectionListItemView(
                      cubit: selectionListItemCubit,
                      imgUrl: selection.lastProduct?.imageUrl ?? ''));
            },
          ),
          _refreshController),
    );
  }

  Widget _buildRefreshView(Widget child, RefreshController refreshController) {
    return SmartRefresher(
      scrollController: widget.scrollController,
      controller: _refreshController,
      header: const WaterDropMaterialHeader(
        backgroundColor: YouScribeColors.primaryAppColor,
      ),
      onRefresh: () async {
        widget.refresh();
        _refreshController.refreshCompleted();
      },
      child: child,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
