import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/my_selection_product_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/use_cases/my_selections/get_my_selection_products_use_case.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'my_selection_details_event.dart';
part 'my_selection_details_state.dart';

class MySelectionDetailsBloc
    extends Bloc<MySelectionDetailsEvent, MySelectionDetailsState>
    with Debuggable, Loggable {
  MySelectionDetailsBloc() : super(InitMySelectionDetails()) {
    on<InitMySelectionDetailsEvent>(_init);
    on<LoadNewPageEvent>(_loadPage);
    on<ErrorDisplayedEvent>(_errorDisplayed);
    on<DeleteProdutEvent>(_delete);

    _getMySelectionProductsUseCase = locator<GetMySelectionProductsUseCase>();
  }

  late final GetMySelectionProductsUseCase _getMySelectionProductsUseCase;

  List<MySelectionProductEntity> _products = [];
  int _selectionId = 0;
  bool _hasNext = false;

  int pageSize = 10;

  @override
  String get debugName => 'MySelectionDetailsBloc';

  Future<void> _init(InitMySelectionDetailsEvent event,
      Emitter<MySelectionDetailsState> emitter) async {
    _selectionId = event.selectionId;
    try {
      final mySelectionsProducts = await _loadNewProductPages();
      mySelectionsProducts.$1.forEach(_products.add);
      if (_products.isEmpty) {
        emitter(MySelectionDetailsEmptyState());
        return;
      }
      emitter(MySelectionDetailsLoadedState(
        products: _products,
      ));
      _hasNext = _products.length >= pageSize;
    } on APIRequestException catch (ex) {
      logError("API Error occured while initializing my selection details vm",
          error: Exception(ex));
      emitter(MySelectionDetailsErrorState(state, ErrorType.serverError));
    } catch (e) {
      logError("Error occured while initializing my selection details vm",
          error: Exception(e));
      emitter(MySelectionDetailsErrorState(state, ErrorType.unknownError));
    }
  }

  Future<void> _loadPage(
      LoadNewPageEvent event, Emitter<MySelectionDetailsState> emitter) async {
    try {
      if (_hasNext) {
        final results = await _loadNewProductPages();
        _products = [..._products, ...results.$1];
        _hasNext = results.$2;
        emitter(MySelectionDetailsLoadedState(products: _products));
      }
    } catch (e) {
      logError("""
Unknown Error occured while performing infinitescroll for Products List""",
          error: Exception(e));
      emitter(MySelectionDetailsErrorState(state, ErrorType.unknownError));
    }
  }

  Future<void> _delete(
      DeleteProdutEvent event, Emitter<MySelectionDetailsState> emitter) async {
    final currentState = state as MySelectionDetailsLoadedState;
    final myNewList = currentState.products
        .where((element) => element.product?.id != event.productId);
    emitter(MySelectionDetailsLoadedState(products: List.from(myNewList)));
  }

  void _errorDisplayed(
      ErrorDisplayedEvent event, Emitter<MySelectionDetailsState> emitter) {
    if (state is MySelectionDetailsErrorState) {
      emitter((state as MySelectionDetailsErrorState).previousState);
    }
  }

  Future<(List<MySelectionProductEntity>, bool)> _loadNewProductPages() async {
    final GetMySelectionProductsUseCaseParameters parameters =
        GetMySelectionProductsUseCaseParameters(
            _selectionId, pageSize, _products.length);
    final productsResults = await _getMySelectionProductsUseCase(parameters);
    _hasNext = !(pageSize != productsResults.ok?.length ||
        productsResults.ok!.isEmpty);

    return (productsResults.ok ?? [], _hasNext);
  }
}
