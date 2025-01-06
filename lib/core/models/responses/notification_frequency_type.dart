import 'package:json_annotation/json_annotation.dart';

enum NotificationFrequencyType {
  @JsonValue(0)
  realTime(0),
  @JsonValue(1)
  byDay(1),
  @JsonValue(2)
  byWeek(2),
  @JsonValue(3)
  never(3);

  const NotificationFrequencyType(this.value);
  final int value;
}
