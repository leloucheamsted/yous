import 'dart:async';

import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:youscribe/core/entities/collection_search_results_presentation_entity.dart';
import 'package:youscribe/core/entities/multitype_search_output_entity.dart';
import 'package:youscribe/core/entities/people_search_results_entity.dart';
import 'package:youscribe/core/entities/product_category_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/entities/product_facet_entity.dart';
import 'package:youscribe/core/entities/product_search_results_entity.dart';
import 'package:youscribe/core/models/requests/product_search_parameters.dart';

abstract class ProductSearchReposotiry extends BaseRepository {
  Future<ProductSearchResultsEntity> getPublisherProducts(
      int publisherId, int take, int skip, String deviceLang);
  Future<ProductSearchResultsEntity> getAuthorProducts(
      int authorId, int take, int skip, String deviceLang);
  Future<PeopleSearchResultsEntity> searchAuthors(
      ProductSearchParameters searchParams, String deviceLanguage);
  Future<CollectionSearchResultsEntity> searchCollections(
      ProductSearchParameters searchParams, String deviceLanguage);
  FutureOr<List<ProductEntity>> getProductCollection(
      int? collectionId, int take, String deviceLanguage);
  Future<ProductSearchResultsEntity> searchProducts(
      ProductSearchParameters searchParams,
      String deviceLanguage,
      int? parentClassificationId);

  FutureOr<List<ProductCategoryEntity>> getSearchFirstLevelOptions(
      String currentLang);
  FutureOr<List<ProductCategoryEntity>> getYSCategories(String currentLang);
  FutureOr<List<ProductFacetEntity>> getThemes(
      int categoryId, String deviceLanguage,
      [bool isFirstLevel = false]);
  FutureOr<MultiTypeSearchOutPutEntity> getSearchSuggestions(
      ProductSearchParameters? searchParameters, String deviceLanguage);
}
