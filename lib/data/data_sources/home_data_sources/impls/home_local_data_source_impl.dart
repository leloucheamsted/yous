import 'package:isar/isar.dart';
import 'package:youscribe/core/entities/collection_search_output_item_entity.dart';
import 'package:youscribe/core/entities/home_entity.dart';
import 'package:youscribe/data/data_sources/base_local_data_source.dart';
import 'package:youscribe/data/data_sources/home_data_sources/home_local_data_source.dart';
import 'package:youscribe/data/data_sources/product_data_sources/product_local_data_source.dart';

class HomeLocalDataSourceImpl extends BaseLocalDataSource<HomeEntity>
    implements HomeLocalDataSource {
  HomeLocalDataSourceImpl(
      super.isar, ProductLocalDataSource productLocalDataSource)
      : _productLocalDataSource = productLocalDataSource;

  final ProductLocalDataSource _productLocalDataSource;

  @override
  Future<void> delete() async {
    return isar.writeTxn(() async {
      await currentCollection.filter().selectionsIsNotEmpty().deleteAll();
    });
  }

  @override
  Future<HomeEntity?> retrieve() async {
    final home = await currentCollection.where().findFirst();
    if (home == null) {
      return null;
    }

    for (final sel in home.selections) {
      sel.products =
          await _productLocalDataSource.readProductsForSelection(sel.id!);
    }

    return home;
  }

  @override
  Future<List<CollectionSearchOutputItemEntity>?>
      retrieveCollectionSuggestions() async {
    final home =
        await currentCollection.filter().selectionsIsEmpty().findFirst();

    if (home != null) {
      return home.collections;
    }

    return null;
  }

  @override
  Future<void> save(HomeEntity data) async {
    await _productLocalDataSource.clearProductsForSelection();
    for (final sel in data.selections) {
      await _productLocalDataSource.saveProductsForSelection(
          sel.id!, sel.products);
    }
    final home =
        await currentCollection.filter().selectionsIsNotEmpty().findFirst();

    await isar.writeTxn(() async {
      if (home == null) {
        await currentCollection.put(data);
      } else {
        await currentCollection.clear();
        await currentCollection.put(HomeEntity(
            editorials: data.editorials,
            selections: data.selections,
            //NOTE: Collections are set appart.
            collections: home.collections));
      }
    });
  }

  @override
  Future<void> saveHomeCollectionSuggestions(
      List<CollectionSearchOutputItemEntity> collections) async {
    final home =
        await currentCollection.filter().selectionsIsEmpty().findFirst();
    if (home == null) {
      throw Exception("Home entity not found in database");
    }

    await isar.writeTxn(() async {
      home.collections = collections;
      await currentCollection.put(home);
    });
  }
}
