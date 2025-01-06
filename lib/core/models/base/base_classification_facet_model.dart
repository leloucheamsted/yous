import 'package:youscribe/core/models/base/base_model.dart';

class BaseClassificationFacetModel extends BaseModel {
  BaseClassificationFacetModel({
    required this.id,
    required this.name,
    required this.label,
  });
  int id;
  String name;
  String label;
}
