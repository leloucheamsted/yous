// ignore: depend_on_referenced_packages

// ignore_for_file: prefer_is_empty
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/simple_library_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/use_cases/my_selections/create_new_selection_use_case.dart';
import 'package:youscribe/core/use_cases/my_selections/get_my_selection_use_case.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'my_selections_event.dart';
part 'my_selections_state.dart';

class MySelectionsBloc extends Bloc<MySelectionsEvent, MySelectionsState>
    with Debuggable, Loggable {
  MySelectionsBloc() : super(const MySelectionsInitial()) {
    on<InitMySelectionsEvent>(_init);
    on<CreateSelectionsEvent>(_create);
    on<DeleteSelectionsEvent>(_delete);
    on<RefreshMySelectionsEvent>(_refresh);
    _getMySelectionsUseCase = locator<GetMySelectionsUseCase>();
    _connectivityService = locator<ConnectivityService>();
    _createNewSelectionUseCase = locator<CreateNewSelectionUseCase>();
  }

  late final GetMySelectionsUseCase _getMySelectionsUseCase;
  late final CreateNewSelectionUseCase _createNewSelectionUseCase;
  List<SimpleLibraryEntity> _mySelections = [];

  late final ConnectivityService _connectivityService;

  @override
  String get debugName => 'MySelectionsBloc';

  Future<void> _init(
      InitMySelectionsEvent event, Emitter<MySelectionsState> emitter) async {
    try {
      final mySelections = await _getMySelectionsUseCase.call(null);
      if (mySelections.ok?.length != 0) {}

      if (await _connectivityService.isInternetAvailable) {
        logInfo('Loading online selections.');
        if (mySelections.isOk && mySelections.ok?.length != 0) {
          // todo:  SaveUserSelections will be called  here
          _mySelections = mySelections.ok!;
          _mySelections
              .sort((a, b) => a.label.toString().compareTo(b.label.toString()));

          emitter(MySelectionsLoadedState(mySelections: mySelections.ok ?? []));
          return;
        }
        emitter(const MySelectionsEmptyState());
        return;
      }
    } on APIRequestException catch (ex) {
      logError('API Error occured while initializing my selections vm',
          error: ex);
      emitter(const MySelectionsExceptionState());
    } catch (e) {
      logError("Error while loading current user's selections.",
          error: Exception(e));
    }
    logInfo("Get all selection of current user");
  }

  Future<void> _create(
      CreateSelectionsEvent event, Emitter<MySelectionsState> emitter) async {
    emitter(
        MySelectionsLoadedState(mySelections: _mySelections, isLoading: true));
    final createSelection = await _createNewSelectionUseCase(
        CreateNewSelectionsUseCaseParameters(event.name, event.isPublic));
    if (createSelection.isErr) {
      logError("Error of selection creation",
          error: Exception(createSelection.err));
      emitter(const MySelectionsExceptionState());
      await onRefresh(emitter);
    }
    await onRefresh(emitter);
  }

  Future<void> _refresh(RefreshMySelectionsEvent event,
      Emitter<MySelectionsState> emitter) async {
    logInfo("Refresh selection of current user");
    await onRefresh(emitter);
  }

  Future<void> _delete(
      DeleteSelectionsEvent event, Emitter<MySelectionsState> emitter) async {
    _mySelections = List.from(
        _mySelections.where((element) => element.id != event.selection.id));
    emitter(MySelectionsLoadedState(mySelections: List.from(_mySelections)));
  }

  Future<void> onRefresh(Emitter<MySelectionsState> emitter) async {
    try {
      logInfo("Loading online selections.");
      final onlineSelections = await _getMySelectionsUseCase.call(null);
      if (onlineSelections.ok!.isNotEmpty) {
        // call save online service in local storage
        _mySelections = onlineSelections.ok!;

        _mySelections
            .sort((a, b) => a.label.toString().compareTo(b.label.toString()));
        try {
          emitter(MySelectionsLoadedState(
              mySelections: List.from(onlineSelections.ok!)));
        } catch (e) {
          logError("an exception occurred while loading online selections.",
              error: Exception(e));
        }
      }
    } catch (e) {
      logError("Error while refreshing user's selections.",
          error: Exception(e));
    }
  }
}
