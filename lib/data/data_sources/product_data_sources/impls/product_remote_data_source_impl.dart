// ignore_for_file: use_if_null_to_convert_nulls_to_bools, lines_longer_than_80_chars, unnecessary_null_comparison

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/audio_info_entity.dart';
import 'package:youscribe/core/entities/base/base_entity.dart';
import 'package:youscribe/core/entities/collection_search_output_item_entity.dart';
import 'package:youscribe/core/entities/product_catalog_presentation_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/entities/reading_stats_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/models/responses/audio_info_model.dart';
import 'package:youscribe/core/models/responses/catalog_page_model.dart';
import 'package:youscribe/core/models/responses/favorite_model.dart';
import 'package:youscribe/core/models/responses/last_views_model.dart';
import 'package:youscribe/core/models/responses/multi_type_search_output_model.dart';
import 'package:youscribe/core/models/responses/offline_model.dart';
import 'package:youscribe/core/models/responses/product_model.dart';
import 'package:youscribe/core/models/responses/product_suggestions_result_model.dart';
import 'package:youscribe/core/models/responses/ys_product_get_model.dart';
import 'package:youscribe/core/models/utilities.dart';
import 'package:youscribe/core/repositories/repository_constants.dart';
import 'package:youscribe/data/data_sources/base_remote_data_source.dart';
import 'package:youscribe/data/data_sources/product_data_sources/product_remote_data_source.dart';

const int streamingRight = 110;

