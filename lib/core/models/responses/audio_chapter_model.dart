import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'audio_chapter_model.g.dart';

@JsonSerializable()
class AudioChapterModel {
  AudioChapterModel(
    this.documentId,
    this.title,
    this.orderId,
    this.chapterDuration,
  );
  factory AudioChapterModel.fromJson(Map<String, dynamic> json) =>
      _$AudioChapterModelFromJson(json);
  int? productId;
  double? chapterDuration;
  int? documentId;
  int? orderId;
  String? chapterFileName;
  String? mediaUrl;
  String? mediaRealPath;
  double? chapterRealDuration;
  String? title;
  bool? isExtract;

  String toJSon() {
    final map = _$AudioChapterModelToJson(this);
    return jsonEncode(map);
  }
}
