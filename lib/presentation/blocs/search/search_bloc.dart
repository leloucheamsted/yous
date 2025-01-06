import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/multitype_search_output_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/models/requests/product_search_parameters.dart';
import 'package:youscribe/core/use_cases/configurations/get_user_settings_use_case.dart';
import 'package:youscribe/core/use_cases/search/get_search_suggestions_use_case.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe/presentation/blocs/my_lists/base_product_list_bloc.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends BaseProductListBloc<SearchEvent, SearchState>
    with Debuggable, Loggable {
  SearchBloc() : super(SearchInitialState()) {
    on<SearchTextChangedEvent>(_searchTextChanged);
    on<CollectionGroupSelectedEvent>(_collectionGroupSelected);
    on<AuthorGroupSelectedEvent>(_authorGroupSelected);
    on<ProductGroupSelectedEvent>(_productGroupSelected);
    on<CollectionSelectedEvent>(_collectionSelected);
    on<AuthorSelectedEvent>(_authorSelected);
    on<ProductSelectedEvent>(_productSelected);
    on<SearchErrorDisplayedEvent>(_errorDisplayed);

    _connectivityService = locator<ConnectivityService>();
    _getSearchSuggestionsUseCase = locator<GetSearchSuggestionsUseCase>();
    _searchParameters = ProductSearchParameters();
  }

  late final ConnectivityService _connectivityService;
  late final GetSearchSuggestionsUseCase _getSearchSuggestionsUseCase;
  late final ProductSearchParameters _searchParameters;
  late final CancelToken _cancelToken = CancelToken();
  final GetUserSettingsUseCase _getUserSettingsUseCase =
      locator<GetUserSettingsUseCase>();
  String _searchText = '';
  String get searchText => _searchText;
  MultiTypeSearchOutPutEntity _searchResults =
      MultiTypeSearchOutPutEntity.defaults();
  MultiTypeSearchOutPutEntity get searchResults => _searchResults;

  @override
  String get debugName => 'SearchBloc';

  Future<void> _searchTextChanged(
      SearchTextChangedEvent event, Emitter<SearchState> emit) async {
    try {
      _searchText = event.searchText;
      _searchParameters.quicksearch = event.searchText;
      emit(SearchLoadedState(isBusy: true, searchResults: _searchResults));

      //TODO: is it pertinent to check internet connection all the time ?
      final userSettings = await _getUserSettingsUseCase(null);
      final language = userSettings.isOk
          ? (userSettings.ok?.preferredLanguageCode ?? event.language)
          : event.language;

      _searchParameters.quicksearch = _searchText;

      final GetSuggestionsUseCaseParameters geSuggestionsParameters =
          GetSuggestionsUseCaseParameters(
              _searchParameters, language, _cancelToken);

      final results =
          await _getSearchSuggestionsUseCase(geSuggestionsParameters);

      if (results.isErr) {
        final bool isInternetAvailable =
            await _connectivityService.isInternetAvailable;

        if (!isInternetAvailable) {
          emit(SearchErrorState(
            state,
            errorType: ErrorType.noInternet,
          ));
          return;
        }

        if (results.err is APIRequestException) {
          emit(SearchErrorState(
              SearchLoadedState(isBusy: false, searchResults: _searchResults),
              errorType: ErrorType.serverError));
        }
        logError("### Error during search.", error: results.err);
        return;
      }

      _searchResults = results.ok!;
      if (_searchResults.products.isEmpty &&
          _searchResults.collections!.isEmpty &&
          _searchResults.authors.isEmpty) {
        emit(SearchEmptyState());
        return;
      }

      emit(SearchLoadedState(isBusy: false, searchResults: _searchResults));
    } catch (e) {
      logError("### Error during search.", error: e as Exception);
      emit(SearchLoadedState(isBusy: false, searchResults: _searchResults));
    }
  }

  Future<void> _collectionGroupSelected(
      CollectionGroupSelectedEvent event, Emitter<SearchState> emit) async {}

  Future<void> _productGroupSelected(
      ProductGroupSelectedEvent event, Emitter<SearchState> emit) async {}

  Future<void> _authorGroupSelected(
      AuthorGroupSelectedEvent event, Emitter<SearchState> emit) async {}
  Future<void> _collectionSelected(
      CollectionSelectedEvent event, Emitter<SearchState> emit) async {}
  Future<void> _authorSelected(
      AuthorSelectedEvent event, Emitter<SearchState> emit) async {}
  Future<void> _productSelected(
      ProductSelectedEvent event, Emitter<SearchState> emit) async {}
  Future<void> _errorDisplayed(
      SearchErrorDisplayedEvent event, Emitter<SearchState> emit) async {
    if (state is SearchErrorState) {
      emit((state as SearchErrorState).previousState);
    }
  }
}
