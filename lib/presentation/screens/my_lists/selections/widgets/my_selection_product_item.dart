import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/presentation/blocs/my_lists/my_selection_details/my_selection_details_bloc.dart';
import 'package:youscribe/presentation/blocs/my_lists/my_selection_details/my_selection_product/my_selection_product_cubit.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/screens/my_lists/selections/widgets/dialog_view.dart';
import 'package:youscribe/presentation/screens/products/widgets/light_product_list_item_view.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

// ignore: must_be_immutable
class MySelectionProductItem extends StatefulWidget {
  MySelectionProductItem(
      {required this.cubit, required this.selectionId, super.key});
  MySelectionProductCubit cubit;
  int selectionId;
  @override
  State<MySelectionProductItem> createState() => _MySelectionProductItemState();
}

class _MySelectionProductItemState extends State<MySelectionProductItem> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MySelectionProductCubit, MySelectionProductState>(
        bloc: widget.cubit,
        builder: (context, state) {
          final currentCubit = context.read<MySelectionProductCubit>();

          return Container(
            padding: const EdgeInsets.all(5),
            height: 140,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  color: YouScribeColors.secondaryTextColor.withOpacity(0.3)),
            ]),
            child: Dismissible(
                direction: DismissDirection.endToStart,
                background: const ColoredBox(
                  color: YouScribeColors.errorColor,
                  child: SizedBox(),
                ),
                secondaryBackground: const ColoredBox(
                  color: YouScribeColors.errorColor,
                  child: SizedBox(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: FontAwesomeTextIcon(
                            font: FontIcons.fontAwesomeDelete,
                            fontSize: 40,
                            color: YouScribeColors.whiteColor),
                      ),
                    ),
                  ),
                ),
                dismissThresholds: const <DismissDirection, double>{
                  DismissDirection.startToEnd: 0.01,
                  DismissDirection.endToStart: 0.01,
                },
                confirmDismiss: (direction) {
                  _onSwipe(context, currentCubit.selectionItem.product!.id!,
                      direction);
                  return Future.value(false);
                },
                key: Key('${currentCubit.selectionItem.product!.id}'),
                child: LightProductListItemView(
                    product: currentCubit.selectionItem.product!)),
          );
        });
  }

  Future<void> _onSwipe(
      BuildContext context, int productId, DismissDirection direction) async {
    if (direction == DismissDirection.endToStart) {
      final connectivity = locator<ConnectivityService>();
      if (!await connectivity.isInternetAvailable) {
        if (context.mounted) {
          await Dialogs.displayInternetNeededAlert(context: context);
          return;
        }
      }
      if (context.mounted) {
        final response =
            await MySelectionDialogView.deleteSelectionProductAlert(
                context: context);
        if (!response) {
          return;
        }
      }
      final isDeleted = await widget.cubit.onRemoveProduct(widget.selectionId);
      if (isDeleted) {
        // ignore: use_build_context_synchronously
        context
            .read<MySelectionDetailsBloc>()
            .add(DeleteProdutEvent(productId));
      }
    }
  }
}
