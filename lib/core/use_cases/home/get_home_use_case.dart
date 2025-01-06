import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/editorial_entity.dart';
import 'package:youscribe/core/entities/home_entity.dart';
import 'package:youscribe/core/entities/selection_model.dart';
import 'package:youscribe/core/repositories/home_repository.dart';

class GetHomeUseCase
    extends AsyncUseCase<GetHomeUseCaseParameters, GetHomeUseCaseResults> {
  GetHomeUseCase(HomeRepository cmsRepository) : _cmsRepository = cmsRepository;

  final HomeRepository _cmsRepository;

  @override
  FutureOrResult<GetHomeUseCaseResults> execute(
      GetHomeUseCaseParameters? params) async {
    try {
      final homeProducts = await _cmsRepository.getHome(
          params!.language, params.shouldGetLargeImages, params.onPreloaded);
      return Ok(GetHomeUseCaseResults(homeProducts.$1, homeProducts.$2));
    } catch (e) {
      if (e is AppException) {
        return Err(e);
      }

      rethrow;
    }
  }
}

class GetHomeUseCaseResults {
  GetHomeUseCaseResults(this.editorials, this.selections);
  List<EditorialEntity> editorials;
  List<SelectionEntity> selections;
}

class GetHomeUseCaseParameters {
  const GetHomeUseCaseParameters(this.language, this.shouldGetLargeImages,
      [this.onPreloaded]);

  final String language;
  final bool shouldGetLargeImages;
  //This parameter is used to pass the local home entity to the bloc
  //before loading the remote one
  final void Function(HomeEntity?)? onPreloaded;
}
