// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selection_details_event.dart';
part 'selection_details_state.dart';

class SelectionDetailsBloc
    extends Bloc<SelectionDetailsEvent, SelectionDetailsState> {
  SelectionDetailsBloc() : super(SelectionDetailsInitial()) {
    on<SelectionDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
