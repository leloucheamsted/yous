import 'dart:async';

import 'package:youscribe/core/entities/my_selection_product_entity.dart';
import 'package:youscribe/core/entities/simple_library_entity.dart';
import 'package:youscribe/core/repositories/my_selection_repository.dart';
import 'package:youscribe/data/data_sources/my_selection_data_sources/my_selection_remote_data_source.dart';

class MySelectionRepositoryImpl implements MySelectionRepository {
  MySelectionRepositoryImpl({
    required MySelectionsRemoteDataSource mySelectionsDataSource,
  }) : _mySelectionsDataSource = mySelectionsDataSource;

  final MySelectionsRemoteDataSource _mySelectionsDataSource;

  @override
  Future<void> addProductToMySelection(int productId, int libraryId) {
    return _mySelectionsDataSource.addProductToMySelection(
        productId, libraryId);
  }

  @override
  Future<SimpleLibraryEntity> createSelection(
      String libraryName, bool isPublic) {
    return _mySelectionsDataSource.createSelection(libraryName, isPublic);
  }

  @override
  Future<void> deleteSelection(int libraryId) {
    return _mySelectionsDataSource.deleteSelection(libraryId);
  }

  @override
  FutureOr<List<SimpleLibraryEntity>> getCurrentUserSelections() {
    return _mySelectionsDataSource.getCurrentUserSelections();
  }

  @override
  FutureOr<List<MySelectionProductEntity>> getSelectionProducts(
      int selectionId, int take, int skip) {
    return _mySelectionsDataSource.getSelectionProducts(
        selectionId, take, skip);
  }

  @override
  Future<void> removeProductFromMySelection(int productId, int libraryId) {
    return _mySelectionsDataSource.removeProductFromMySelection(
        productId, libraryId);
  }

  @override
  Future<void> updateMySelection(int libraryId, String label, bool isPublic) {
    return _mySelectionsDataSource.updateMySelection(
        libraryId, label, isPublic);
  }
}
