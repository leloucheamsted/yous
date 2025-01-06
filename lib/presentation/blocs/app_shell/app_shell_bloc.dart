// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_shell_event.dart';
part 'app_shell_state.dart';

class AppShellBloc extends Bloc<AppShellEvent, AppShellState> {
  AppShellBloc() : super(AppShellInitialState()) {
    on<AppShellEvent>((event, emit) {});
  }
}
