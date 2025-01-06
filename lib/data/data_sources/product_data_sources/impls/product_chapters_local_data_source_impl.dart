import 'package:isar/isar.dart';
import 'package:youscribe/core/entities/audio_chapter_entity.dart';
import 'package:youscribe/data/data_sources/base_local_data_source.dart';
import 'package:youscribe/data/data_sources/product_data_sources/product_chapters_local_data_source.dart';

class ProductChaptersLocalDataSourceImpl
    extends BaseLocalDataSource<AudioChapterEntity>
    implements ProductChaptersLocalDataSource {
  ProductChaptersLocalDataSourceImpl(super.isar);

  @override
  Future<void> deleteAudioChaptersForProduct(int productId) async {
    return isar.writeTxn(() async {
      await currentCollection.filter().productIdEqualTo(productId).deleteAll();
    });
  }

  @override
  Future<List<AudioChapterEntity>> readAudioChaptersForProduct(int productId) {
    return currentCollection.filter().productIdEqualTo(productId).findAll();
  }

  @override
  Future<void> saveAudioChaptersForProduct(
      int productId, List<AudioChapterEntity> chapters) {
    for (final chapter in chapters) {
      chapter.productId = productId;
    }

    return isar.writeTxn(() async {
      await currentCollection.putAll(chapters);
    });
  }
}
