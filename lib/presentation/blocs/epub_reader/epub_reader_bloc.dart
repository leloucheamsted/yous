import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/page_turned_entity.dart';
import 'package:youscribe/core/use_cases/reader/get_latest_bookmark_use_case.dart';
import 'package:youscribe/core/use_cases/reader/save_bookmark_use_case.dart';
import 'package:youscribe/infrastructure/service/reader_stats_service.dart';

part 'epub_reader_event.dart';
part 'epub_reader_state.dart';

class EpubReaderBloc extends Bloc<EpubReaderEvent, EpubReaderState> {
  EpubReaderBloc() : super(EpubReaderInitialState()) {
    on<InitEpubReaderEvent>(_onInitEpubReader);
    on<PageChangedEpubReaderEvent>(_onEpubReaderPageChanged);
    on<EpubReaderLoadedEvent>(_onEpubReaderLoaded);
  }

  final GetBookmarkUseCase _getBookmarkUseCase = locator();
  double _totalPages = 1;
  final SaveBookmarkUseCase _saveBookmarkUseCase = locator();
  final ReaderStatsService _readerStatsService = locator();
  Future<void> _onInitEpubReader(
      InitEpubReaderEvent event, Emitter<EpubReaderState> emitter) async {
    final bookmark = await _getBookmarkUseCase(event.productId);
    var startPage = 0;
    if (bookmark.isOk && bookmark.ok != null) {
      startPage = bookmark.ok!.pageNumber;
    }

    emitter(EpubReaderLoadedState(
        path: event.path, productId: event.productId, startPage: startPage));
  }

  Future<void> _onEpubReaderPageChanged(PageChangedEpubReaderEvent event,
      Emitter<EpubReaderState> emitter) async {
    final percentage = (event.currentPage / _totalPages) * 100;
    final currentState = state as EpubReaderLoadedState;

    await _saveBookmarkUseCase(SaveBookmarkUseCaseParameters(
        productId: currentState.productId,
        pageNumber: event.currentPage,
        progress: percentage));

/**
               
                Element.PageChangedCommand.Execute(new PageTurnedModel
                {
                    IdRef = args.State.IdRef,
                    ContentCFI = args.State.ContentCFI,
                    PageSize = args.State.PageSize(),
                    PagePosition = args.State.Progress(),
                    Percent = args.State.Percent(),
                    CurrentPage = args.State.SpineIndex
                });
                 
                 */

    await _readerStatsService.pageChanged(PageTurnedEntity(
        percent: percentage,
        pageSize: (ReaderStatsService.bookParts / 2) / _totalPages,
        pagePosition: event.currentPage.toDouble(),
        // idRef: newPageIndex.toString(),
        //contentCFI: ,
        currentPage: event.currentPage));
  }

  Future<void> _onEpubReaderLoaded(
      EpubReaderLoadedEvent event, Emitter<EpubReaderState> emitter) async {
    _totalPages = event.totalPages;
    final currentState = state as EpubReaderLoadedState;
    _readerStatsService.startReading(currentState.productId);
  }

  @override
  Future<void> close() async {
    await _readerStatsService.stopReading();
    await super.close();
  }
}
