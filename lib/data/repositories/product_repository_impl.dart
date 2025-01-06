import 'dart:async';

import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/audio_info_entity.dart';
import 'package:youscribe/core/entities/base/base_entity.dart';
import 'package:youscribe/core/entities/product_catalog_presentation_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/repositories/products_repository.dart';
import 'package:youscribe/data/data_sources/product_data_sources/product_local_data_source.dart';
import 'package:youscribe/data/data_sources/product_data_sources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({
    required ProductRemoteDataSource productRemoteDataSource,
    required ProductLocalDataSource productLocalDataSource,
  })  : _productRemoteDataSource = productRemoteDataSource,
        _productLocalDataSource = productLocalDataSource;

  final ProductRemoteDataSource _productRemoteDataSource;
  final ProductLocalDataSource _productLocalDataSource;
  final ConnectivityService _connectivityService = locator();

  @override
  Future<(String?, int?)> getProductDownloadURL(int id) async {
    return _productRemoteDataSource.getProductDownloadURL(id);
  }

  @override
  FutureOr<List<ProductEntity>> readFavoriteProducts(int userId,
      {int take = 20, int skip = 0}) async {
    return await _productLocalDataSource.readFavoriteProducts();
    // if (await _connectivityService.isInternetAvailable) {
    //   return _productRemoteDataSource.getFavoriteProducts(userId,
    //       take: take, skip: skip);
    // }
  }

  @override
  FutureOr<List<ProductEntity>> readLastReadingProducts() async {
    return _productLocalDataSource.readLastReadProducts();
  }

  @override
  FutureOr<List<ProductEntity>> readOfflineProducts(int userId,
      {int take = 20, int skip = 0}) async {
    if (await _connectivityService.isInternetAvailable) {
      return _productRemoteDataSource.getOfflineProducts(0,
          take: take, skip: skip);
    }

    final products = await _productLocalDataSource.readOfflineProducts();
    if (skip == 0) {
      return products;
    }

    return products;
  }

  @override
  Future<void> deleteProductsRemovedFromFavorites() {
    return _productLocalDataSource.deleteProductsRemovedFromFavorites();
  }

  @override
  Future<void> deleteProductsRemovedFromOfflines() {
    return _productLocalDataSource.deleteProductsRemovedFromOfflines();
  }

  @override
  Future<ProductEntity?> favoriteProductExists(int productId) {
    return _productLocalDataSource.favoriteProductExists(productId);
  }

  @override
  Future<bool> hasFavoriteProducts() {
    return _productLocalDataSource.hasFavoriteProducts();
  }

  @override
  Future<bool> hasLastReadProducts() {
    return _productLocalDataSource.hasLastReadProducts();
  }

  @override
  Future<bool> hasOfflineProducts() {
    return _productLocalDataSource.hasOfflineProducts();
  }

  @override
  Future<bool> isProductOffline(int productId) {
    return _productLocalDataSource.isProductOffline(productId);
  }

  @override
  Future<ProductEntity?> isProductRemovedFromFavorites(int productId) {
    return _productLocalDataSource.isProductRemovedFromFavorites(productId);
  }

  @override
  Future<ProductEntity?> isProductRemovedFromOfflines(int productId) {
    return _productLocalDataSource.isProductRemovedFromOfflines(productId);
  }

  @override
  Future<ProductEntity?> lastReadProductExists(int productId) {
    return _productLocalDataSource.lastReadProductExists(productId);
  }

  @override
  Future<ProductEntity?> offlineProductExists(int productId) {
    return _productLocalDataSource.offlineProductExists(productId);
  }

  @override
  Future<List<ProductEntity>> readFavoriteProductsNotInList(
      List<int> productList) {
    return _productLocalDataSource.readFavoriteProductsNotInList(productList);
  }

  @override
  Future<List<ProductEntity>> readHomeProductSuggestions() {
    return _productLocalDataSource.readHomeProductSuggestions();
  }

  @override
  Future<int> readLastReadProductsCountSinceNMinutes(int minutes) {
    return _productLocalDataSource
        .readLastReadProductsCountSinceNMinutes(minutes);
  }

  @override
  Future<List<ProductEntity>> readLastReadProductsNotSyncedAndNotInList(
      List<int> productList) {
    return _productLocalDataSource
        .readLastReadProductsNotSyncedAndNotInList(productList);
  }

  @override
  Future<List<ProductEntity>> readOfflineProductsNotInList(
      List<int> productList) {
    return _productLocalDataSource.readOfflineProductsNotInList(productList);
  }

  @override
  Future<(bool, bool)> readProductState(int productId) {
    return _productLocalDataSource.readProductState(productId);
  }

  @override
  Future<void> removeFromFavoriteProducts(int productId) async {
    await _productLocalDataSource.removeFromFavoriteProducts(productId);
    if (await _connectivityService.isInternetAvailable) {
      await _productRemoteDataSource.removeFromFavorites(productId);
    }
  }

  @override
  Future<void> removeFromFavoriteProductsOnSynchronization(int productId) {
    return _productLocalDataSource
        .removeFromFavoriteProductsOnSynchronization(productId);
  }

  @override
  Future<void> removeFromLastReadProducts(int productId) {
    return _productLocalDataSource.removeFromLastReadProducts(productId);
  }

  @override
  Future<void> removeFromOfflineProducts(int productId) async {
    await _productLocalDataSource.removeFromOfflineProducts(productId);
    if (await _connectivityService.isInternetAvailable) {
      await _productRemoteDataSource.removeFromOfflines(productId);
    }
  }

  @override
  Future<void> removeFromOfflineProductsOnSynchronization(
      ProductEntity product) {
    return _productLocalDataSource
        .removeFromOfflineProductsOnSynchronization(product);
  }

  @override
  Future<void> saveFavoriteProduct(ProductEntity fav, bool addedLocally,
      {bool setDate = true, bool synchronized = false}) async {
    await _productLocalDataSource.saveFavoriteProduct(fav, addedLocally,
        setDate: setDate, synchronized: synchronized);
    if (await _connectivityService.isInternetAvailable) {
      await _productRemoteDataSource.addToFavorites(fav.id!);
    }
  }

  @override
  Future<void> saveFavoriteProducts(List<ProductEntity> favs,
      {bool setDate = true, bool synchronized = false}) {
    return _productLocalDataSource.saveFavoriteProducts(favs,
        setDate: setDate, synchronized: synchronized);
  }

  @override
  Future<void> saveLastReadProduct(ProductEntity lastRead,
      {bool setDate = true, bool synchronized = false}) {
    return _productLocalDataSource.saveLastReadProduct(lastRead,
        setDate: setDate, synchronized: synchronized);
  }

  @override
  Future<void> saveLastReadProducts(List<ProductEntity> lastReads,
      {bool setDate = true, bool synchronized = false}) {
    return _productLocalDataSource.saveLastReadProducts(lastReads,
        setDate: setDate, synchronized: synchronized);
  }

  @override
  Future<void> saveOfflineProduct(ProductEntity offline, bool addedLocally,
      {bool setDate = true, bool synchronized = false}) async {
    await _productLocalDataSource.saveOfflineProduct(offline, addedLocally,
        setDate: setDate, synchronized: synchronized);
    if (await _connectivityService.isInternetAvailable) {
      await _productRemoteDataSource.addToOfflines(offline.id!);
    }
  }

  @override
  Future<void> saveOfflineProducts(List<ProductEntity> offlines,
      {bool setDate = true, bool synchronized = false}) {
    return _productLocalDataSource.saveOfflineProducts(offlines,
        setDate: setDate, synchronized: synchronized);
  }

  @override
  Future<void> updateLastReadProductDateOnSynchronization(
      int productId, DateTime date) {
    return _productLocalDataSource.updateLastReadProductDateOnSynchronization(
        productId, date);
  }

  @override
  Future<bool> updateProduct(ProductEntity product) {
    return _productLocalDataSource.updateProduct(product);
  }

  @override
  Future<void> upsertHomeSuggestions(List<ProductEntity> products) {
    return _productLocalDataSource.upsertHomeSuggestions(products);
  }

  @override
  Future<AudioInfoEntity> getAudioBookInfoFromStreamingAPI(int productId) =>
      _productRemoteDataSource.getAudioBookInfoFromStreamingAPI(productId);

  @override
  FutureOr<List<ProductEntity>> getLastReadingProducts(
      int userId, String trackingId) {
    return _productRemoteDataSource.getLastReadingProducts(userId, trackingId);
  }

  @override
  FutureOr<List<BaseEntity>> getNewProductSuggestions(int productId,
      {int take = 3}) {
    return _productRemoteDataSource.getNewProductSuggestions(
        productId: productId, take: take);
  }

  @override
  Future<int?> getNextProduct(int currentProductId) {
    // TODO: implement getNextProduct
    throw UnimplementedError();
  }

  @override
  FutureOr<List<ProductEntity>> getPremiumProductSuggestionsAsync(int productId,
      {int take = 6}) {
    return _productRemoteDataSource.getPremiumProductSuggestionsAsync(
        productId: productId, take: take);
  }

  @override
  Future<ProductEntity> getProduct(
      int id, void Function(ProductEntity?)? onPreloaded,
      [bool checkInternetCo = false]) async {
    final localProduct = await _productLocalDataSource.readProduct(id);

    if (onPreloaded != null) {
      if (localProduct != null) {
        onPreloaded(localProduct);
      }
    }

    if (checkInternetCo &&
        !(await _connectivityService.isInternetAvailable) &&
        localProduct != null) {
      return localProduct;
    }

    return _productRemoteDataSource.getProduct(id);
  }

  @override
  FutureOr<List<ProductEntity>> getProducts(List<int> id) {
    return _productRemoteDataSource.getProducts(id);
  }

  @override
  Future<ProductCatalogPresentationEntity> getProductsForSelection(
      String selectionUrlName, int take, int skip) {
    return _productRemoteDataSource.getProductsForSelection(
        selectionUrlName, take, skip);
  }

  @override
  Future<bool> hasRightsForProduct(int productId) {
    return _productRemoteDataSource.hasRightsForProduct(productId);
  }

  @override
  Future<void> removeFromFavorites(int productId) {
    return _productRemoteDataSource.removeFromFavorites(productId);
  }

  @override
  Future<void> removeFromOfflines(int productId) {
    return _productRemoteDataSource.removeFromOfflines(productId);
  }

  @override
  Future<void> addToLastRead(
      ProductEntity product, int currentUserId, String trackingId) async {
    await _productLocalDataSource.saveLastReadProduct(product);
    if (await _connectivityService.isInternetAvailable) {
      await _productRemoteDataSource.addToLastRead(
          product.id!, currentUserId, trackingId);
    }
  }

  @override
  Future<List<ProductEntity>> getFavoriteProducts(
      int userId, int pageSize) async {
    return _productRemoteDataSource.getFavoriteProducts(userId, take: pageSize);
  }

  @override
  Future<void> addToFavorites(int productId) {
    return _productRemoteDataSource.addToFavorites(productId);
  }

  @override
  Future<List<ProductEntity>> getOfflineProducts(
      int userId, int pageSize) async {
    return _productRemoteDataSource.getOfflineProducts(userId, take: pageSize);
  }

  @override
  Future<void> addToOfflines(int productId) {
    return _productRemoteDataSource.addToOfflines(productId);
  }

  @override
  Future<List<ProductEntity>> readLastReadProducts() {
    return _productLocalDataSource.readLastReadProducts();
  }
}
