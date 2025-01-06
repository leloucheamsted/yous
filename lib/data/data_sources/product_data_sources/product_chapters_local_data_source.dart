import 'package:youscribe/core/entities/audio_chapter_entity.dart';

abstract class ProductChaptersLocalDataSource {
  Future<List<AudioChapterEntity>> readAudioChaptersForProduct(int productId);
  Future<void> saveAudioChaptersForProduct(
      int productId, List<AudioChapterEntity> chapters);
  Future<void> deleteAudioChaptersForProduct(int productId);
}
