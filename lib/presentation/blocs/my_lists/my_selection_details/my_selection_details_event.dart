part of 'my_selection_details_bloc.dart';

@immutable
sealed class MySelectionDetailsEvent extends Equatable {
  const MySelectionDetailsEvent();

  @override
  List<Object> get props => [];
}

class InitMySelectionDetailsEvent extends MySelectionDetailsEvent {
  const InitMySelectionDetailsEvent(this.selectionId);
  final int selectionId;
  @override
  List<Object> get props => [];
}

class ErrorDisplayedEvent extends MySelectionDetailsEvent {
  const ErrorDisplayedEvent();
}

class LoadNewPageEvent extends MySelectionDetailsEvent {
  const LoadNewPageEvent();

  @override
  List<Object> get props => [];
}

class DeleteProdutEvent extends MySelectionDetailsEvent {
  const DeleteProdutEvent(this.productId);
  final int productId;

  @override
  List<Object> get props => [];
}
