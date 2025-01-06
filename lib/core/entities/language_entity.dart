import 'package:youscribe/core/models/responses/language_model.dart';

class LanguageEntity {
  LanguageEntity({
    this.name,
    this.id,
    this.label,
  });
  factory LanguageEntity.fromModel(LanguageModel model) {
    return LanguageEntity(
      name: model.name,
      id: model.id,
      label: model.label,
    );
  }

  String? name;
  int? id;
  String? label;
}
