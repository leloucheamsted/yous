import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/simple_library_entity.dart';
import 'package:youscribe/core/repositories/my_selection_repository.dart';

class CreateNewSelectionUseCase extends AsyncUseCase<
    CreateNewSelectionsUseCaseParameters?, SimpleLibraryEntity> {
  CreateNewSelectionUseCase(MySelectionRepository mySelectionRepository)
      : _selectionRepository = mySelectionRepository;

  final MySelectionRepository _selectionRepository;

  @override
  FutureOrResult<SimpleLibraryEntity> execute(
      CreateNewSelectionsUseCaseParameters? params) async {
    final result = await _selectionRepository.createSelection(
        params!.label, params.isPublic);
    return Ok(result);
  }
}

class CreateNewSelectionsUseCaseParameters {
  CreateNewSelectionsUseCaseParameters(this.label, this.isPublic);
  String label;
  bool isPublic;
}
