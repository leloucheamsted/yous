import 'package:isar/isar.dart';
import 'package:youscribe/core/entities/reading_stats_entity.dart';
import 'package:youscribe/data/data_sources/base_local_data_source.dart';
import 'package:youscribe/data/data_sources/product_data_sources/reading_stat_local_data_source.dart';

class ReadingStatsLocalDataSourceImpl
    extends BaseLocalDataSource<ReadingStatsEntity>
    implements ReadingStatsLocalDataSource {
  ReadingStatsLocalDataSourceImpl(super.isar);

  @override
  Future<void> deleteEveryStat() {
    return currentCollection.clear();
  }

  @override
  Future<List<ReadingStatsEntity>> retrieveEveryStat() {
    return currentCollection.filter().productIdGreaterThan(-1).findAll();
  }

  @override
  Future<void> saveStat(int productId, ReadingStatsEntity stat) {
    return isar.writeTxn(() async {
      final pStat = await currentCollection
          .filter()
          .productIdEqualTo(productId)
          .findFirst();

      if (pStat != null) {
        await currentCollection.put(stat.copyWith(localId: stat.localId));
      } else {
        await currentCollection.put(stat.copyWith(productId: productId));
      }
    });
  }
}
