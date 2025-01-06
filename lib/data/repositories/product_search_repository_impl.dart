import 'dart:async';

import 'package:youscribe/core/entities/collection_search_results_presentation_entity.dart';
import 'package:youscribe/core/entities/multitype_search_output_entity.dart';
import 'package:youscribe/core/entities/people_search_results_entity.dart';
import 'package:youscribe/core/entities/product_category_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/entities/product_facet_entity.dart';
import 'package:youscribe/core/entities/product_search_results_entity.dart';
import 'package:youscribe/core/models/requests/product_search_parameters.dart';
import 'package:youscribe/core/repositories/product_search_repository.dart';
import 'package:youscribe/data/data_sources/product_search_data_source/product_search_remote_data_source.dart';

class ProductSearchRepositoryImpl implements ProductSearchReposotiry {
  ProductSearchRepositoryImpl({
    required ProductSearchRemoteDataSource productSearchRemoteDataSource,
  }) : _productSearchRemoteDataSource = productSearchRemoteDataSource;

  final ProductSearchRemoteDataSource _productSearchRemoteDataSource;
  @override
  Future<ProductSearchResultsEntity> getAuthorProducts(
      int authorId, int take, int skip, String deviceLang) {
    return _productSearchRemoteDataSource.getAuthorProducts(
        authorId, take, skip, deviceLang);
  }

  @override
  FutureOr<List<ProductEntity>> getProductCollection(
      int? collectionId, int take, String deviceLanguage) {
    return _productSearchRemoteDataSource.getProductCollection(
        collectionId, take, deviceLanguage);
  }

  @override
  Future<ProductSearchResultsEntity> getPublisherProducts(
      int publisherId, int take, int skip, String deviceLang) {
    return _productSearchRemoteDataSource.getPublisherProducts(
        publisherId, take, skip, deviceLang);
  }

  @override
  FutureOr<List<ProductCategoryEntity>> getSearchFirstLevelOptions(
      String currentLang) {
    return _productSearchRemoteDataSource
        .getSearchFirstLevelOptions(currentLang);
  }

  @override
  Future<MultiTypeSearchOutPutEntity> getSearchSuggestions(
      ProductSearchParameters? searchParameters, String deviceLanguage) {
    return _productSearchRemoteDataSource.getSearchSuggestions(
        searchParameters!, deviceLanguage);
  }

  @override
  FutureOr<List<ProductFacetEntity>> getThemes(
      int categoryId, String deviceLanguage,
      [bool isFirstLevel = false]) {
    return _productSearchRemoteDataSource.getThemes(
        categoryId, deviceLanguage, isFirstLevel);
  }

  @override
  FutureOr<List<ProductCategoryEntity>> getYSCategories(String currentLang) {
    return _productSearchRemoteDataSource.getYSCategories(currentLang);
  }

  @override
  Future<PeopleSearchResultsEntity> searchAuthors(
      ProductSearchParameters searchParams, String deviceLanguage) {
    return _productSearchRemoteDataSource.searchAuthors(
        searchParams, deviceLanguage);
  }

  @override
  Future<CollectionSearchResultsEntity> searchCollections(
      ProductSearchParameters searchParams, String deviceLanguage) {
    return _productSearchRemoteDataSource.searchCollections(
        searchParams, deviceLanguage);
  }

  @override
  Future<ProductSearchResultsEntity> searchProducts(
      ProductSearchParameters searchParams,
      String deviceLanguage,
      int? parentClassificationId) {
    return _productSearchRemoteDataSource.searchProducts(
        searchParams, deviceLanguage, parentClassificationId);
  }
}