class ProductRemoteDataSourceImpl extends BaseRemoteDataSource
    implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl({
    required super.dio,
    required super.appSettings,
  });

  Future<ProductEntity> _getProductFromMainAPI(int id) async {
    final url = "${appSettings.mainYSAPIUrl}/api/v1/products/$id";
    final response = await get(url);
    final ysModel =
        YSProductGetModel.fromJson(response.data as Map<String, dynamic>);
    if (ysModel.isNull) {
      throw Exception();
    }
    final model = ProductModel.from(ysModel);
    return ProductEntity()..fromProductModel(model);
  }

  @override
  Future<(String?, int?)> getProductDownloadURL(int productId) async {
    final url =
        "${appSettings.mainYSAPIUrl}/api/v1/products/mobile/downloadlink/$productId";

    final response = await get(url, headers: {
      RepositoryConstants.ysAuthHeader:
          await AuthenticationManager.getAuthToken(),
      RepositoryConstants.contentType: RepositoryConstants.contentTypeValue,
      RepositoryConstants.userAgentHeader:
          '${appSettings.userAgent}/${RepositoryConstants.userAgentVersion}',
    });

    final results = (
      // ignore: avoid_dynamic_calls
      response.data!["Url"] as String?,
      // ignore: avoid_dynamic_calls
      response.data!["DocumentFormatId"] as int?
    );

    return results;
  }

  @override
  Future<bool> hasRightsForProduct(int productId) async {
    final url = "${appSettings.mainYSAPIUrl}/api/v1/productrights/$productId";
    final response = await getWithType<num>(url);
    final right = response.data;

    //NOTE: For some silly reason, using >= throws stackoverflow exception.
    return right == streamingRight || (right ?? 0) > streamingRight;
  }

  @override
  Future<void> addToFavorites(int productId) async {
    final url = "${appSettings.mobileAPIUrl}/v2/library/favorites/$productId";
    await put(url, {});
  }

  @override
  Future<void> addToLastRead(
      int productId, int currentUserId, String trackingId) async {
    try {
      final url = "${appSettings.mobileAPIUrl}/v2/stats/productView";
      final body = {
        'accountId': currentUserId,
        'actionDate': DateTime.now().toString(),
        'productId': productId,
        'trackingId': trackingId
      };
      await post(url, body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addToOfflines(int productId) async {
    final url = "${appSettings.mobileAPIUrl}/v2/library/offlines/$productId";
    await put(url, {});
  }

  @override
  FutureOr<List<ProductEntity>> getFavoriteProducts(int userId,
      {int take = 20, int skip = 0}) async {
    final url =
        "${appSettings.mobileAPIUrl}/v2/library/favorites?take=$take&skip=$skip";
    final response = await getWithType<List<dynamic>>(url,
        headers: {RepositoryConstants.ysAuthHeader: await getAuthToken()});
    final responseData = response.data;
    final productsFavorites = responseData!
        .map((e) => FavoriteModel.fromJson(e as Map<String, dynamic>))
        .toList();
    final products = productsFavorites.map((e) {
      final product = ProductEntity()..fromFavoriteModel(e);
      return product;
    }).toList();
    return products;
  }

  @override
  FutureOr<List<ProductEntity>> getLastReadingProducts(
      int userId, String trackingId) async {
    final url =
        "${appSettings.mobileAPIUrl}/v2/library/lastviewed/$trackingId?take=30";
    final response = await getWithType<List<dynamic>>(url,
        headers: {RepositoryConstants.ysAuthHeader: await getAuthToken()});
    final responseDynamic = response.data;
    final lastReadings = responseDynamic!
        .map<LastViewsModel>(
            (model) => LastViewsModel.fromJson(model as Map<String, dynamic>))
        .toList();
    final products = lastReadings.map((e) {
      final product = ProductEntity()..fromLastViewsModel(e);
      return product;
    }).toList();
    return products;
  }

  @override
  FutureOr<List<ProductEntity>> getOfflineProducts(int userId,
      {int take = 20, int skip = 0}) async {
    final url =
        "${appSettings.mobileAPIUrl}/v2/library/offlines?take=$take&skip=$skip";

    final response = await getWithType<List<dynamic>>(url,
        headers: {RepositoryConstants.ysAuthHeader: await getAuthToken()});
    final responseDynamic = response.data;
    final offlineProducts = responseDynamic!
        .map<OfflineModel>(
            (model) => OfflineModel.fromJson(model as Map<String, dynamic>))
        .toList();
    final products = offlineProducts.where((element) {
      final productModel = ProductEntity()..fromOfflineModel(element);
      return productModel.isOffline == true;
      //  &&
      //     productModel.dateAddedToOfflines == element.offlinedDate;
    }).map((e) {
      final product = ProductEntity()..fromProductModel(e.product!);
      return product;
    }).toList();
    return products;
  }

  @override
  Future<void> removeFromFavorites(int productId) async {
    final url = "${appSettings.mobileAPIUrl}/v2/library/favorites/$productId";
    await delete(url);
  }

  @override
  Future<void> removeFromOfflines(int productId) async {
    final url = "${appSettings.mobileAPIUrl}/v2/library/offlines/$productId";
    await delete(url);
  }

  @override
  Future<AudioInfoEntity> getAudioBookInfoFromStreamingAPI(
      int productId) async {
    final baseStreamingUrl = appSettings.apiStreamingURL;
    final String url = "$baseStreamingUrl$productId/info";

    String stringResp = '';
    // ignore: inference_failure_on_function_invocation
    final response = await dio.get(url,
        options: Options(
            headers: {RepositoryConstants.ysAuthHeader: await getAuthToken()}));

    stringResp = response.data.toString();
    if (response.statusCode != 200) {
      throw APIRequestException(
          response.statusCode!,
          "Reason: ${response.statusMessage}\n Content:$stringResp",
          stringResp);
    }

    final model =
        AudioInfoModel.fromJson(response.data as Map<String, dynamic>);

    final audioInfo = AudioInfoEntity.fromModel(model);

    return audioInfo;
  }

  // todo: request not tested, parameter missing  (trackingId)

  @override
  Future<(List<ProductEntity>, List<CollectionSearchOutputItemEntity>)>
      getGleephSuggestions(String trackingId) async {
    const int size = 6;
    final url =
        "${appSettings.mainYSAPIUrl}/api/v2/suggests/gleeph/byTrackingId/$trackingId?take=$size";
    final response = await get(url);
    final gleephSuggestions = ProductSuggestionsResultModel.fromJson(
        response.data! as Map<String, dynamic>);
    final List<ProductEntity> products = [];
    final List<CollectionSearchOutputItemEntity> collections = [];

    if (gleephSuggestions.products?.any((element) => element.isNotNull) ??
        false) {
      for (final product in gleephSuggestions.products!) {
        products.add(
            ProductEntity()..fromProductSearchItemOutputModel(product, true));
      }
    }
    if (gleephSuggestions.collections?.any((element) => element.isNotNull) ??
        false) {
      for (final collection in gleephSuggestions.collections!) {
        collections.add(CollectionSearchOutputItemEntity.fromModel(collection));
      }
    }

    return (products, collections);
  }

  @override
  FutureOr<List<BaseEntity>> getNewProductSuggestions(
      {int productId = 0, int take = 3}) async {
    try {
      final List<BaseEntity> finalResult = [];
      final url =
          "${appSettings.mainYSAPIUrl}/api/v2/suggests/similar-books/products/$productId?take=$take";
      final response = await get(url);
      // final responseDynamic = response.data! as List<dynamic>;
      final newSuggestions = ProductSuggestionsResultModel.fromJson(
          response.data! as Map<String, dynamic>);
      if (newSuggestions != null) {
        if (newSuggestions.products?.any((element) => element.isNotNull) ??
            false) {
          for (final product in newSuggestions.products!) {
            finalResult.add(ProductEntity()
              ..fromProductSearchItemOutputModel(product, false));
          }
        }
        if (newSuggestions.collections?.any((element) => element.isNotNull) ??
            false) {
          // for (final collection in newSuggestions.collections!) {
          // finalResult
          //    .add(CollectionSearchOutputItemEntity.fromModel(collection));
          //  }
        }
      }
      return finalResult;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int?> getNextProduct(int currentProductId) async {
    final url =
        "${appSettings.mainYSAPIUrl}/api/v1/collections/product/$currentProductId/next";
    final response = await get(url);
    return response.data != null ? response.data as int : 0;
  }

  @override
  Future<ProductEntity> getProduct(int id) async {
    try {
      final url = "${appSettings.mobileAPIUrl}/v2/products/$id";
      ProductModel result;
      final headers = {RepositoryConstants.ysAuthHeader: await getAuthToken()};
      final response = await dio.get<Map<String, dynamic>>(url,
          options: Options(headers: headers));

      if (response.data == null) {
        return _getProductFromMainAPI(id);
      }
      result = ProductModel.fromJson(response.data!);
      result.authorId = ProductModel.getAuthorId(result.people);
      return ProductEntity()..fromProductModel(result);
    } catch (e) {
      handleException(e);
      rethrow;
    }
  }

  // todo:  internal server error
  @override
  FutureOr<List<ProductEntity>> getProducts(List<int> productIds) async {
    try {
      final url = "${appSettings.mobileAPIUrl}/v2/products/byIds";
      final params = productIds
          .map((e) => e.toString())
          .toString()
          .replaceAll(' ', '')
          .replaceAll('(', '[')
          .replaceAll(')', "]");
      final headers = {RepositoryConstants.ysAuthHeader: await getAuthToken()};
      // ignore: inference_failure_on_function_invocation
      final response = await dio.post(url,
          data: params,
          options: Options(
            headers: headers,
          ));
      final responseDynamic = response.data! as List<dynamic>;
      final products = responseDynamic
          .map<ProductModel>(
              (model) => ProductModel.fromJson(model as Map<String, dynamic>))
          .toList();
      final List<ProductEntity> result = [];
      if (products.isNotNull) {
        for (final product in products) {
          result.add(ProductEntity()..fromProductModel(product));
        }
      }
      return result;
    } catch (e) {
      handleException(e);
      rethrow;
    }
  }

  @override
  Future<void> sendReadingStats(ReadingStatsEntity stats) async {
    final url = "${appSettings.mobileAPIUrl}/v2/stats/readingReport";
    final json = stats.toModel().toJson();
    try {
      await post(url, json,
          headers: {RepositoryConstants.ysAuthHeader: await getAuthToken()});
    } catch (e) {
      rethrow;
    }
  }

  @override
  FutureOr<List<ProductEntity>> getPremiumProductSuggestionsAsync(
      {int productId = 0, int take = 6}) async {
    final url =
        "${appSettings.mainYSAPIUrl}/api/v2/suggests/premium/product/$productId?take=$take";
    final response = await get(url);
    final suggestions = MutliTypeSearchOutPutModel.fromJson(
        response.data! as Map<String, dynamic>);

    final List<ProductEntity> prodList = [];
    if (suggestions.products.isNotNullOrEmpty) {
      for (final product in suggestions.products!) {
        final ProductEntity finalProd = ProductEntity()
          ..id = product.id
          ..author = product.authors!.join(".")
          ..title = product.title
          ..imageUrl = product.thumbnailUrls!.first.url
          ..estimatedReadTime =
              convertStringTimeSpanToDuration(product.estimatedReadTime!)
          ..description = product.description;

        prodList.add(finalProd);
      }
    }

    return prodList;
  }

  // todo: request not tested, parameter missing  (selectionUrlName)

  @override
  Future<ProductCatalogPresentationEntity> getProductsForSelection(
      String selectionUrlName, int take, int skip) async {
    final catalogUrl = "${appSettings.mobileAPIUrl}/v1/catalog-pages";
    final response = await get(catalogUrl, queryParameters: {
      "name": selectionUrlName,
      "take": take.toString(),
      "skip": skip.toString()
    });
    final catalog =
        CatalogPageModel.fromJson(response.data as Map<String, dynamic>);

    return ProductCatalogPresentationEntity.fromCatalogPageModel(catalog);
  }
}
