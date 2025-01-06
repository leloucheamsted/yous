import 'package:json_annotation/json_annotation.dart';
part 'reading_stats_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ReadingStatsModel {
  ReadingStatsModel({
    this.fromPart,
    this.toPart,
    this.count,
    this.second,
    this.eventDate,
    this.trackingId,
    this.userId,
    this.productId,
  });
  factory ReadingStatsModel.fromJson(Map<String, dynamic> json) =>
      _$ReadingStatsModelFromJson(json);
  int? fromPart;
  int? toPart;
  int? count;
  int? second;
  DateTime? eventDate;
  String? trackingId;
  int? userId;
  int? productId;

  Map<String, dynamic> toJson() {
    final map = _$ReadingStatsModelToJson(this);
    return map;
  }
}
