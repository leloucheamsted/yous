import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'bookmark_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class BookmarkModel {
  BookmarkModel({
    required this.id,
    required this.productId,
    required this.idRef,
    required this.note,
    required this.contentCFI,
    required this.date,
    required this.progress,
    required this.pageNumber,
    this.type = AccountBookmarkType.auto,
  });
  factory BookmarkModel.fromJson(Map<String, dynamic> json) =>
      _$BookmarkModelFromJson(json);
  int id;
  int productId;
  String? idRef;
  String? note;
  String? contentCFI;
  DateTime date;
  double progress;
  int pageNumber;
  AccountBookmarkType type;

  String toJson() {
    final map = _$BookmarkModelToJson(this);
    return jsonEncode(map);
  }
}

enum AccountBookmarkType {
  @JsonValue(0)
  auto,
  @JsonValue(1)
  user
}
