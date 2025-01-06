import 'package:youscribe/core/entities/product_entity.dart';

abstract class ProductLocalDataSource {
  ///Removes every link between existing products and selections.
  Future<void> clearProductsForSelection();
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

  Future<List<ProductEntity>> readProductsForSelection(String selectionId);
  Future<void> saveProductsForSelection(
      String selectionId, List<ProductEntity> products);

  Future<int> readLastReadProductsCountSinceNMinutes(int minutes);
  Future<void> removeFromOfflineProducts(int productId);
  Future<void> removeFromLastReadProducts(int productId);
  Future<void> removeFromOfflineProductsOnSynchronization(
      ProductEntity product);
  Future<void> removeFromFavoriteProductsOnSynchronization(int productId);
  Future<void> removeFromFavoriteProducts(int productId);
  Future<ProductEntity?> readProduct(int id);
  Future<void> deleteProductsRemovedFromFavorites();
  Future<void> deleteProductsRemovedFromOfflines();
  Future<(bool isFavorite, bool isOffline)> readProductState(int productId);
  Future<List<ProductEntity>> readFavoriteProducts();
  Future<List<ProductEntity>> readLastReadProducts();
  Future<List<ProductEntity>> readOfflineProducts();
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
  Future<List<ProductEntity>> readLastReadProductsNotSyncedAndNotInList(
      List<int> productList);
  Future<List<ProductEntity>> readOfflineProductsNotInList(
      List<int> productList);
  Future<List<ProductEntity>> readFavoriteProductsNotInList(
      List<int> productList);
  Future<List<ProductEntity>> readHomeProductSuggestions();
  Future<void> upsertHomeSuggestions(List<ProductEntity> products);
}
