part of 'account_bloc.dart';

@immutable
sealed class AccountEvent {}

final class InitConfigEvent extends AccountEvent {
  InitConfigEvent();
  List<Object> get props => [];
}

class InitAccountEvent extends AccountEvent {}

class SetAccountThemeEvent extends AccountEvent {
  // ignore: prefer_const_constructors_in_immutables
  SetAccountThemeEvent({required this.theme});
  final ThemeType theme;

  List<Object> get props => [theme];
}

class SetAccountLanguageEvent extends AccountEvent {
  // ignore: prefer_const_constructors_in_immutables
  SetAccountLanguageEvent(
      {required this.languageCode, required this.countryCode, this.context});
  final String languageCode;
  final String countryCode;
  final BuildContext? context;

  List<Object> get props => [languageCode, countryCode, context ?? ''];
}

class SetAccountDisplayHelpHintEvent extends AccountEvent {
  // ignore: prefer_const_constructors_in_immutables
  SetAccountDisplayHelpHintEvent({required this.display});
  final bool display;

  List<Object> get props => [display];
}
