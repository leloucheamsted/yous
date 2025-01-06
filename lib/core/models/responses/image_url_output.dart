import 'package:json_annotation/json_annotation.dart';
import 'package:youscribe/core/models/responses/image_type.dart';

part 'image_url_output.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ImageUrlOutput {
  ImageUrlOutput({
    this.url,
    this.width,
    this.height,
    this.type,
  });
  factory ImageUrlOutput.fromJson(Map<String, dynamic> json) =>
      _$ImageUrlOutputFromJson(json);
  @JsonKey(name: 'Url')
  String? url;
  @JsonKey(name: 'Width')
  int? width;
  @JsonKey(name: 'Height')
  int? height;
  @JsonKey(name: 'Type')
  ImageType? type;

  Map<String, dynamic> toJson() {
    return _$ImageUrlOutputToJson(this);
  }
}
