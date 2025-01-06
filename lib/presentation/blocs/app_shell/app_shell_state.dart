// ignore_for_file: must_be_immutable

part of 'app_shell_bloc.dart';

sealed class AppShellState extends Equatable {
  const AppShellState();

  @override
  List<Object> get props => [];
}

final class AppShellInitialState extends AppShellState {}
