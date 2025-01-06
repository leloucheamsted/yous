// ignore_for_file: inference_failure_on_function_invocation

import 'package:isar/isar.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/data/data_sources/base_local_data_source.dart';
import 'package:youscribe/data/data_sources/product_data_sources/product_local_data_source.dart';

class ProductLocalDataSourceImpl extends BaseLocalDataSource<ProductEntity>
    implements ProductLocalDataSource {
  ProductLocalDataSourceImpl(super.isar);

  @override
  Future<void> saveFavoriteProduct(ProductEntity fav, bool addedLocally,
      {bool setDate = true, bool synchronized = false}) async {
    await isar.writeTxn(() async {
      var product =
          await currentCollection.filter().idEqualTo(fav.id).findFirst();

      product ??= fav;

      product
        ..isFavorite = true
        ..dateRemovedFromFavorites = DateTime(0)
        ..favoriteSynced = synchronized;
      if (!synchronized) {
        product.favoriteAddedLocally = addedLocally;
      } else {
        product.favoriteAddedLocally = false;
      }
      if (setDate) {
        product.dateAddedToFavorites = DateTime.now();
      } else {
        product.dateAddedToFavorites = fav.dateAddedToFavorites;
      }
      product.isRemovedFromFavorites = false;
      await currentCollection.put(product);
    });
  }

  @override
  Future<void> deleteProductsRemovedFromFavorites() async {
    await isar.writeTxn(() async {
      await currentCollection
          .filter()
          .isRemovedFromFavoritesEqualTo(true)
          .deleteAll();
    });
  }

  @override
  Future<void> deleteProductsRemovedFromOfflines() async {
    await isar.writeTxn(() async {
      await currentCollection
          .filter()
          .isRemovedFromOfflineEqualTo(true)
          .deleteAll();
    });
  }

  @override
  Future<ProductEntity?> favoriteProductExists(int productId) async {
    final product = await currentCollection
        .filter()
        .idEqualTo(productId)
        .and()
        .isFavoriteEqualTo(true)
        .findFirst();
    return product;
  }

  @override
  Future<bool> hasFavoriteProducts() async {
    return await currentCollection.filter().isFavoriteEqualTo(true).count() > 0;
  }

  @override
  Future<bool> hasLastReadProducts() async {
    return await currentCollection.filter().isLastReadEqualTo(true).count() > 0;
  }

  @override
  Future<bool> hasOfflineProducts() async {
    return await currentCollection.filter().isOfflineEqualTo(true).count() > 0;
  }

  @override
  Future<bool> isProductOffline(int productId) async {
    return await currentCollection.filter().idEqualTo(productId).count() > 0;
  }

  @override
  Future<ProductEntity?> isProductRemovedFromFavorites(int productId) async {
    final product = await currentCollection
        .filter()
        .idEqualTo(productId)
        .and()
        .isRemovedFromFavoritesEqualTo(true)
        .findFirst();

    return product;
  }

  @override
  Future<ProductEntity?> isProductRemovedFromOfflines(int productId) async {
    final product = await currentCollection
        .filter()
        .idEqualTo(productId)
        .and()
        .isRemovedFromOfflineEqualTo(true)
        .findFirst();

    return product;
  }

  @override
  Future<ProductEntity?> lastReadProductExists(int productId) {
    return currentCollection
        .filter()
        .idEqualTo(productId)
        .and()
        .isLastReadEqualTo(true)
        .findFirst();
  }

  @override
  Future<ProductEntity?> offlineProductExists(int productId) {
    return currentCollection
        .filter()
        .idEqualTo(productId)
        .and()
        .isOfflineEqualTo(true)
        .findFirst();
  }

  @override
  Future<List<ProductEntity>> readFavoriteProductsNotInList(
      List<int> productList) {
    return currentCollection
        .filter()
        .isFavoriteEqualTo(true)
        .and()
        .anyOf(productList, (q, element) => q.not().idEqualTo(element))
        .findAll();
  }

  @override
  Future<List<ProductEntity>> readHomeProductSuggestions() {
    return currentCollection.filter().isHomeSuggestionEqualTo(true).findAll();
  }

  @override
  Future<List<ProductEntity>> readLastReadProductsNotSyncedAndNotInList(
      List<int> productList) {
    return currentCollection
        .filter()
        .lastReadSyncedEqualTo(false)
        .and()
        .isLastReadEqualTo(true)
        .and()
        .anyOf(productList, (q, element) => q.not().idEqualTo(element))
        .findAll();
  }

  @override
  Future<List<ProductEntity>> readOfflineProductsNotInList(
      List<int> productList) {
    return currentCollection
        .filter()
        .isOfflineEqualTo(true)
        .and()
        .anyOf(productList, (q, element) => q.not().idEqualTo(element))
        .findAll();
  }

  @override
  Future<void> removeFromFavoriteProducts(int productId) {
    return isar.writeTxn(() async {
      await currentCollection.filter().idEqualTo(productId).deleteFirst();
    });
  }

  @override
  Future<void> removeFromFavoriteProductsOnSynchronization(int productId) {
    return isar.writeTxn(() async {
      final product =
          await currentCollection.filter().idEqualTo(productId).findFirst();
      if (product != null) {
        product
          ..isFavorite = false
          ..isRemovedFromFavorites = true
          ..dateAddedToFavorites = DateTime.now();
        await currentCollection.put(product);
      }
    });
  }

  @override
  Future<void> removeFromLastReadProducts(int productId) {
    return isar.writeTxn(() async {
      await currentCollection.filter().idEqualTo(productId).deleteFirst();
    });
  }

  @override
  Future<void> removeFromOfflineProducts(int productId) {
    return isar.writeTxn(() async {
      return isar.writeTxn(() async {
        final product =
            await currentCollection.filter().idEqualTo(productId).findFirst();
        if (product != null) {
          product
            ..isOffline = false
            ..isRemovedFromOffline = true
            ..dateAddedToOfflines = DateTime.now();
          await currentCollection.put(product);
        }
      });
    });
  }

  @override
  Future<void> removeFromOfflineProductsOnSynchronization(
      ProductEntity product) async {
    return isar.writeTxn(() async {
      final p =
          await currentCollection.filter().idEqualTo(product.id).findFirst();

      if (p != null) {
        p
          ..isOffline = false
          ..isRemovedFromOffline = false
          ..dateRemovedFromOfflines = DateTime(0);

        if (!(p.isLastRead ?? false) &&
            !(p.isFavorite ?? false) &&
            !(p.isRemovedFromFavorites ?? false)) {
          await currentCollection.filter().idEqualTo(product.id).deleteFirst();
        }

        await currentCollection.put(p);
      }
    });
  }

  @override
  Future<ProductEntity?> readProduct(int id) {
    return currentCollection.filter().idEqualTo(id).findFirst();
  }

  @override
  Future<List<ProductEntity>> readFavoriteProducts() {
    return currentCollection.filter().isFavoriteEqualTo(true).findAll();
  }

  @override
  Future<List<ProductEntity>> readLastReadProducts() {
    return currentCollection.filter().isLastReadEqualTo(true).findAll();
  }

  @override
  Future<int> readLastReadProductsCountSinceNMinutes(int minutes) {
    final DateTime dateLastRead =
        DateTime.now().subtract(Duration(minutes: minutes));
    return currentCollection
        .filter()
        .isLastReadEqualTo(true)
        .and()
        .dateLastReadGreaterThan(dateLastRead)
        .count();
  }

  @override
  Future<List<ProductEntity>> readOfflineProducts() {
    return currentCollection.filter().isOfflineEqualTo(true).findAll();
  }

  @override
  Future<(bool isFavorite, bool isOffline)> readProductState(
      int productId) async {
    final product =
        await currentCollection.filter().idEqualTo(productId).findFirst();
    if (product != null) {
      return (product.isFavorite ?? false, product.isOffline ?? false);
    }

    return (false, false);
  }

  @override
  Future<void> saveFavoriteProducts(List<ProductEntity> favs,
      {bool setDate = true, bool synchronized = false}) async {
    for (final item in favs) {
      await saveFavoriteProduct(item, false,
          setDate: setDate, synchronized: synchronized);
    }
  }

  @override
  Future<void> saveLastReadProduct(ProductEntity lastRead,
      {bool setDate = true, bool synchronized = false}) async {
    await isar.writeTxn(() async {
      var product =
          await currentCollection.filter().idEqualTo(lastRead.id).findFirst();

      product = lastRead.copyWith(
          localId: product?.localId,
          isLastRead: true,
          lastReadSynced: synchronized,
          dateLastRead: setDate ? DateTime.now() : lastRead.dateLastRead,
          estimatedReadTime: lastRead.estimatedReadTime);

      await currentCollection.put(product);
    });
  }

  @override
  Future<void> saveLastReadProducts(List<ProductEntity> lastReads,
      {bool setDate = true, bool synchronized = false}) async {
    for (final item in lastReads) {
      await saveLastReadProduct(item,
          setDate: setDate, synchronized: synchronized);
    }
  }

  @override
  Future<void> saveOfflineProduct(ProductEntity offline, bool addedLocally,
      {bool setDate = true, bool synchronized = false}) async {
    await isar.writeTxn(() async {
      var product =
          await currentCollection.filter().idEqualTo(offline.id).findFirst();

      product ??= offline;

      product
        ..isOffline = true
        ..dateRemovedFromOfflines = DateTime(0)
        ..offlineSynced = synchronized;
      if (!synchronized) {
        product.offlineAddedLocally = addedLocally;
      } else {
        product.offlineAddedLocally = false;
      }
      if (setDate) {
        product.dateAddedToOfflines = DateTime.now();
      } else {
        product.dateAddedToOfflines = offline.dateAddedToOfflines;
      }
      product.isRemovedFromOffline = false;

      await currentCollection.put(product);
    });
  }

  @override
  Future<void> saveOfflineProducts(List<ProductEntity> offlines,
      {bool setDate = true, bool synchronized = false}) async {
    for (final item in offlines) {
      await saveOfflineProduct(item, false,
          setDate: setDate, synchronized: synchronized);
    }
  }

  @override
  Future<void> updateLastReadProductDateOnSynchronization(
      int productId, DateTime date) {
    return isar.writeTxn(() async {
      final product =
          await currentCollection.filter().idEqualTo(productId).findFirst();

      if (product != null) {
        product.lastReadSynced = true;
        if (product.dateLastRead == null ||
            product.dateLastRead!.isBefore(date)) {
          product.dateLastRead = date;
        }

        await currentCollection.put(product);
      }
    });
  }

  @override
  Future<bool> updateProduct(ProductEntity product) async {
    return isar.writeTxn(() async {
      return await currentCollection.put(product) > 0;
    });
  }

  @override
  Future<void> upsertHomeSuggestions(List<ProductEntity> products) {
    return isar.writeTxn(() async {
      await currentCollection
          .filter()
          .isHomeSuggestionEqualTo(true)
          .and()
          .isLastReadEqualTo(false)
          .and()
          .isFavoriteEqualTo(false)
          .and()
          .isOfflineEqualTo(false)
          .and()
          .isRemovedFromFavoritesEqualTo(false)
          .and()
          .isRemovedFromOfflineEqualTo(false)
          .deleteAll();

      for (final product in products) {
        var p =
            await currentCollection.filter().idEqualTo(product.id).findFirst();
        if (p != null) {
          p.isHomeSuggestion = true;
        } else {
          p = product;
        }

        p.isHomeSuggestion = true;
        await currentCollection.put(p);
      }
    });
  }

  @override
  Future<List<ProductEntity>> readProductsForSelection(String selectionId) {
    return currentCollection.filter().selectionIdEqualTo(selectionId).findAll();
  }

  @override
  Future<void> saveProductsForSelection(
      String selectionId, List<ProductEntity> products) {
    return isar.writeTxn(() async {
      final List<ProductEntity> prodList = [];

      for (final newProd in products) {
        final prod =
            await currentCollection.filter().idEqualTo(newProd.id).findFirst();
        if (prod != null) {
          prodList.add(prod.copyWith(selectionId: selectionId));
        } else {
          prodList.add(newProd.copyWith(selectionId: selectionId));
        }
      }

      await currentCollection.putAll(prodList);
    });
  }

  @override
  Future<void> clearProductsForSelection() {
    return isar.writeTxn(() async {
      final prods = await currentCollection
          .filter()
          .selectionIdIsNotNull()
          .or()
          .selectionIdIsNotEmpty()
          .findAll();

      final List<ProductEntity> prodList = [];
      for (final product in prods) {
        // ignore: avoid_redundant_argument_values
        prodList.add(product.copyWith(selectionId: null));
      }

      await currentCollection.putAll(prodList);
    });
  }
}
