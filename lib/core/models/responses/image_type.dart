import 'package:json_annotation/json_annotation.dart';

enum ImageType {
  @JsonValue(0)
  defaultImage,
  @JsonValue(1)
  s,
  @JsonValue(2)
  m,
  @JsonValue(3)
  l,
  @JsonValue(4)
  sWebP,
  @JsonValue(5)
  mWebP,
  @JsonValue(6)
  lWebP,
}
