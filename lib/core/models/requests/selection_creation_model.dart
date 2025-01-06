import 'package:json_annotation/json_annotation.dart';
part 'selection_creation_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class SelectionCreationModel {
  SelectionCreationModel({
    this.libraryName,
    this.isPublic,
  });
  factory SelectionCreationModel.fromJson(Map<String, dynamic> json) =>
      _$SelectionCreationModelFromJson(json);

  String? libraryName;
  String? isPublic;

  Map<String, dynamic> toJson() {
    return _$SelectionCreationModelToJson(this);
  }
}
