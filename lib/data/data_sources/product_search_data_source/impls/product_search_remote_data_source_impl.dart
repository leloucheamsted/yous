// ignore_for_file: implementation_imports, unnecessary_null_comparison, prefer_foreach, lines_longer_than_80_chars

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/collection_search_results_presentation_entity.dart';
import 'package:youscribe/core/entities/multitype_search_output_entity.dart';
import 'package:youscribe/core/entities/people_search_results_entity.dart';
import 'package:youscribe/core/entities/product_category_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/entities/product_facet_entity.dart';
import 'package:youscribe/core/entities/product_search_results_entity.dart';
import 'package:youscribe/core/models/requests/multi_type_search_request_model.dart';
import 'package:youscribe/core/models/requests/product_search_parameters.dart';
import 'package:youscribe/core/models/responses/collection_search_output_model.dart';
import 'package:youscribe/core/models/responses/multi_type_search_output_model.dart';
import 'package:youscribe/core/models/responses/people_search_result_model.dart';
import 'package:youscribe/core/models/responses/product_category_model.dart';
import 'package:youscribe/core/models/responses/product_facet_model.dart';
import 'package:youscribe/core/models/responses/product_search_output_model.dart';
import 'package:youscribe/core/models/utilities.dart';
import 'package:youscribe/core/repositories/repository_constants.dart';
import 'package:youscribe/data/data_sources/base_remote_data_source.dart';
import 'package:youscribe/data/data_sources/product_search_data_source/product_search_remote_data_source.dart';

