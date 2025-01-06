import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:youscribe/core/entities/collection_search_output_item_entity.dart';
import 'package:youscribe/core/entities/editorial_entity.dart';
import 'package:youscribe/core/entities/home_entity.dart';
import 'package:youscribe/core/entities/selection_model.dart';

abstract class HomeRepository extends BaseRepository {
  Future<(List<EditorialEntity> editorials, List<SelectionEntity> selections)>
      getHome(String language, bool shouldGetLargeImages,
          void Function(HomeEntity?)? onPreloaded);
  Future<List<CollectionSearchOutputItemEntity>?>
      retrieveCollectionSuggestions();
  Future<void> saveHomeCollectionSuggestions(
      List<CollectionSearchOutputItemEntity> collections);
  Future<void> save(HomeEntity data);
  Future<void> delete();
}
