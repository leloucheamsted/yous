import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'product_get_distribution_info.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ProductGetDistributionInfo {
  ProductGetDistributionInfo({
    this.allowComment,
    this.isAdultContent,
    this.previewNbPage,
    this.previewPercentPage,
    this.previewPage,
    this.displayMode,
  });
  factory ProductGetDistributionInfo.fromJson(Map<String, dynamic> json) =>
      _$ProductGetDistributionInfoFromJson(json);
  bool? allowComment;
  bool? isAdultContent;
  int? previewNbPage;
  int? previewPercentPage;
  String? previewPage;
  String? displayMode;

  String toJson() {
    final map = _$ProductGetDistributionInfoToJson(this);
    return jsonEncode(map);
  }
}
