import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/use_cases/products/get_ysselection_products_use_case.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'products_in_selection_event.dart';
part 'products_in_selection_state.dart';

class ProductsInSelectionBloc
    extends Bloc<ProductsInSelectionEvent, ProductsInSelectionState>
    with Debuggable, Loggable {
  ProductsInSelectionBloc() : super(ProductsInSelectionInitialState()) {
    on<InitProductInSelectionEvent>(_onInitProductInSelectionEvent);
    on<RefreshProductsInSelectionEvent>(_onRefreshProductInSelectionEvent);
    on<ErrorDisplayedEvent>(_errorDisplayed);
    on<ProductsInSelectionInfiniteScrollEvent>(_onInfiniteScroll);
  }

  final GetYsSelectionProductsUseCase _getYsSelectionProductsUseCase =
      locator();
  final ConnectivityService _connectivityService = locator();

  @override
  String get debugName => 'ProductsInSelectionBloc';

  Future<void> _onInitProductInSelectionEvent(InitProductInSelectionEvent event,
      Emitter<ProductsInSelectionState> emitter) async {
    await _loadProductsInSelection(event.selectionId, emitter);
  }

  Future<void> _loadProductsInSelection(
      String selectionId, Emitter<ProductsInSelectionState> emitter) async {
    if (!await _connectivityService.isInternetAvailable) {
      emitter(ProductsInSelectionErrorState(ErrorType.noInternet, state));
      return;
    }

    final results = await _getYsSelectionProductsUseCase(
        GetYsSelectionProductsUseCaseParams(
            selectionId: selectionId, take: pageSize, skip: 0));

    if (results.isErr) {
      logError(
          // ignore: lines_longer_than_80_chars
          "Error while loading products in selection: $selectionId, ${results.err?.message} ${results.err}",
          error: results.err);

      return;
    }

    final catalog = results.ok!.$1;

    emitter(ProductsInSelectionLoadedState(
        description: catalog.description,
        title: catalog.title!,
        hasNextPage: results.ok!.$2,
        selectionId: selectionId,
        products: catalog.products!));
  }

  void _errorDisplayed(
      ErrorDisplayedEvent event, Emitter<ProductsInSelectionState> emitter) {
    if (state is ProductsInSelectionErrorState) {
      emitter((state as ProductsInSelectionErrorState).previousState);
    }
  }

  Future<void> _onInfiniteScroll(ProductsInSelectionInfiniteScrollEvent event,
      Emitter<ProductsInSelectionState> emitter) async {
    if (!await _connectivityService.isInternetAvailable) {
      emitter(ProductsInSelectionErrorState(ErrorType.noInternet, state));
      return;
    }

    final currentState = state as ProductsInSelectionLoadedState;

    final results = await _getYsSelectionProductsUseCase(
        GetYsSelectionProductsUseCaseParams(
            selectionId: currentState.selectionId,
            take: pageSize,
            skip: currentState.products.length));

    if (results.isErr) {
      logError(
          // ignore: lines_longer_than_80_chars
          "Error while loading products in selection: ${currentState.selectionId}, ${results.err?.message} ${results.err}",
          error: results.err);

      return;
    }

    final catalog = results.ok!.$1;

    emitter(currentState.copyWith(
        products: [...currentState.products, ...catalog.products!],
        hasNextPage: results.ok!.$2));
  }

  Future<void> _onRefreshProductInSelectionEvent(
      RefreshProductsInSelectionEvent event,
      Emitter<ProductsInSelectionState> emitter) async {
    await _loadProductsInSelection(
        (state as ProductsInSelectionLoadedState).selectionId, emitter);
  }
}
