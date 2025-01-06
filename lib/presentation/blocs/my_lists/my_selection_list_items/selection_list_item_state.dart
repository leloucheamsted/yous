part of 'selection_list_item_cubit.dart';

sealed class SelectionListItemState extends Equatable {
  const SelectionListItemState();

  @override
  List<Object> get props => [];
}

final class SelectionListItemInitial extends SelectionListItemState {}

final class SelectionListItemAttributeChanged extends SelectionListItemState {
  const SelectionListItemAttributeChanged({
    this.label,
    this.totalCount,
    this.isPublic,
  });
  final String? label;
  final int? totalCount;
  final bool? isPublic;

  @override
  List<Object> get props => [label!, totalCount!, isPublic!];
}
