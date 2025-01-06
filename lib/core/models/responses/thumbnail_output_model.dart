import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'thumbnail_output_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ThumbnailOutputModel {
  ThumbnailOutputModel({
    this.thumbnailUrlS,
    this.thumbnailUrlM,
    this.thumbnailUrlL,
    this.thumbnailUrlSWebP,
    this.thumbnailUrlMWebP,
    this.thumbnailUrlLWebP,
    this.isAdultContent,
  });
  factory ThumbnailOutputModel.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailOutputModelFromJson(json);
  String? thumbnailUrlS;
  String? thumbnailUrlM;
  String? thumbnailUrlL;

  @JsonKey(name: 'thumbnailUrlS_WebP')
  String? thumbnailUrlSWebP;

  @JsonKey(name: 'thumbnailUrlM_WebP')
  String? thumbnailUrlMWebP;

  @JsonKey(name: 'thumbnailUrlL_WebP')
  String? thumbnailUrlLWebP;

  bool? isAdultContent;

  String toJson() {
    final map = _$ThumbnailOutputModelToJson(this);
    return jsonEncode(map);
  }
}
