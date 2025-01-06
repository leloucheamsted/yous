import 'package:json_annotation/json_annotation.dart';

enum CategoryType {
  @JsonValue(69)
  audioBook(69),
  @JsonValue(60)
  commic(60),
  @JsonValue(62)
  document(62),
  @JsonValue(59)
  ebook(59),
  @JsonValue(67)
  press(67),
  @JsonValue(110)
  podcasts(110),
  //NOTE: I added this one for the app only, since isar refuses nullable enums
  none(0);

  const CategoryType(this.value);
  final int value;
}
