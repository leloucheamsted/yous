import 'package:youscribe/core/models/base/base_model.dart';

class BaseClassificationFacetModel extends BaseModel {
  BaseClassificationFacetModel({
    this.id,
    this.name,
    this.label,
  });
  int? id;
  String? name;
  String? label;
}