class ProductSearchRemoteDataSourceImpl extends BaseRemoteDataSource
    implements ProductSearchRemoteDataSource {
  ProductSearchRemoteDataSourceImpl({
    required super.dio,
    required super.appSettings,
  });

  @override
  FutureOr<List<ProductCategoryEntity>> getSearchFirstLevelOptions(
      String currentLang) async {
    final currentUser = await AuthenticationManager.getCurrentUser();
    if (currentUser!.isYSClassificationSettings) {
      final url =
          "${appSettings.mainYSAPIUrl}/api/categories?setLng=$currentLang";
      final response = await getWithType<List<dynamic>>(url,
          headers: await getHeaders(languageCode: currentLang));
      final modelList = response.data!;
      final result = List<ProductCategoryModel>.from(modelList.map(
              (e) => ProductCategoryModel.fromJson(e as Map<String, dynamic>)))
          .toList();

      return result.map(ProductCategoryEntity.fromModel).toList();
    } else {
      final res = await _getSearchFirstLevelOptionsForExternalClassificationId(
          currentLang, currentUser.classificationTreeId);
      if (res == null && res.isEmpty) {
        return [];
      }

      return res.map(ProductCategoryEntity.fromModel).toList();
    }
  }

  @override
  Future<ProductSearchResultsEntity> getAuthorProducts(
      int authorId, int take, int skip, String deviceLang) async {
    final searchParams = ProductSearchParameters()
      ..authorId = authorId
      ..isAdultContent = false
      ..skip = skip
      ..take = take
      ..sort = ['online_date|1'];

    final currentUser = await AuthenticationManager.getCurrentUser();

    if (currentUser!.isYSClassificationSettings) {
      if (currentUser.classificationTreeId == null &&
              searchParams.excludedThemeId == null ||
          searchParams.excludedThemeId!.isEmpty) {
        for (final item in ProductSearchResultsEntity.excludedThemeIds) {
          searchParams.excludedThemeId?.add(item);
        }
      }
    }

    return searchProducts(searchParams, deviceLang, 0);
  }

  @override
  Future<List<ProductEntity>> getProductCollection(
      int? collectionId, int take, String deviceLanguage) async {
    final searchParams = ProductSearchParameters();
    // ignore: cascade_invocations
    searchParams
      ..collectionId = collectionId
      ..take = take
      ..excludedThemeId =
          List.from(ProductSearchResultsEntity.excludedThemeIds);
    final result = await searchProducts(searchParams, deviceLanguage, take);
    return result.products ?? [];
  }

  @override
  Future<ProductSearchResultsEntity> getPublisherProducts(
      int publisherId, int take, int skip, String deviceLang) async {
    final searchParams = ProductSearchParameters();
    // ignore: cascade_invocations
    searchParams
      ..inOwnerId = List<int>.from([publisherId])
      ..isAdultContent = false
      ..skip = skip
      ..take = take
      ..sort = List<String>.from(['online_date|1']);

    final result = await searchProducts(searchParams, deviceLang, take);
    return result;
  }

  FutureOr<List<ProductCategoryModel>>
      _getSearchFirstLevelOptionsForExternalClassificationId(
          String currentLang, int? classificationTreeId) async {
    final url =
        "${appSettings.mainYSAPIUrl}/api/v1/classification/classification-tree/$classificationTreeId";
    // final response =
    //     await get(url, headers: await getHeaders(languageCode: currentLang));
    final headers = {
      RepositoryConstants.ysAuthHeader: await getAuthToken(),
      RepositoryConstants.ysLanguageHeader: currentLang
    };
    // ignore: inference_failure_on_function_invocation
    final response = await dio.get(url, options: Options(headers: headers));
    final modelList = response.data as List<dynamic>;
    final result = List<ProductCategoryModel>.from(modelList.map(
            (e) => ProductCategoryModel.fromJson(e as Map<String, dynamic>)))
        .toList();

    return result;
  }

  @override
  Future<MultiTypeSearchOutPutEntity> getSearchSuggestions(
      ProductSearchParameters searchParameters, String deviceLanguage) async {
    final user = await AuthenticationManager.getCurrentUser();
    searchParameters.excludedThemeId ??= [];
    if (user!.classificationTreeId == null &&
        searchParameters.excludedThemeId != null &&
        searchParameters.excludedThemeId!.isNotEmpty) {
      for (final item in ProductSearchResultsEntity.excludedThemeIds) {
        searchParameters.excludedThemeId!.add(item);
      }
    }
    searchParameters
      ..take = 2
      ..sort = [ProductSearchResultsEntity.scoreSortOption];
    final requestModel = MultiTypeSearchRequestModel(
        filters: searchParameters,
        requestedSearch: [
          MultisearchType.books,
          MultisearchType.audiobooks,
          MultisearchType.products,
          MultisearchType.bds,
          MultisearchType.press,
          MultisearchType.collections,
          MultisearchType.authors,
        ]);

    final url = '${appSettings.mainYSAPIUrl}/api/v1/search/multisearch';
    final val = requestModel.toJson();
    final result = await post(url, val,
        headers: await getHeaders(languageCode: deviceLanguage));
    final resultModel = MutliTypeSearchOutPutModel.fromJson(result.data!);

    return MultiTypeSearchOutPutEntity(model: resultModel);
  }

  @override
  FutureOr<List<ProductFacetEntity>> getThemes(
      int facetId, String deviceLanguage,
      [bool isFirstLevel = false]) async {
    final currentUser = await AuthenticationManager.getCurrentUser();
    if (currentUser!.isYSClassificationSettings) {
      final List<int> excludedThemes = [];
      const int pressCategoryId = 67;

      if (facetId == pressCategoryId) {
        excludedThemes.add(182); //182 stands for the archived theme id
      }

      final searchParams = ProductSearchParameters()
        ..excludedThemeId = excludedThemes
        ..skip = 0
        ..take = 10
        ..offerType = [
          ProductSearchResultsEntity.productFreeOfferType,
          ProductSearchResultsEntity.productSubscriptionOfferType
        ];
      // ignore: cascade_invocations
      searchParams.requestedFacet = [ProductSearchResultsEntity.themeFacet];

      if (isFirstLevel) {
        searchParams.categoryId = facetId;
      } else {
        searchParams.themeId = facetId;
      }

      final result = await searchProducts(searchParams, deviceLanguage, 0);

      if (result.themes.isNullOrEmpty) {
        return [];
      }

      if (isFirstLevel) {
        return result.themes!;
      }

      final everyChildren = getAllChildren(result.themes!);
      final theme = everyChildren.firstWhere((e) => e.parent!.id == facetId);

      return theme.children;
    } else {
      final result = await _getThemesWithExternalClassification(
          deviceLanguage, currentUser.classificationTreeId);

      final classification =
          result.firstWhere((element) => element.id == facetId);
      if (classification.isNotNull) {
        return classification.children;
      }
    }

    return [];
  }

  Future<List<ProductFacetEntity>> _getThemesWithExternalClassification(
      String deviceLanguage, int? classificationTreeId) async {
    final url =
        '${appSettings.mainYSAPIUrl}/api/v1/classification/classification-tree/$classificationTreeId';
    // ignore: inference_failure_on_function_invocation
    final response = await dio.get(url,
        options: Options(
          headers: await getHeaders(languageCode: deviceLanguage),
        ));

    final responseData = response.data as List<dynamic>;
    final result = List<ProductFacetEntity>.from(responseData.map((e) =>
        ProductFacetEntity.fromModel(
            ProductFacetModel.fromJson(e as Map<String, dynamic>)))).toList();

    return result;
  }

  @override
  FutureOr<List<ProductCategoryEntity>> getYSCategories(String currentLang) {
    // TODO: implement getYSCategories
    throw UnimplementedError();
  }

  @override
  Future<PeopleSearchResultsEntity> searchAuthors(
      ProductSearchParameters searchParams, String deviceLanguage) async {
    final currentUser = await AuthenticationManager.getCurrentUser();

    if (currentUser!.isYSClassificationSettings) {
      if (searchParams.excludedThemeId != null &&
          searchParams.excludedThemeId!.isNotEmpty) {
        for (final item in ProductSearchResultsEntity.excludedThemeIds) {
          searchParams.excludedThemeId!.add(item);
        }
      }
    } else {
      searchParams
        ..classificationId = searchParams.themeId
        ..themeId = null;
    }

    final url = "${appSettings.mainYSAPIUrl}/api/v1/people/search";
    final response = await post(url, searchParams.toJson(),
        headers: await getHeaders(languageCode: deviceLanguage));
    final result = PeopleSearchResultModel.fromJson(response.data!);
    return PeopleSearchResultsEntity(result);
  }

  @override
  Future<CollectionSearchResultsEntity> searchCollections(
      ProductSearchParameters searchParams, String deviceLanguage) async {
    final currentUser = await AuthenticationManager.getCurrentUser();

    if (currentUser!.isYSClassificationSettings) {
      if (searchParams.excludedThemeId != null &&
          searchParams.excludedThemeId!.isNotEmpty) {
        for (final item in ProductSearchResultsEntity.excludedThemeIds) {
          searchParams.excludedThemeId!.add(item);
        }
      }
    } else {
      searchParams
        ..classificationId = searchParams.themeId
        ..themeId = null;
    }

    final url = "${appSettings.mainYSAPIUrl}/api/v1/collections/searchv2";
    final response = await post(url, searchParams.toJson(),
        headers: await getHeaders(languageCode: deviceLanguage));
    final result = CollectionSearchOutputModel.fromJson(response.data!);
    return CollectionSearchResultsEntity(result, false);
  }

  @override
  Future<ProductSearchResultsEntity> searchProducts(
      ProductSearchParameters searchParams,
      String deviceLanguage,
      int? parentClassificationId) async {
    final currentUser = await AuthenticationManager.getCurrentUser();

    if (currentUser!.isYSClassificationSettings) {
      if (searchParams.excludedThemeId == null ||
          searchParams.excludedThemeId!.isEmpty) {
        searchParams.excludedThemeId ??= [];
        for (final item in ProductSearchResultsEntity.excludedThemeIds) {
          searchParams.excludedThemeId!.add(item);
        }
      }

      final url = "${appSettings.mainYSAPIUrl}/api/v2/products/search";
      final jsonParams = searchParams.toJson();
      final headers = await getHeaders(languageCode: deviceLanguage);
      final response = await post(url, jsonParams, headers: headers);
      final result = ProductSearchOutputModel.fromJson(response.data!);
      return ProductSearchResultsEntity.fromModel(result);
    } else {
      return searchProductsWithExternalClassification(
          searchParams, deviceLanguage,
          parentClassificationId: parentClassificationId);
    }
  }

  ///How we search products when the classification isn't YouScribe. (ex: for the cobrand)
  Future<ProductSearchResultsEntity> searchProductsWithExternalClassification(
      ProductSearchParameters searchParams, String deviceLanguage,
      {int? parentClassificationId = 0}) async {
    final categoryId = searchParams.categoryId;
    final themeId = searchParams.themeId;
    searchParams
      ..themeId = null
      ..classificationId = themeId;
    ProductCategoryModel? firstClassification;

    if (searchParams.requestedFacet != null &&
        searchParams.requestedFacet!
            .contains(ProductSearchResultsEntity.themeFacet)) {
      searchParams.requestedFacet!
          .remove(ProductSearchResultsEntity.themeFacet);
    }
    if (searchParams.requestedFacet != null &&
        searchParams.requestedFacet!
            .contains(ProductSearchResultsEntity.classificationFacet)) {
      searchParams.requestedFacet!
          .add(ProductSearchResultsEntity.classificationFacet);
    }

    final url = "${appSettings.mainYSAPIUrl}/api/v2/products/search";
    final response = await post(url, searchParams.toJson(),
        headers: await getHeaders(languageCode: deviceLanguage));
    final result = ProductSearchOutputModel.fromJson(response.data!);

    //TODO: later make it possible not to get categories on every search.
    // (rename this to parentclassifications)
    List<ProductCategoryModel> parentClassifications = [];

    parentClassifications =
        (await _getSearchFirstLevelOptionsForExternalClassificationId(
                deviceLanguage, parentClassificationId))
            .toList();

    //Remove external classifications
    result.classifications = [];

    final res = ProductSearchResultsEntity.fromModel(result);

    try {
      if (parentClassificationId != 0 && parentClassificationId != null) {
        if (parentClassifications != null) {
          if (categoryId != null && categoryId != 0) {
            firstClassification =
                parentClassifications.firstWhere((c) => c.id == categoryId);
          }
        }

        if (firstClassification != null) {
          parentClassifications.remove(firstClassification);
        }

        res.classifications = parentClassifications
            .map((c) => ProductFacetEntity(
                  id: c.id,
                  label: c.label,
                  name: c.name,
                  children: c.children == null
                      ? []
                      : c.children!
                          .map((c) => ProductFacetEntity(
                                id: c.id,
                                label: c.label,
                                name: c.name,
                              ))
                          .toList(),
                ))
            .toList();

        if (firstClassification != null) {
          res.classifications!.insert(
              0,
              ProductFacetEntity(
                id: firstClassification.id,
                label: firstClassification.label,
                name: firstClassification.name,
                children: firstClassification.children == null
                    ? []
                    : firstClassification.children!
                        .map((c) => ProductFacetEntity(
                              id: c.id,
                              label: c.label,
                              name: c.name,
                            ))
                        .toList(),
              ));
        }

        //Note: we exchange themes for classifications for the cobrand.
        res.themes = res.classifications;
      } else {
        final jsonClas = parentClassifications.map((e) => e.toJson()).toList();
        res.themes = jsonClas as List<ProductFacetEntity>;
      }
    } catch (e) {
      Exception(e);
    }

    searchParams
      ..themeId = searchParams.classificationId
      ..classificationId = null;

    return res;
  }
}
