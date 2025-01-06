import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/simple_library_entity.dart';
import 'package:youscribe/core/use_cases/my_selections/delete_selection_use_case.dart';
import 'package:youscribe/core/use_cases/my_selections/update_selection_use_case.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'selection_list_item_state.dart';

class SelectionListItemCubit extends Cubit<SelectionListItemState>
    with Debuggable, Loggable {
  SelectionListItemCubit(this.selection) : super(SelectionListItemInitial());
  final SimpleLibraryEntity selection;

  final UpdateSelectionUseCase _updateSelectionUseCase = locator();
  final DeleteSelectionUseCase _deleteSelectionUseCase = locator();

  @override
  String get debugName => 'SelectionListItemCubit';

  Future<void> onSelectionEdit(int id, String label, bool isPublic) async {
    final parameters = UpdateMySelectionsUseCaseParameters(id, label, isPublic);
    final result = await _updateSelectionUseCase.call(parameters);
    if (result.isErr) {
      logError("Error while update the user's selection. Id: $id",
          error: result.err);
      return;
    }
    logInfo("Selection with id $id was updated");
    selection.label = label;
    emit(SelectionListItemAttributeChanged(
      label: label,
      totalCount: selection.totalCount,
      isPublic: selection.isPublic,
    ));
  }

  Future<bool> onSelectionDelete(int libraryId) async {
    final result = await _deleteSelectionUseCase.call(libraryId);
    if (result.isErr) {
      logError("Error while deleting the user's selection. Id: $libraryId",
          error: result.err);
      return false;
    }
    return true;
  }

  Future<void> onSelectionRemoveDocument() async {
    emit(SelectionListItemAttributeChanged(
      totalCount: selection.totalCount - 1,
    ));
  }
}
