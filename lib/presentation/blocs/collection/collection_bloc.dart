import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/base/base_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/entities/product_search_results_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/models/requests/product_search_parameters.dart';
import 'package:youscribe/core/repositories/product_search_repository.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'collection_event.dart';
part 'collection_state.dart';

class CollectionDetailsBloc extends Bloc<CollectionEvent, CollectionState>
    with Debuggable, Loggable {
  CollectionDetailsBloc() : super(CollectionInitialState()) {
    on<InitCollectionEvent>(_init);
    on<LoadNewPageEvent>(_loadPage);
    _productSearchReposotiry = locator<ProductSearchReposotiry>();
  }

  late final ProductSearchReposotiry _productSearchReposotiry;

  final List<BaseEntity> _products = [];
  int _collectionId = 0;
  String _language = "";
  bool _hasNext = false;

  @override
  String get debugName => 'CollectionDetailsBloc';

  Future<void> _init(
      InitCollectionEvent event, Emitter<CollectionState> emitter) async {
    _collectionId = event.collectionId;
    _language = event.language;
    try {
      final results = await _loadNewProductPages();
      results.$1.forEach(_products.add);
      emitter(CollectionLoadedState(
          products: _products,
          hasNextPage: results.$2,
          collectionId: event.collectionId,
          collectionTitle: event.collectionTitle));
    } on APIRequestException catch (ex) {
      logError("""
API Error occured while loading collection details for product with category: $_collectionId""",
          error: Exception(ex));
      emitter(CollectionErrorState(ErrorType.serverError));
    } catch (e) {
      logError('''
API Error occured while loading collection details page for product with collection: $_collectionId''',
          error: Exception(e));
      emitter(CollectionErrorState(ErrorType.unknownError));
    }
  }

  Future<void> _loadPage(
      LoadNewPageEvent event, Emitter<CollectionState> emitter) async {
    try {
      if (_hasNext) {
        final results = await _loadNewProductPages();
        results.$1.forEach(_products.add);
        _hasNext = results.$2;
        emitter(CollectionLoadedState(
            products: _products,
            hasNextPage: results.$2,
            collectionId: event.collectionId,
            collectionTitle: event.collectionTitle));
      }
    } catch (e) {
      logError("""
Unknown Error occured while performing infinitescroll for Products List""",
          error: Exception(e));
    }
  }

  Future<(List<ProductEntity>, bool)> _loadNewProductPages() async {
    final ProductSearchParameters searchParams = ProductSearchParameters()
      ..offerType = [
        ProductSearchResultsEntity.productFreeOfferType,
        ProductSearchResultsEntity.productSubscriptionOfferType,
      ]
      ..requestedFacet = [
        ProductSearchResultsEntity.themeFacet,
        ProductSearchResultsEntity.languageFacet,
      ]
      ..isAdultContent = false
      ..collectionId = _collectionId
      ..skip = _products.length
      ..take = 10
      ..sort = [ProductSearchResultsEntity.mostReadSortOption];
    final searchResult = await _productSearchReposotiry.searchProducts(
        searchParams, _language, 0);
    return (
      searchResult.products!,
      searchResult.totalResults.isNotNull
          ? searchResult.totalResults! >
              (_products.length + searchResult.products!.length)
          : false
    );
  }
}
