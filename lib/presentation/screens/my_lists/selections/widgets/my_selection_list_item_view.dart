// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/entities/simple_library_entity.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/presentation/blocs/my_lists/my_selection_list_items/selection_list_item_cubit.dart';
import 'package:youscribe/presentation/blocs/my_lists/my_selections/my_selections_bloc.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/screens/my_lists/selections/widgets/dialog_view.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/presentation/widgets/item_image_view.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class MySelectionListItemView extends StatefulWidget {
  const MySelectionListItemView(
      {required this.imgUrl, required this.cubit, super.key});
  final String imgUrl;
  final SelectionListItemCubit cubit;

  @override
  State<MySelectionListItemView> createState() =>
      _MySelectionListItemViewState();
}

class _MySelectionListItemViewState extends State<MySelectionListItemView> {
  @override
  void dispose() {
    widget.cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectionListItemCubit, SelectionListItemState>(
        bloc: widget.cubit,
        builder: (context, state) {
          final currentCubit = context.read<SelectionListItemCubit>();
          return Container(
            padding: const EdgeInsets.all(2),
            height: 155,
            child: Dismissible(
              dismissThresholds: const <DismissDirection, double>{
                DismissDirection.startToEnd: 0.01,
                DismissDirection.endToStart: 0.01,
              },
              key: Key('${currentCubit.selection.id}'),
              background: _slideStartToEndBackground(context),
              secondaryBackground: _slideEndToStartBackground(context),
              confirmDismiss: (direction) {
                _onSwipe(direction, context);
                return Future.value(false);
              },
              child: Card(
                child: Material(
                  child: InkWell(
                    onTap: () async {
                      if (context.mounted) {
                        await context.pushNamed(Routes.selectionDetails,
                            queryParameters: {
                              Routes.selectionIdParamName:
                                  currentCubit.selection.id.toString(),
                              Routes.selectionTitleParamName:
                                  currentCubit.selection.label
                            });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          SizedBox(
                            child: widget.imgUrl.isNotEmpty
                                ? ItemImageView(
                                    productImageUrl: widget.imgUrl,
                                    height: 155,
                                    width: 130)
                                : DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: YouScribeColors.primaryAppColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const SizedBox(
                                      height: 155,
                                      width: 130,
                                      child: Center(
                                        child: FontAwesomeTextIcon(
                                          font: FontIcons.fontAwesomeBookOpen,
                                          fontSize: 70,
                                          color: YouScribeColors.whiteColor,
                                        ),
                                      ),
                                    )),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentCubit.selection.label!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                // ignore: lines_longer_than_80_chars
                                '${currentCubit.selection.totalCount} ${AppLocalizations.of(context)!.documents}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: YouScribeColors.secondaryTextColor,
                                    ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _slideStartToEndBackground(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 10),
        alignment: Alignment.centerLeft,
        color: YouScribeColors.errorColor,
        child: const FontAwesomeTextIcon(
          font: FontIcons.fontAwesomeDelete,
          fontSize: 40,
          color: YouScribeColors.whiteColor,
        ));
  }

  void _onSwipe(DismissDirection direction, BuildContext context) {
    if (direction == DismissDirection.startToEnd) {
      _deleteSelection(context, widget.cubit.selection);
    } else {
      MySelectionDialogView.addSelection(
          context: context,
          selection: widget.cubit.selection,
          onUpdate: (selection) => {
                widget.cubit.onSelectionEdit(
                    selection.id!, selection.label!, selection.isPublic),
              });
    }
  }

  Future<void> _deleteSelection(
      BuildContext context, SimpleLibraryEntity selection) async {
    final connectivity = locator<ConnectivityService>();
    if (!await connectivity.isInternetAvailable) {
      if (context.mounted) {
        await Dialogs.displayInternetNeededAlert(context: context);
        return;
      }
    }
    if (context.mounted) {
      final response =
          await MySelectionDialogView.deleteSelectionAlert(context: context);
      if (!response) {
        return;
      }
    }
    final isDeleted = await widget.cubit.onSelectionDelete(selection.id!);
    if (isDeleted) {
      context.read<MySelectionsBloc>().add(DeleteSelectionsEvent(selection));
    }
  }

  Widget _slideEndToStartBackground(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(right: 10),
        alignment: Alignment.centerRight,
        color: YouScribeColors.accentColor,
        child: const FontAwesomeTextIcon(
          font: FontIcons.fontAwesomePenToSquare,
          fontSize: 40,
          color: YouScribeColors.whiteColor,
        ));
  }
}
