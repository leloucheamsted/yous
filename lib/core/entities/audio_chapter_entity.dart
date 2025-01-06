import 'package:isar/isar.dart';
import 'package:youscribe/core/entities/base/base_entity.dart';
import 'package:youscribe/core/models/responses/audio_chapter_model.dart';

part 'audio_chapter_entity.g.dart';

@Collection()
class AudioChapterEntity extends BaseEntity {
  AudioChapterEntity({
    required this.productId,
    required this.documentId,
    required this.orderId,
    required this.mediaUrl,
    this.chapterDuration,
    this.chapterFileName,
    this.mediaRealPath,
    this.chapterRealDuration,
    this.title,
    this.isExtract,
  });
  factory AudioChapterEntity.fromModel(AudioChapterModel model) =>
      AudioChapterEntity(
        productId: model.productId ?? 0,
        chapterDuration: model.chapterDuration,
        documentId: model.documentId ?? 0,
        orderId: model.orderId ?? 0,
        chapterFileName: model.chapterFileName,
        mediaUrl: model.mediaUrl ?? "",
        mediaRealPath: model.mediaRealPath,
        chapterRealDuration: model.chapterRealDuration,
        title: model.title,
        isExtract: model.isExtract,
      );

  int productId;
  double? chapterDuration;
  int documentId;
  int orderId;
  String? chapterFileName;
  String mediaUrl;
  String? mediaRealPath;
  double? chapterRealDuration;
  String? title;
  bool? isExtract;
}
