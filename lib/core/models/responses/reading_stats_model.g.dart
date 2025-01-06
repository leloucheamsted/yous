// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadingStatsModel _$ReadingStatsModelFromJson(Map<String, dynamic> json) =>
    ReadingStatsModel(
      fromPart: json['FromPart'] as int?,
      toPart: json['ToPart'] as int?,
      count: json['Count'] as int?,
      second: json['Second'] as int?,
      eventDate: json['EventDate'] == null
          ? null
          : DateTime.parse(json['EventDate'] as String),
      trackingId: json['TrackingId'] as String?,
      userId: json['UserId'] as int?,
      productId: json['ProductId'] as int?,
    );

Map<String, dynamic> _$ReadingStatsModelToJson(ReadingStatsModel instance) =>
    <String, dynamic>{
      'FromPart': instance.fromPart,
      'ToPart': instance.toPart,
      'Count': instance.count,
      'Second': instance.second,
      'EventDate': instance.eventDate?.toIso8601String(),
      'TrackingId': instance.trackingId,
      'UserId': instance.userId,
      'ProductId': instance.productId,
    };
