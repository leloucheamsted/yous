import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/audio_chapter_model.dart';
part 'audio_info_model.g.dart';

@JsonSerializable()
class AudioInfoModel {
  AudioInfoModel({
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
  factory AudioInfoModel.fromJson(Map<String, dynamic> json) =>
      _$AudioInfoModelFromJson(json);
  int? productId;
  List<AudioChapterModel>? playlistModel;
  double? totalSize;
  double? totalDuration;
  String? thumbnail;
  String? author;
  String? title;
  bool? isExtract;
  String? narrator;
  int? nbParts;

  String toJson() {
    final map = _$AudioInfoModelToJson(this);
    return jsonEncode(map);
  }
}
