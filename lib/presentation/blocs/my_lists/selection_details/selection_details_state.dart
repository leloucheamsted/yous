part of 'selection_details_bloc.dart';

sealed class SelectionDetailsState extends Equatable {
  const SelectionDetailsState();

  @override
  List<Object> get props => [];
}

final class SelectionDetailsInitial extends SelectionDetailsState {}
