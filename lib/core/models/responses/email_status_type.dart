import 'package:json_annotation/json_annotation.dart';

enum EmailStatusType {
  @JsonValue(0)
  valid(0),
  @JsonValue(1)
  invalid(1);

  const EmailStatusType(this.value);
  final int value;
}
