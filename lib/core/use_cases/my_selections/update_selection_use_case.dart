import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/repositories/my_selection_repository.dart';

class UpdateSelectionUseCase
    extends AsyncUseCase<UpdateMySelectionsUseCaseParameters, void> {
  UpdateSelectionUseCase(MySelectionRepository mySelectionRepository)
      : _selectionRepository = mySelectionRepository;

  final MySelectionRepository _selectionRepository;

  @override
  FutureOrResult<void> execute(
      UpdateMySelectionsUseCaseParameters? params) async {
    await _selectionRepository.updateMySelection(
        params!.libraryId, params.label, params.isPublic);
    return const Ok(null);
  }
}

class UpdateMySelectionsUseCaseParameters {
  UpdateMySelectionsUseCaseParameters(
      this.libraryId, this.label, this.isPublic);
  int libraryId;
  String label;
  bool isPublic;
}
