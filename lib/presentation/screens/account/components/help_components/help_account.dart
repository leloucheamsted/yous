// ignore_for_file: use_named_constants

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youscribe/presentation/blocs/help/help_cubit.dart';
import 'package:youscribe/presentation/screens/account/components/account_dialog_view.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class HelpAccount extends StatefulWidget {
  const HelpAccount({required this.baseUrl, required this.cubit, super.key});
  final String baseUrl;
  final HelpCubit cubit;

  @override
  State<HelpAccount> createState() => _HelpAccountState();
}

class _HelpAccountState extends State<HelpAccount> {
  final cubit = HelpCubit();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ExpansionTileCard(
          elevation: 0,
          animateTrailing: true,
          baseColor: Colors.transparent,
          expandedColor: Theme.of(context).scaffoldBackgroundColor,
          expandedTextColor: Theme.of(context).dividerColor,
          contentPadding: const EdgeInsets.all(0),
          finalPadding: const EdgeInsets.all(0),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.faqTitle2,
                style: Theme.of(context).textTheme.labelLarge,
              )
            ],
          ),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpansionTileCard(
                  elevation: 0,
                  animateTrailing: true,
                  baseColor: Colors.transparent,
                  expandedColor: Theme.of(context).scaffoldBackgroundColor,
                  expandedTextColor: Theme.of(context).dividerColor,
                  contentPadding: const EdgeInsets.all(0),
                  finalPadding: const EdgeInsets.all(0),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.faqTitle2Step1Title,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).dividerColor,
                            fontSize: WidgetStyles.bodySize,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)!.faqTitle2Step1Text1,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          overflow: TextOverflow.clip,
                          color: YouScribeColors.secondaryTextColor),
                    ),
                  ],
                ),
                Divider(
                    thickness: 0.5,
                    color: YouScribeColors.blackColor.withOpacity(0.4)),
                ExpansionTileCard(
                  elevation: 0,
                  animateTrailing: true,
                  baseColor: Colors.transparent,
                  expandedColor: Theme.of(context).scaffoldBackgroundColor,
                  expandedTextColor: Theme.of(context).dividerColor,
                  contentPadding: const EdgeInsets.all(0),
                  finalPadding: const EdgeInsets.all(0),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          AppLocalizations.of(context)!.faqTitle2Step2Title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  overflow: TextOverflow.clip,
                                  color: Theme.of(context).dividerColor,
                                  fontSize: WidgetStyles.bodySize,
                                  fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                  children: <Widget>[
                    Row(
                      children: [
                        Flexible(
                          child: RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                    text: AppLocalizations.of(context)!
                                        .faqTitle2Step2Text1Part1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            overflow: TextOverflow.clip,
                                            color: YouScribeColors
                                                .secondaryTextColor)),
                                TextSpan(
                                    text: AppLocalizations.of(context)!
                                        .faqTitle2Step2Text1Part2,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        cubit.launchURL(
                                            '${widget.baseUrl}/Account/Settings#account-password');
                                      },
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            overflow: TextOverflow.clip,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.blue)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                    thickness: 0.5,
                    color: YouScribeColors.blackColor.withOpacity(0.4)),
                ExpansionTileCard(
                  elevation: 0,
                  animateTrailing: true,
                  baseColor: Colors.transparent,
                  expandedColor: Theme.of(context).scaffoldBackgroundColor,
                  expandedTextColor: Theme.of(context).dividerColor,
                  contentPadding: const EdgeInsets.all(0),
                  finalPadding: const EdgeInsets.all(0),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          AppLocalizations.of(context)!.faqTitle2Step3Title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  overflow: TextOverflow.clip,
                                  color: Theme.of(context).dividerColor,
                                  fontSize: WidgetStyles.bodySize,
                                  fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)!.faqTitle2Step3Text1,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          overflow: TextOverflow.clip,
                          color: YouScribeColors.secondaryTextColor),
                    ),
                    const SizedBox(height: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            // await context.pushNamed(Routes.recommandations);
                            final delete =
                                await AccountDialoView.deleteAccountAlert(
                                    context: context);
                            if (delete) {
                              await widget.cubit.deleteAccount();
                            }
                          },
                          child: Text(
                            AppLocalizations.of(context)!.faqTitle2Step3Text2,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    decoration: TextDecoration.underline,
                                    overflow: TextOverflow.clip,
                                    color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
