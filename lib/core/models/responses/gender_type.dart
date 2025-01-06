import 'package:json_annotation/json_annotation.dart';

enum GenderType {
  @JsonValue(0)
  male(0),
  @JsonValue(1)
  female(1);

  const GenderType(this.value);
  final int value;
}
