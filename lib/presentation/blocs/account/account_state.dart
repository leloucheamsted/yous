part of 'account_bloc.dart';

@immutable
class AccountState extends Equatable {
  const AccountState(
      {this.theme = ThemeType.system,
      this.language = '',
      this.countryCode = '',
      this.stopHelpHint = false,
      this.isLisEtGagneVisible = false});
  AccountState copyWith({
    ThemeType? theme,
    String? language,
    String? countryCode,
    bool? stopHelpHint,
    bool? isLisEtGagneVisible,
  }) {
    return AccountState(
      theme: theme ?? this.theme,
      language: language ?? this.language,
      countryCode: countryCode ?? this.countryCode,
      stopHelpHint: stopHelpHint ?? this.stopHelpHint,
      isLisEtGagneVisible: isLisEtGagneVisible ?? this.isLisEtGagneVisible,
    );
  }

  final ThemeType theme;
  final String language;
  final String countryCode;
  final bool stopHelpHint;
  final bool isLisEtGagneVisible;
  @override
  List<Object> get props =>
      [theme, language, countryCode, stopHelpHint, isLisEtGagneVisible];
}
