import 'dart:async';

import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:youscribe/core/entities/audio_info_entity.dart';
import 'package:youscribe/core/entities/base/base_entity.dart';
import 'package:youscribe/core/entities/product_catalog_presentation_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';

abstract class ProductRepository extends BaseRepository {
  Future<ProductEntity> getProduct(
      int id, void Function(ProductEntity?)? onPreloaded,
      [bool checkInternetCo = false]);
  Future<int?> getNextProduct(int currentProductId);
  FutureOr<List<ProductEntity>> readFavoriteProducts(int userId,
      {int take = 20, int skip = 0});
  FutureOr<List<ProductEntity>> readOfflineProducts(int userId,
      {int take = 20, int skip = 0});
  FutureOr<List<ProductEntity>> getLastReadingProducts(
      int userId, String trackingId);
  Future<void> removeFromFavorites(int productId);
  Future<void> removeFromOfflines(int productId);
  FutureOr<List<ProductEntity>> readLastReadingProducts();

  Future<void> saveFavoriteProducts(List<ProductEntity> favs,
      {bool setDate = true, bool synchronized = false});
  Future<void> saveFavoriteProduct(ProductEntity fav, bool addedLocally,
      {bool setDate = true, bool synchronized = false});
  Future<void> saveOfflineProducts(List<ProductEntity> offlines,
      {bool setDate = true, bool synchronized = false});
  Future<void> saveOfflineProduct(ProductEntity offline, bool addedLocally,
      {bool setDate = true, bool synchronized = false});
  Future<void> saveLastReadProducts(List<ProductEntity> lastReads,
      {bool setDate = true, bool synchronized = false});
  Future<void> saveLastReadProduct(ProductEntity lastRead,
      {bool setDate = true, bool synchronized = false});
  Future<void> addToFavorites(int productId);
  Future<void> addToOfflines(int productId);

  Future<int> readLastReadProductsCountSinceNMinutes(int minutes);
  Future<void> removeFromOfflineProducts(int productId);
  Future<void> removeFromLastReadProducts(int productId);
  Future<void> removeFromOfflineProductsOnSynchronization(
      ProductEntity product);
  Future<void> removeFromFavoriteProductsOnSynchronization(int productId);
  Future<void> removeFromFavoriteProducts(int productId);
  Future<void> deleteProductsRemovedFromFavorites();
  Future<void> deleteProductsRemovedFromOfflines();
  Future<(bool isFavorite, bool isOffline)> readProductState(int productId);
  Future<ProductEntity?> isProductRemovedFromOfflines(int productId);
  Future<ProductEntity?> isProductRemovedFromFavorites(int productId);
  Future<bool> isProductOffline(int productId);
  Future<ProductEntity?> lastReadProductExists(int productId);
  Future<bool> hasLastReadProducts();
  Future<bool> hasFavoriteProducts();
  Future<bool> hasOfflineProducts();
  Future<bool> updateProduct(ProductEntity product);
  Future<void> updateLastReadProductDateOnSynchronization(
      int productId, DateTime date);
  Future<ProductEntity?> offlineProductExists(int productId);
  Future<ProductEntity?> favoriteProductExists(int productId);
  Future<void> addToLastRead(
      ProductEntity product, int currentUserId, String trackingId);
  Future<List<ProductEntity>> readLastReadProductsNotSyncedAndNotInList(
      List<int> productList);
  Future<List<ProductEntity>> getFavoriteProducts(int userId, int pageSize);
  Future<List<ProductEntity>> getOfflineProducts(int userId, int pageSize);
  Future<List<ProductEntity>> readLastReadProducts();
  Future<List<ProductEntity>> readOfflineProductsNotInList(
      List<int> productList);
  Future<List<ProductEntity>> readFavoriteProductsNotInList(
      List<int> productList);
  Future<List<ProductEntity>> readHomeProductSuggestions();
  Future<void> upsertHomeSuggestions(List<ProductEntity> products);
  Future<(String? url, int? documentFormatId)> getProductDownloadURL(
      int productId);
  FutureOr<List<BaseEntity>> getNewProductSuggestions(int productId,
      {int take = 6});
  FutureOr<List<ProductEntity>> getPremiumProductSuggestionsAsync(int productId,
      {int take = 6});
  Future<ProductCatalogPresentationEntity> getProductsForSelection(
      String selectionUrlName, int take, int skip);
  Future<bool> hasRightsForProduct(int productId);
  Future<AudioInfoEntity> getAudioBookInfoFromStreamingAPI(int productId);
  FutureOr<List<ProductEntity>> getProducts(List<int> id);
}
