import 'package:isar/isar.dart';
import 'package:youscribe/core/entities/base/base_entity.dart';
import 'package:youscribe/core/entities/collection_search_output_item_entity.dart';
import 'package:youscribe/core/entities/editorial_entity.dart';
import 'package:youscribe/core/entities/selection_model.dart';

part 'home_entity.g.dart';

@Collection()
class HomeEntity extends BaseEntity {
  HomeEntity({
    required this.collections,
    required this.editorials,
    required this.selections,
    super.localId = 1,
  });

  List<EditorialEntity> editorials;
  List<SelectionEntity> selections;
  List<CollectionSearchOutputItemEntity> collections;
}
