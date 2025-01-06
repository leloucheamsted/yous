import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/repositories/my_selection_repository.dart';

class RemoveProductFromSelectionUseCase
    extends AsyncUseCase<RemoveProductFromSelectionParameters, void> {
  RemoveProductFromSelectionUseCase(MySelectionRepository mySelectionRepository)
      : _selectionRepository = mySelectionRepository;

  final MySelectionRepository _selectionRepository;

  @override
  FutureOrResult<void> execute(
      RemoveProductFromSelectionParameters? params) async {
    await _selectionRepository.removeProductFromMySelection(
        params!.productId, params.selectionId);
    return const Ok(null);
  }
}

class RemoveProductFromSelectionParameters {
  RemoveProductFromSelectionParameters(
    this.productId,
    this.selectionId,
  );
  int productId;
  int selectionId;
}
