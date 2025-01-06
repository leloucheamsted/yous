import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/collection_search_output_item_entity.dart';
import 'package:youscribe/core/entities/editorial_entity.dart';
import 'package:youscribe/core/entities/home_entity.dart';
import 'package:youscribe/core/entities/selection_model.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/repositories/home_repository.dart';
import 'package:youscribe/data/data_sources/home_data_sources/home_local_data_source.dart';
import 'package:youscribe/data/data_sources/home_data_sources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({
    required HomeRemoteDataSource homeDataSource,
    required HomeLocalDataSource homeLocalDataSource,
  })  : _homeRemoteDataSource = homeDataSource,
        _homeLocalDataSource = homeLocalDataSource;

  final HomeRemoteDataSource _homeRemoteDataSource;
  final HomeLocalDataSource _homeLocalDataSource;
  final ConnectivityService _connectivityService =
      locator<ConnectivityService>();

  @override
  Future<(List<EditorialEntity>, List<SelectionEntity>)> getHome(
      String language,
      bool shouldGetLargeImages,
      void Function(HomeEntity?)? onPreloaded) async {
    final localHome = await _homeLocalDataSource.retrieve();
    if (onPreloaded != null) {
      onPreloaded.call(localHome);
    }
    if (await _connectivityService.isInternetAvailable) {
      final home =
          await _homeRemoteDataSource.getHome(language, shouldGetLargeImages);
      await _homeLocalDataSource.save(HomeEntity(
          editorials: home.$1, selections: home.$2, collections: []));
      return home;
    }

    if (localHome != null) {
      return (localHome.editorials, localHome.selections);
    }

    final List<EditorialEntity> editorials = [];
    final List<SelectionEntity> selections = [];
    return (editorials, selections);
  }

  @override
  Future<void> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  // @override
  // Future<HomeEntity?> retrieve() {
  //   return _homeLocalDataSource.retrieve();
  // }

  @override
  Future<List<CollectionSearchOutputItemEntity>?>
      retrieveCollectionSuggestions() {
    // TODO: implement retrieveCollectionSuggestions
    throw UnimplementedError();
  }

  @override
  Future<void> save(HomeEntity data) {
    return _homeLocalDataSource.save(data);
  }

  @override
  Future<void> saveHomeCollectionSuggestions(
      List<CollectionSearchOutputItemEntity> collections) {
    return _homeLocalDataSource.saveHomeCollectionSuggestions(collections);
  }
}
