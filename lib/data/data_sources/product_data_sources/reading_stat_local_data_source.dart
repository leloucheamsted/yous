import 'package:youscribe/core/entities/reading_stats_entity.dart';

abstract class ReadingStatsLocalDataSource {
  Future<void> saveStat(int productId, ReadingStatsEntity stat);
  Future<List<ReadingStatsEntity>> retrieveEveryStat();
  Future<void> deleteEveryStat();
}
