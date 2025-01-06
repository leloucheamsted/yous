// ignore_for_file: lines_longer_than_80_chars
import 'dart:async';
import 'package:youscribe/core/entities/audio_info_entity.dart';
import 'package:youscribe/core/entities/base/base_entity.dart';
import 'package:youscribe/core/entities/collection_search_output_item_entity.dart';
import 'package:youscribe/core/entities/product_catalog_presentation_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/entities/reading_stats_entity.dart';

abstract class ProductRemoteDataSource {
  FutureOr<List<ProductEntity>> getFavoriteProducts(int userId,
      {int take = 20, int skip = 0});
  FutureOr<List<ProductEntity>> getOfflineProducts(int userId,
      {int take = 20, int skip = 0});
  FutureOr<List<ProductEntity>> getLastReadingProducts(
      int userId, String trackingId);
  Future<void> addToFavorites(int productId);
  Future<void> addToOfflines(int productId);
  Future<void> addToLastRead(
      int productId, int currentUserId, String trackingId);
  Future<void> removeFromFavorites(int productId);
  Future<void> removeFromOfflines(int productId);
  Future<(String? url, int? documentFormatId)> getProductDownloadURL(
      int productId);
  Future<ProductEntity> getProduct(int id);
  FutureOr<List<ProductEntity>> getProducts(List<int> id);
  Future<int?> getNextProduct(int currentProductId);
  Future<void> sendReadingStats(ReadingStatsEntity stats);
  Future<AudioInfoEntity> getAudioBookInfoFromStreamingAPI(int productId);
  FutureOr<List<BaseEntity>> getNewProductSuggestions(
      {int productId, int take = 3});
  Future<(List<ProductEntity>, List<CollectionSearchOutputItemEntity>)>
      getGleephSuggestions(String trackingId);
  Future<bool> hasRightsForProduct(int productId);
  FutureOr<List<ProductEntity>> getPremiumProductSuggestionsAsync(
      {int productId, int take = 6});

  Future<ProductCatalogPresentationEntity> getProductsForSelection(
      String selectionUrlName, int take, int skip);
}
