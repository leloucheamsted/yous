// File Name: reading_stats_presentation_model.dart

import 'package:isar/isar.dart';
import 'package:youscribe/core/entities/base/base_entity.dart';
import 'package:youscribe/core/models/responses/reading_stats_model.dart';

part 'reading_stats_entity.g.dart';

@collection
class ReadingStatsEntity extends BaseEntity {
  ReadingStatsEntity();

  ReadingStatsEntity.fromParams({
    this.fromPart,
    this.toPart,
    this.count,
    this.second,
    this.eventDate,
    this.trackingId,
    this.userId,
    this.productId,
    super.localId,
  });

  ReadingStatsEntity.fromModel(ReadingStatsModel stats) {
    fromPart = stats.fromPart;
    toPart = stats.toPart;
    count = stats.count;
    second = stats.second;
    eventDate = stats.eventDate;
    trackingId = stats.trackingId;
    userId = stats.userId;
    productId = stats.productId;
  }

  int? fromPart;
  int? toPart;
  int? count;
  int? second;
  DateTime? eventDate;
  String? trackingId;
  int? userId;
  int? productId;

  ReadingStatsEntity copyWith({
    int? fromPart,
    int? toPart,
    int? count,
    int? second,
    DateTime? eventDate,
    String? trackingId,
    int? userId,
    int? productId,
    Id? localId,
  }) {
    return ReadingStatsEntity.fromParams(
      localId: localId ?? this.localId,
      fromPart: fromPart ?? this.fromPart,
      toPart: toPart ?? this.toPart,
      count: count ?? this.count,
      second: second ?? this.second,
      eventDate: eventDate ?? this.eventDate,
      trackingId: trackingId ?? this.trackingId,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
    );
  }

  ReadingStatsModel toModel() => ReadingStatsModel(
        fromPart: fromPart,
        toPart: toPart,
        count: count,
        second: second,
        eventDate: eventDate,
        trackingId: trackingId,
        userId: userId,
        productId: productId,
      );
      
}
