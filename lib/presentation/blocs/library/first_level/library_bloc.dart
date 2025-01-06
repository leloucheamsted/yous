import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/product_category_entity.dart';
import 'package:youscribe/core/entities/product_facet_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe/core/use_cases/search/get_first_level_search_options_usecase.dart';
import 'package:youscribe/core/use_cases/search/get_n_level_search_options_use_case.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe/presentation/screens/library/library_screen.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState>
    with Debuggable, Loggable {
  LibraryBloc() : super(LibraryInitialState()) {
    on<LibraryInitEvent>(_init);
    on<FirstSearchOptionSelectedEvent>(_firstLevelSelected);
    on<ErrorDisplayedEvent>(_errorDisplayed);
  }

  final GetFirstLevelSearchOptionsUseCase _getFirstLevelSearchOptionsUseCase =
      locator();
  final GetNLevelSearchOptionUseCase getNLevelSearchOptionUseCase = locator();
  late final ConnectivityService _connectivityService = locator();
  late final UserAccountRepository _userAccountRepository = locator();

  List<BaseProductFacetEntity> _firstLevelList = [];
  List<BaseProductFacetEntity> _secondtLevelList = [];
  int currentThemeIndex = 0;
  bool _isYsClassification = false;

  @override
  String get debugName => 'LibraryBloc';

  Future<void> _init(
      LibraryInitEvent event, Emitter<LibraryState> emitter) async {
    emitter(LibraryInitialState());
    if (!await _connectivityService.isInternetAvailable) {
      emitter(LibraryExceptionState(
          LibraryLoadedState(
              _firstLevelList, _secondtLevelList, currentThemeIndex, false),
          ErrorType.noInternet));
      return;
    }
    final currentUaser = await AuthenticationManager.getCurrentUser();
    final isYsClassification =
        currentUaser?.isYSClassificationSettings ?? false;
    _isYsClassification = isYsClassification;
    final firstLevel = await _getFirstLevelSearchOptionsUseCase(null);
    if (firstLevel.isErr) {
      logError('Error init first search options ${firstLevel.err!.message}',
          error: firstLevel.err);
      if (firstLevel.err is APIRequestException) {
        emitter(LibraryExceptionState(
            LibraryLoadedState(
                _firstLevelList, _secondtLevelList, currentThemeIndex, false),
            ErrorType.serverError));
      } else {
        emitter(LibraryExceptionState(
            LibraryLoadedState(
                _firstLevelList, _secondtLevelList, currentThemeIndex, false),
            ErrorType.unknownError));
      }
      return;
    }
    _firstLevelList = [];
    if (isYsClassification) {
      final cat1 = firstLevel.ok!.firstWhere((p) => p.name == RootName.books);

      final cat2 =
          firstLevel.ok!.firstWhere((p) => p.name == RootName.audiobooks);

      _firstLevelList
        ..add(cat1)
        ..add(cat2)
        ..add(firstLevel.ok!.firstWhere((p) => p.name == RootName.poodcast))
        ..add(firstLevel.ok!.firstWhere((p) => p.name == RootName.bd))
        ..add(firstLevel.ok!.firstWhere((p) => p.name == RootName.press));

      currentThemeIndex = _firstLevelList
              .firstWhere((element) => element.name == RootName.books)
              .id ??
          0;
    } else {
      _firstLevelList = firstLevel.ok!;
      await _userAccountRepository
          .setClassificationTree(firstLevel.ok! as List<ProductCategoryEntity>);
      currentThemeIndex = _firstLevelList[0].id ?? 0;
    }

    await _firstLevelSelected(
        FirstSearchOptionSelectedEvent(firstLevelOption: _firstLevelList[0]),
        emitter);
  }

  Future<void> _firstLevelSelected(FirstSearchOptionSelectedEvent event,
      Emitter<LibraryState> emitter) async {
    if (!await _connectivityService.isInternetAvailable) {
      emitter(LibraryExceptionState(
          LibraryLoadedState(_firstLevelList, _secondtLevelList, 0, false),
          ErrorType.noInternet));
      return;
    }

    final result = await getNLevelSearchOptionUseCase(
        GetNLevelSearchOptionUseCaseParams(
            isFromFirstLevel: true, facetId: event.firstLevelOption.id!));
    if (result.isErr) {
      logError('Error init second search options ${result.err!.message}',
          error: result.err);
      if (result.err is APIRequestException) {
        emitter(LibraryExceptionState(
            LibraryLoadedState(
                _firstLevelList, _secondtLevelList, currentThemeIndex, false),
            ErrorType.serverError));
      } else {
        emitter(LibraryExceptionState(
            LibraryLoadedState(_firstLevelList, _secondtLevelList,
                currentThemeIndex, _isYsClassification),
            ErrorType.unknownError));
      }
      return;
    }
    _secondtLevelList = result.ok!;
    _secondtLevelList.sort((a, b) {
      return a.label!.toLowerCase().compareTo(b.label!.toLowerCase());
    });

    emitter(LibraryLoadedState(_firstLevelList, _secondtLevelList,
        currentThemeIndex, _isYsClassification));
  }

  Future<void> _errorDisplayed(
      ErrorDisplayedEvent event, Emitter<LibraryState> emitter) async {
    if (state is LibraryExceptionState) {
      emitter((state as LibraryExceptionState).previousState);
    }
  }

  Future<void> changeIndex(int index) async {
    currentThemeIndex = index;
    emit(LibraryLoadedState(
        _firstLevelList, _secondtLevelList, index, _isYsClassification));
  }
}
