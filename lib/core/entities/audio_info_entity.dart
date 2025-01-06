import 'package:youscribe/core/entities/audio_chapter_entity.dart';
import 'package:youscribe/core/entities/base/base_entity.dart';
import 'package:youscribe/core/models/responses/audio_info_model.dart';

class AudioInfoEntity extends BaseEntity {
  AudioInfoEntity({
    this.productId,
    this.playlistModel,
    this.totalSize,
    this.totalDuration,
    this.thumbnail,
    this.author,
    this.title,
    this.isExtract,
    this.narrator,
    this.nbParts,
  });
  factory AudioInfoEntity.fromModel(AudioInfoModel model) => AudioInfoEntity(
        productId: model.productId,
        playlistModel:
            model.playlistModel?.map(AudioChapterEntity.fromModel).toList(),
        totalSize: model.totalSize,
        totalDuration: model.totalDuration,
        thumbnail: model.thumbnail,
        author: model.author,
        title: model.title,
        isExtract: model.isExtract,
        narrator: model.narrator,
        nbParts: model.nbParts,
      );
  int? productId;
  List<AudioChapterEntity>? playlistModel;
  double? totalSize;
  double? totalDuration;
  String? thumbnail;
  String? author;
  String? title;
  bool? isExtract;
  String? narrator;
  int? nbParts;
}
