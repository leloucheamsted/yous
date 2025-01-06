import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/repositories/my_selection_repository.dart';

class DeleteSelectionUseCase extends AsyncUseCase<int?, void> {
  DeleteSelectionUseCase(MySelectionRepository mySelectionRepository)
      : _selectionRepository = mySelectionRepository;

  final MySelectionRepository _selectionRepository;

  @override
  FutureOrResult<void> execute(int? params) async {
    await _selectionRepository.deleteSelection(params!);
    return const Ok(null);
  }
}
