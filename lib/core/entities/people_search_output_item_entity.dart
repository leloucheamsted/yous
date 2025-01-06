import 'package:youscribe/core/models/base/base_model.dart';
import 'package:youscribe/core/models/responses/people_search_output_item_model.dart';

class PeopleSearchOutputItemEntity extends BaseModel {
  PeopleSearchOutputItemEntity.fromModel(PeopleSearchOutputItemModel model) {
    id = model.id;
    name = model.name;
    pertinenceWeight = model.pertinenceWeight;
    if (model.thumbnails?.isNotEmpty ?? false) {
      image = model.thumbnails?.first.thumbnailUrlL;
    }
  }

  int? id;
  String? name;
  double? pertinenceWeight;
  String? image;
}
