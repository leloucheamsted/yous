part of 'my_selections_bloc.dart';

sealed class MySelectionsEvent extends Equatable {
  const MySelectionsEvent();

  @override
  List<Object> get props => [];
}

class InitMySelectionsEvent extends MySelectionsEvent {
  const InitMySelectionsEvent();

  @override
  List<Object> get props => [];
}

class RefreshMySelectionsEvent extends MySelectionsEvent {}

class CreateSelectionsEvent extends MySelectionsEvent {
  const CreateSelectionsEvent(this.name, this.isPublic);
  final String name;
  final bool isPublic;

  @override
  List<Object> get props => [name, isPublic];
}

class DeleteSelectionsEvent extends MySelectionsEvent {
  const DeleteSelectionsEvent(this.selection);
  final SimpleLibraryEntity selection;

  @override
  List<Object> get props => [selection];
}
