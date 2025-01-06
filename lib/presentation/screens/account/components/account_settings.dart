// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:youscribe/presentation/blocs/account/account_bloc.dart';
import 'package:youscribe/presentation/blocs/app/app_bloc_bloc.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/styles/youscribe_theme.dart';
import 'package:youscribe/utilities/constants.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});

  //TODO: Remove magic strings and repetitive code.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
      context.read<AccountBloc>().add(InitAccountEvent());
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(AppLocalizations.of(context)!.displayHelpHint,
                      style: WidgetStyles.caption2TextStyle
                          .copyWith(overflow: TextOverflow.clip)),
                ),
                Switch(
                  trackOutlineColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                  inactiveTrackColor: YouScribeColors.superLightGray,
                  inactiveThumbColor: YouScribeColors.primaryAppColor,
                  activeColor: YouScribeColors.primaryAppColor,
                  value: state.stopHelpHint,
                  onChanged: (value) {
                    context
                        .read<AccountBloc>()
                        .add(SetAccountDisplayHelpHintEvent(display: value));
                  },
                )
              ],
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(AppLocalizations.of(context)!.themesList,
                  style: WidgetStyles.textStyle
                      .copyWith(overflow: TextOverflow.clip)),
              InkWell(
                onTap: () {
                  _changeTheme(ThemeType.system, context);
                },
                child: Row(
                  children: [
                    Checkbox(
                      value: state.theme == ThemeType.system ? true : false,
                      side: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      activeColor: YouScribeColors.primaryAppColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      splashRadius: 10,
                      onChanged: (val) {
                        _changeTheme(ThemeType.system, context);
                      },
                    ),
                    Text(AppLocalizations.of(context)!.defaultTheme,
                        style: WidgetStyles.caption1TextStyle
                            .copyWith(overflow: TextOverflow.clip)),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _changeTheme(ThemeType.darkTheme, context);
                },
                child: Row(
                  children: [
                    Checkbox(
                      value: state.theme == ThemeType.darkTheme ? true : false,
                      side: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      activeColor: YouScribeColors.primaryAppColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      splashRadius: 10,
                      onChanged: (val) {
                        _changeTheme(ThemeType.darkTheme, context);
                      },
                    ),
                    Text(AppLocalizations.of(context)!.darkTheme,
                        style: WidgetStyles.caption1TextStyle
                            .copyWith(overflow: TextOverflow.clip)),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _changeTheme(ThemeType.lightTheme, context);
                },
                child: Row(
                  children: [
                    Checkbox(
                      value: state.theme == ThemeType.lightTheme ? true : false,
                      side: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      activeColor: YouScribeColors.primaryAppColor,
                      overlayColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.background),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      splashRadius: 10,
                      onChanged: (val) {
                        _changeTheme(ThemeType.lightTheme, context);
                      },
                    ),
                    Text(AppLocalizations.of(context)!.lightTheme,
                        style: WidgetStyles.caption1TextStyle
                            .copyWith(overflow: TextOverflow.clip)),
                  ],
                ),
              ),
            ]),
            const SizedBox(height: 10),
            Divider(
                thickness: 0.5,
                color: YouScribeColors.blackColor.withOpacity(0.4)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.languages,
                    style: WidgetStyles.textStyle
                        .copyWith(overflow: TextOverflow.clip)),
                InkWell(
                  onTap: () {
                    _changeLanguage(context, 'en', 'US');
                  },
                  child: Row(
                    children: [
                      Checkbox(
                        value: state.language == 'en' ? true : false,
                        side: BorderSide(
                          width: 2,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        activeColor: YouScribeColors.accentColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        splashRadius: 10,
                        onChanged: (val) {
                          _changeLanguage(context, 'en', 'US');
                        },
                      ),
                      Text(AppLocalizations.of(context)!.englishLanguage,
                          style: WidgetStyles.caption1TextStyle
                              .copyWith(overflow: TextOverflow.clip)),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _changeLanguage(context, 'fr', 'FR');
                  },
                  child: Row(
                    children: [
                      Checkbox(
                        value: state.language == 'fr' ? true : false,
                        side: BorderSide(
                          width: 2,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        activeColor: YouScribeColors.accentColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        splashRadius: 10,
                        onChanged: (val) {
                          _changeLanguage(context, 'fr', 'FR');
                        },
                      ),
                      Text(AppLocalizations.of(context)!.frenchLanguage,
                          style: WidgetStyles.caption1TextStyle
                              .copyWith(overflow: TextOverflow.clip)),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _changeLanguage(context, 'ar', 'MA');
                  },
                  child: Row(
                    children: [
                      Checkbox(
                        value: state.language == 'ar' ? true : false,
                        side: BorderSide(
                          width: 2,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        activeColor: YouScribeColors.accentColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        splashRadius: 10,
                        onChanged: (val) {
                          _changeLanguage(context, 'ar', 'MA');
                        },
                      ),
                      Text(AppLocalizations.of(context)!.arabeLanguage,
                          style: WidgetStyles.caption1TextStyle
                              .copyWith(overflow: TextOverflow.clip)),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      );
    });
  }

  void _changeTheme(ThemeType theme, BuildContext context) {
    context.read<AccountBloc>().add(SetAccountThemeEvent(theme: theme));
    Provider.of<YouScribeTheme>(context, listen: false).loadTheme(theme); 
  }

  void _changeLanguage(BuildContext context, String language, String country) {
    context.read<AccountBloc>().add(SetAccountLanguageEvent(
        languageCode: language, countryCode: country, context: context));
    context.read<AppBloc>().add(SetAppLanguageEvent(language, country));
  }
}
