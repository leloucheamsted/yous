import 'package:youscribe/core/entities/collection_search_output_item_entity.dart';
import 'package:youscribe/core/entities/home_entity.dart';

abstract class HomeLocalDataSource {
  Future<List<CollectionSearchOutputItemEntity>?>
      retrieveCollectionSuggestions();
  Future<void> saveHomeCollectionSuggestions(
      List<CollectionSearchOutputItemEntity> collections);
  Future<void> save(HomeEntity data);
  Future<HomeEntity?> retrieve();
  Future<void> delete();
}
