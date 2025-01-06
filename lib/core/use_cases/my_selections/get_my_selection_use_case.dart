import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/simple_library_entity.dart';
import 'package:youscribe/core/repositories/my_selection_repository.dart';

class GetMySelectionsUseCase
    extends AsyncUseCase<void, List<SimpleLibraryEntity>> {
  GetMySelectionsUseCase(MySelectionRepository mySelectionRepository)
      : _selectionRepository = mySelectionRepository;

  final MySelectionRepository _selectionRepository;

  @override
  FutureOrResult<List<SimpleLibraryEntity>> execute(void params) async {
    List<SimpleLibraryEntity> mySelections = [];
    mySelections = await _selectionRepository.getCurrentUserSelections();
    if (mySelections.isNotEmpty) {
      return Ok(mySelections);
    }
    return Ok(mySelections);
  }
}
