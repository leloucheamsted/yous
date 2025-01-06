import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'edito_v3_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class EditoV3Model {
  EditoV3Model(
    this.id,
    this.title,
    this.subTitle,
    this.brandId,
    this.imageKey,
    this.imageKeyOriginalM,
    this.imageKeyOriginalS,
    this.imageKeyXL,
    this.imageKeyM,
    this.imageKeyS,
    this.imageKeyXlWebP,
    this.imageKeyMWebP,
    this.imageKeySWebP,
    this.ctaText,
    this.ctaUrl,
  );
  factory EditoV3Model.fromJson(Map<String, dynamic> json) =>
      _$EditoV3ModelFromJson(json);
  String? id;
  String? title;
  String? subTitle;
  int? brandId;
  String? imageKey;
  String? imageKeyOriginalM;
  String? imageKeyOriginalS;
  String? imageKeyXL;
  String? imageKeyM;
  String? imageKeyS;
  @JsonKey(name: 'ImageKeyXL_WebP')
  String? imageKeyXlWebP;
  @JsonKey(name: 'ImageKeyM_WebP')
  String? imageKeyMWebP;
  @JsonKey(name: 'ImageKeyS_WebP')
  String? imageKeySWebP;
  String? ctaText;
  String? ctaUrl;

  String toJson() {
    final map = _$EditoV3ModelToJson(this);
    return jsonEncode(map);
  }
}
