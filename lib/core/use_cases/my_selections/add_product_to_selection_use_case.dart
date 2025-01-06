import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/repositories/my_selection_repository.dart';

class AddProductToSelectionUseCase
    extends AsyncUseCase<AddProductToSelectioneUseCaseParameters, void> {
  AddProductToSelectionUseCase(MySelectionRepository mySelectionRepository)
      : _selectionRepository = mySelectionRepository;

  final MySelectionRepository _selectionRepository;

  @override
  FutureOrResult<void> execute(
      AddProductToSelectioneUseCaseParameters? params) async {
    await _selectionRepository.addProductToMySelection(
        params!.productId, params.libraryId);
    return const Ok(null);
  }
}

class AddProductToSelectioneUseCaseParameters {
  AddProductToSelectioneUseCaseParameters(this.productId, this.libraryId);
  int productId;
  int libraryId;
}
