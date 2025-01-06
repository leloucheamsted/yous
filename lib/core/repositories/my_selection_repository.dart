import 'dart:async';

import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:youscribe/core/entities/my_selection_product_entity.dart';
import 'package:youscribe/core/entities/simple_library_entity.dart';

abstract class MySelectionRepository extends BaseRepository {
  FutureOr<List<SimpleLibraryEntity>> getCurrentUserSelections();
  Future<SimpleLibraryEntity> createSelection(
      String libraryName, bool isPublic);
  Future<void> addProductToMySelection(int productId, int libraryId);
  Future<void> removeProductFromMySelection(int productId, int libraryId);
  FutureOr<List<MySelectionProductEntity>> getSelectionProducts(
      int selectionId, int take, int skip);
  Future<void> deleteSelection(int libraryId);
  Future<void> updateMySelection(int libraryId, String label, bool isPublic);
}
