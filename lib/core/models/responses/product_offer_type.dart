import 'package:json_annotation/json_annotation.dart';

enum ProductOfferType {
  @JsonValue(0)
  free(0),
  @JsonValue(1)
  buy(1),
  @JsonValue(2)
  subscription(2),
  @JsonValue(4)
  printOnDemand(4),
  @JsonValue(8)
  premium(8);

  const ProductOfferType(this.value);
  final int value;
}
