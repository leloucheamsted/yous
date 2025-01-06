part of 'epub_reader_bloc.dart';

sealed class EpubReaderEvent extends Equatable {
  const EpubReaderEvent();

  @override
  List<Object> get props => [];
}

class InitEpubReaderEvent extends EpubReaderEvent {
  const InitEpubReaderEvent({required this.path, required this.productId});

  final String path;
  final int productId;
}

class PageChangedEpubReaderEvent extends EpubReaderEvent {
  const PageChangedEpubReaderEvent(
      {required this.currentPage,
      required this.spineIndex,
      required this.href,
      required this.percentage});

  final int currentPage;
  final int spineIndex;
  final int percentage;
  final String href;
}

class EpubReaderLoadedEvent extends EpubReaderEvent {
  const EpubReaderLoadedEvent({required this.totalPages});

  final double totalPages;
}
