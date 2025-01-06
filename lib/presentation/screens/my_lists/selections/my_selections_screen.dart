import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/simple_library_entity.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/presentation/blocs/my_lists/my_selections/my_selections_bloc.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/screens/my_lists/selections/widgets/dialog_view.dart';
import 'package:youscribe/presentation/screens/my_lists/selections/widgets/my_selection_list.dart';
import 'package:youscribe/presentation/screens/my_lists/selections/widgets/my_selection_skeleton_loader.dart';
import 'package:youscribe/presentation/screens/shared/empty_view.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class MySelectionsScreen extends StatelessWidget {
  const MySelectionsScreen({required this.scrollController, super.key});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MySelectionsBloc, MySelectionsState>(
        builder: (_, state) {
      if (state is MySelectionsExceptionState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Dialogs.displayGeneralAPIErrorAlert(context: context);
        });
      }

      if (state is MySelectionsLoadedState) {
        final selections = state.mySelections;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            MySelectionListView(
              scrollController: scrollController,
              refresh: () => _refresh(context),
              mySelections: selections,
            ),
            SizedBox(
              child: state.isLoading!
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: YouScribeColors.primaryAppColor,
                      ),
                    )
                  : null,
            ),
            _floatingAddButton(context),
          ],
        );
      }
      if (state is MySelectionsEmptyState) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            const Center(
              child: EmptyView(message: ""),
            ),
            _floatingAddButton(context),
          ],
        );
      }
      return const MySelectionSkeletonLoading();
    });
  }

  Future<void> _createSelection(
      BuildContext context, String name, bool isPublic) async {
    final ConnectivityService connectivityService = locator();
    if (!await connectivityService.isInternetAvailable) {
      if (context.mounted) {
        await Dialogs.displayInternetNeededAlert(context: context);
      }
      return;
    }
    if (context.mounted) {
      context
          .read<MySelectionsBloc>()
          .add(CreateSelectionsEvent(name, isPublic));
    }
  }

  void _refresh(BuildContext context) {
    context.read<MySelectionsBloc>().add(RefreshMySelectionsEvent());
  }

  Widget _floatingAddButton(BuildContext context) {
    return Positioned(
      bottom: Platform.isIOS ? 140 : 100,
      right: 10,
      child: Ink(
        decoration: BoxDecoration(
            color: YouScribeColors.primaryAppColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(60)),
        child: InkWell(
          onTap: () {
            MySelectionDialogView.addSelection(
                context: context,
                selection: SimpleLibraryEntity(),
                onCreate: (name, isPublic) =>
                    _createSelection(context, name, isPublic));
          },
          borderRadius: BorderRadius.circular(60),
          child: Container(
            height: 60,
            width: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: YouScribeColors.primaryAppColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(60),
            ),
            child: const FontAwesomeTextIcon(
                font: FontIcons.fontAwesomePlus,
                fontSize: 30,
                color: YouScribeColors.whiteColor),
          ),
        ),
      ),
    );
  }
}
