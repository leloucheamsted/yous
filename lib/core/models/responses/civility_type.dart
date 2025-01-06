import 'package:json_annotation/json_annotation.dart';

enum CivilityType {
  @JsonValue(0)
  mr(0),
  @JsonValue(1)
  mrs(1),
  @JsonValue(2)
  mis(2);

  const CivilityType(this.value);
  final int value;
}
