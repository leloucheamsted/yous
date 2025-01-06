import 'dart:async';

import 'package:youscribe/core/entities/my_selection_product_entity.dart';
import 'package:youscribe/core/entities/simple_library_entity.dart';
import 'package:youscribe/core/models/responses/my_selection_product_model.dart';
import 'package:youscribe/core/models/responses/simple_library_model.dart';
import 'package:youscribe/core/repositories/repository_constants.dart';
import 'package:youscribe/data/data_sources/base_remote_data_source.dart';
import 'package:youscribe/data/data_sources/my_selection_data_sources/my_selection_remote_data_source.dart';

class MySelectionRemoteDataSourceImpl extends BaseRemoteDataSource
    implements MySelectionsRemoteDataSource {
  MySelectionRemoteDataSourceImpl(
      {required super.dio, required super.appSettings});

  @override
  Future<void> addProductToMySelection(int productId, int libraryId) async {
    final url =
        '${appSettings.mobileAPIUrl}/v2/library/addProductToMySelection';
    final productLibraryModel = {
      'productId': productId,
      'libraryId': libraryId,
    };
    await post(url, productLibraryModel);
  }

  @override
  Future<SimpleLibraryEntity> createSelection(
      String libraryName, bool isPublic) async {
    final body = {
      'LibraryName': libraryName,
      'IsPublic': isPublic,
    };
    final url = '${appSettings.mobileAPIUrl}/v2/library/createSelection';
    final response = await post(url, body);
    final simpleLibraryModel = SimpleLibraryModel.fromJson(response.data!);
    return SimpleLibraryEntity.fromSimpleLibraryModel(simpleLibraryModel);
  }

  @override
  Future<void> deleteSelection(int libraryId) async {
    final url =
        '${appSettings.mobileAPIUrl}/v2/library/deleteMySelection?libraryId=$libraryId';

    await delete(url);
  }

  @override
  FutureOr<List<SimpleLibraryEntity>> getCurrentUserSelections() async {
    final url =
        '${appSettings.mobileAPIUrl}/v2/library/getCurrentUserSelections';
    final headers = {
      RepositoryConstants.ysAuthHeader: await getAuthToken(),
    };
    final response = await getWithType<List<dynamic>>(url, headers: headers);
    final result = response.data;
    final List<SimpleLibraryModel> simpleLibraryModelList =
        List<SimpleLibraryModel>.from(result!.map(
                (e) => SimpleLibraryModel.fromJson(e as Map<String, dynamic>)))
            .toList();

    final List<SimpleLibraryEntity> finalResult = [];

    if (simpleLibraryModelList.isNotEmpty) {
      for (final item in simpleLibraryModelList) {
        finalResult.add(SimpleLibraryEntity.fromSimpleLibraryModel(item));
      }
    }
    return finalResult;
  }

  @override
  FutureOr<List<MySelectionProductEntity>> getSelectionProducts(
      int selectionId, int take, int skip) async {
    final url =
        '${appSettings.mobileAPIUrl}/v2/library/getSelectionById?id=$selectionId&take=$take&skip=$skip';
    final headers = {
      RepositoryConstants.ysAuthHeader: await getAuthToken(),
    };
    final response = await getWithType<List<dynamic>>(url, headers: headers);
    final mySelectionList = List<MySelectionProductModel>.from(response.data!
            .map((e) =>
                MySelectionProductModel.fromJson(e as Map<String, dynamic>)))
        .toList();
    if (mySelectionList.isNotEmpty) {
      return mySelectionList.map(MySelectionProductEntity.new).toList();
    }

    return [];
  }

  @override
  Future<void> removeProductFromMySelection(
      int productId, int libraryId) async {
    final productLibraryModel = {
      'libraryId': libraryId,
      'productId': productId,
    };

    final url =
        '${appSettings.mobileAPIUrl}/v2/library/removeProductFromMySelection';

    await post(url, productLibraryModel);
  }

  @override
  Future<void> updateMySelection(
      int libraryId, String label, bool isPublic) async {
    final productLibraryModel = {
      'LibraryId': libraryId,
      'LibraryLabel': label,
      'IsPublic': isPublic,
    };

    final url = '${appSettings.mobileAPIUrl}/v2/library/updateMySelection';

    await put(url, productLibraryModel);
  }
}
