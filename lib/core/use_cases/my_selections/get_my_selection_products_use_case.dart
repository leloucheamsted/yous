import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/my_selection_product_entity.dart';
import 'package:youscribe/core/repositories/my_selection_repository.dart';

class GetMySelectionProductsUseCase extends AsyncUseCase<
    GetMySelectionProductsUseCaseParameters, List<MySelectionProductEntity>> {
  GetMySelectionProductsUseCase(MySelectionRepository mySelectionRepository)
      : _selectionRepository = mySelectionRepository;

  final MySelectionRepository _selectionRepository;

  @override
  FutureOrResult<List<MySelectionProductEntity>> execute(
      GetMySelectionProductsUseCaseParameters? params) async {
    List<MySelectionProductEntity> mySelections = [];
    mySelections = await _selectionRepository.getSelectionProducts(
        params!.selectionId, params.pageSize, params.skip);
    if (mySelections.isNotEmpty) {
      return Ok(mySelections);
    }
    return Ok(mySelections);
  }
}

class GetMySelectionProductsUseCaseParameters {
  GetMySelectionProductsUseCaseParameters(
      this.selectionId, this.pageSize, this.skip);
  int selectionId;
  int pageSize;
  int skip;
}
