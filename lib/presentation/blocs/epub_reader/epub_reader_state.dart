part of 'epub_reader_bloc.dart';

sealed class EpubReaderState extends Equatable {
  const EpubReaderState();
  
  @override
  List<Object> get props => [];
}

final class EpubReaderInitialState extends EpubReaderState {}

final class EpubReaderLoadedState extends EpubReaderState {
  const EpubReaderLoadedState(
      {required this.path, required this.productId, this.startPage = 0});

  final String path;
  final int productId;
  final int startPage;

  @override
  List<Object> get props => [path, productId, startPage];
}
