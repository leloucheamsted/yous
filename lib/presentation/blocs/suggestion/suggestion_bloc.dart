import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
// import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/use_cases/configurations/get_user_settings_use_case.dart';
import 'package:youscribe/core/use_cases/home/read_home_product_suggestions.dart';
import 'package:youscribe/core/use_cases/search/search_product_usecase.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe/presentation/blocs/search/shared.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'suggestion_event.dart';
part 'suggestion_state.dart';

class SuggestionBloc extends Bloc<SuggestionEvent, SuggestionState>
    with Debuggable, Loggable {
  SuggestionBloc() : super(SuggestionInitialState()) {
    on<InitSuggestionEvent>(_init);
    on<ErrorDisplayedEvent>(_errorDisplayed);
  }
  late final ConnectivityService _connectivityService =
      locator<ConnectivityService>();

  final GetUserSettingsUseCase _userSettingsUseCase = locator();

  final ReadHomeProductSuggestionsUseCase _readHomeProductSuggestionsUseCase =
      locator<ReadHomeProductSuggestionsUseCase>();
  final SearchUseCase _searchUseCase = locator<SearchUseCase>();
  int pageSize = 10;
  List<ProductEntity> products = [];

  @override
  String get debugName => 'SuggestionBloc';

  Future<void> _init(
      InitSuggestionEvent event, Emitter<SuggestionState> emitter) async {
    if (!await _connectivityService.isInternetAvailable) {
      emitter(SuggestionErrorState(state, ErrorType.noInternet));
      return;
    }
    try {
      final buffer = <ProductEntity>[];
      final gleephSuggestions = await _readHomeProductSuggestionsUseCase(null);

      if (gleephSuggestions.ok.isNotNullOrEmpty) {
        final orderedSuggestions = gleephSuggestions.ok!;
        orderedSuggestions.sort((a, b) => a.origin!.compareTo(b.origin!));
        buffer.addAll(orderedSuggestions);
      } else {
        final uSettingsResult = await _userSettingsUseCase(null);

        final suggestion = await _searchUseCase(SearchUseCaseParams(
            query: '',
            take: pageSize,
            sortOption: SortOption.mostRead,
            deviceLanguage: uSettingsResult.isOk
                ? (uSettingsResult.ok?.preferredLanguageCode ?? '')
                : '',
            skip: 0));
        if (suggestion.ok?.products.isNotNullOrEmpty ?? false) {
          buffer.addAll(suggestion.ok!.products ?? []);
        }
      }
      products = buffer;
      emitter(SuggestionStateLoadedState(products: buffer));
    } on APIRequestException catch (ex) {
      logError("API Error occured while initializing suggestions list vm",
          error: Exception(ex));
      emitter(SuggestionErrorState(state, ErrorType.serverError));
    } catch (e) {
      logError("An error occured while initialising vm for recommendations.",
          error: Exception(e));
      emitter(SuggestionErrorState(state, ErrorType.unknownError));
    }
  }

  void _errorDisplayed(
      ErrorDisplayedEvent event, Emitter<SuggestionState> emitter) {
    if (state is SuggestionErrorState) {
      emitter((state as SuggestionErrorState).previousState);
    }
  }
}
