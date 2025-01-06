// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/product_facet_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/use_cases/search/get_n_level_search_options_use_case.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'classifications_event.dart';
part 'classifications_state.dart';

class ClassificationsBloc
    extends Bloc<ClassificationsEvent, ClassificationsState>
    with Debuggable, Loggable {
  ClassificationsBloc() : super(ClassificationsInitialState()) {
    on<ClassificationsInitialEvent>(_initEvent);
    on<SeeAllSelectedEvent>(_seeAllSelectedEvent);
    on<ErrorDisplayedEvent>(_errorDisplayed);
    on<FacetSelectedEvent>(_facetseeAllSelectedEvent);
  }

  final GetNLevelSearchOptionUseCase _getNLevelSearchOptionUseCase = locator();
  late final ConnectivityService _connectivityService;

  @override
  String get debugName => 'ClassificationsBloc';

  Future<void> _initEvent(ClassificationsInitialEvent event,
      Emitter<ClassificationsState> emitter) async {
    final isFromFirstLevel = event.previousFacets.length == 1;
    final result = await _getNLevelSearchOptionUseCase(
        GetNLevelSearchOptionUseCaseParams(
            isFromFirstLevel: isFromFirstLevel,
            facetId: event.selectedFacetId));

    if (result.isErr) {
      logError(
          // ignore: lines_longer_than_80_chars
          'Error getting facet list ${event.selectedFacetId} ${result.err!.message} Error: ${result.err}',
          error: result.err);

      if (result.err is APIRequestException) {
        if (!await _connectivityService.isInternetAvailable) {
          emitter(ClassificationErrorState(state, ErrorType.noInternet));
        } else {
          emitter(ClassificationErrorState(state, ErrorType.serverError));
        }
      } else {
        emitter(ClassificationErrorState(state, ErrorType.unknownError));
      }
      return; //Emit the appropriate state.
    }
    result.ok?.sort((a, b) {
      return a.label!.toLowerCase().compareTo(b.label!.toLowerCase());
    });
    emitter(ClassificationsLoadedState(
        productFacets: result.ok!, currentFacetId: event.selectedFacetId));
  }

  Future<void> _seeAllSelectedEvent(
      SeeAllSelectedEvent event, Emitter<ClassificationsState> emitter) async {}

  Future<void> _facetseeAllSelectedEvent(
      FacetSelectedEvent event, Emitter<ClassificationsState> emitter) async {
    //TODO: Note that, when a classification is selected,
    //You have to check if it has children. If it does, you navigate to the
    //Classifications bloc again, to display the other list of facets
    //else, navigate to the search results page.
  }

  Future<bool> isHasChildreen(BaseProductFacetEntity selectedFacet) async {
    final result = await _getNLevelSearchOptionUseCase(
        GetNLevelSearchOptionUseCaseParams(
            isFromFirstLevel: false, facetId: selectedFacet.id!));
    if (result.isErr) {
      logError('Error check  search facet children ${result.err!.message}',
          error: result.err);
      if (result.err is APIRequestException) {
        if (!await _connectivityService.isInternetAvailable) {
          emit(ClassificationErrorState(state, ErrorType.noInternet));
        } else {
          emit(ClassificationErrorState(state, ErrorType.serverError));
        }
      } else {
        emit(ClassificationErrorState(state, ErrorType.unknownError));
      }
      return false;
    }
    return result.ok.isNull || result.ok!.isEmpty;
  }

  void _errorDisplayed(
      ErrorDisplayedEvent event, Emitter<ClassificationsState> emitter) {
    if (state is ClassificationErrorState) {
      emitter((state as ClassificationErrorState).previousState);
    }
  }
}
