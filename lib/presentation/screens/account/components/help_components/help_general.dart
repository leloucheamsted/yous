// ignore_for_file: use_named_constants

import 'dart:io';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youscribe/presentation/blocs/help/help_cubit.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class HelpGeneral extends StatefulWidget {
  const HelpGeneral({required this.baseUrl, super.key});

  final String baseUrl;
  @override
  State<HelpGeneral> createState() => _HelpGeneralState();
}

class _HelpGeneralState extends State<HelpGeneral> {
  final GlobalKey<ExpansionTileCardState> card1 = GlobalKey();
  final GlobalKey<ExpansionTileCardState> card2 = GlobalKey();
  final GlobalKey<ExpansionTileCardState> card3 = GlobalKey();
  final GlobalKey<ExpansionTileCardState> card4 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final cubit = HelpCubit();
    return ExpansionTileCard(
      elevation: 0,
      animateTrailing: true,
      baseColor: Colors.transparent,
      expandedColor: Colors.transparent,
      expandedTextColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(0),
      finalPadding: const EdgeInsets.all(0),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.faqTitle1,
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
              key: card1,
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
                    AppLocalizations.of(context)!.faqTitle1Step1Title,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).dividerColor,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)!.faqTitle1Step1Text1,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      overflow: TextOverflow.clip,
                      color: YouScribeColors.secondaryTextColor),
                ),
                Text(
                  AppLocalizations.of(context)!.faqTitle1Step1Text2,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      overflow: TextOverflow.clip,
                      color: YouScribeColors.secondaryTextColor),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    RichText(
                      textDirection: TextDirection.rtl,
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: AppLocalizations.of(context)!
                                  .faqTitle1Step1Text3Part1,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      overflow: TextOverflow.clip,
                                      color:
                                          YouScribeColors.secondaryTextColor)),
                          TextSpan(
                              text: AppLocalizations.of(context)!
                                  .faqTitle1Step1Text3Part2,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      overflow: TextOverflow.clip,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          YouScribeColors.secondaryTextColor)),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.faqTitle1Step1Text4,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          overflow: TextOverflow.clip,
                          color: YouScribeColors.secondaryTextColor),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await cubit.launchURL(
                            '${widget.baseUrl}/Static/Faq#faq-1_general');
                      },
                      child: Text(
                        AppLocalizations.of(context)!.faqTitle1Step1Text5,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            overflow: TextOverflow.clip,
                            decoration: TextDecoration.underline,
                            color: Colors.blue),
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
              key: card2,
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
                      AppLocalizations.of(context)!.faqTitle1Step2Title,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                  AppLocalizations.of(context)!.faqTitle1Step2Text1,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      overflow: TextOverflow.clip,
                      color: YouScribeColors.secondaryTextColor),
                ),
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.faqTitle1Step2Text2,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          overflow: TextOverflow.clip,
                          color: YouScribeColors.secondaryTextColor),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      AppLocalizations.of(context)!.faqTitle1Step2Text3,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          overflow: TextOverflow.clip,
                          color: YouScribeColors.secondaryTextColor),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      AppLocalizations.of(context)!.faqTitle1Step2Text4,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          overflow: TextOverflow.clip,
                          color: YouScribeColors.secondaryTextColor),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      AppLocalizations.of(context)!.faqTitle1Step2Text5,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          overflow: TextOverflow.clip,
                          color: YouScribeColors.secondaryTextColor),
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
              key: card3,
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
                      AppLocalizations.of(context)!.faqTitle1Step3Title,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                  Platform.isAndroid
                      ? AppLocalizations.of(context)!.faqTitle1Step3Text1Android
                      : AppLocalizations.of(context)!.faqTitle1Step3Text1iOS,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      overflow: TextOverflow.clip,
                      color: YouScribeColors.secondaryTextColor),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                        child: Platform.isAndroid
                            ? GestureDetector(
                                onTap: () async {
                                  await cubit.launchURL(
                                      '${widget.baseUrl}/Static?name=cgu');
                                },
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .faqTitle1Step3Text3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          overflow: TextOverflow.clip,
                                          color: Colors.blue),
                                ),
                              )
                            : null),
                    GestureDetector(
                      onTap: () async {
                        await cubit
                            .launchURL('${widget.baseUrl}/Static?name=cgu');
                      },
                      child: Text(
                        AppLocalizations.of(context)!.faqTitle1Step3Text3,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            overflow: TextOverflow.clip, color: Colors.blue),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await cubit
                            .launchURL('${widget.baseUrl}/Static?name=charte');
                      },
                      child: Text(
                        AppLocalizations.of(context)!.faqTitle1Step3Text4,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            overflow: TextOverflow.clip, color: Colors.blue),
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
                      AppLocalizations.of(context)!.faqTitle1Step5Title,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                  AppLocalizations.of(context)!.faqTitle1Step5Text1,
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
              key: card4,
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
                      AppLocalizations.of(context)!.faqTitle1Step6Title,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                  AppLocalizations.of(context)!.faqTitle1Step6Text1,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      overflow: TextOverflow.clip,
                      color: YouScribeColors.secondaryTextColor),
                ),
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await cubit.launchURL(
                            '${widget.baseUrl}/Static/Faq#faq-unsubscription');
                      },
                      child: Text(
                        AppLocalizations.of(context)!.faqTitle1Step6Text2Part1,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            overflow: TextOverflow.clip, color: Colors.blue),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      AppLocalizations.of(context)!.faqTitle1Step6Text3,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          overflow: TextOverflow.clip,
                          color: YouScribeColors.secondaryTextColor),
                    ),
                    Text(
                      AppLocalizations.of(context)!.faqTitle1Step6Text4,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          overflow: TextOverflow.clip,
                          color: YouScribeColors.secondaryTextColor),
                    ),
                    Text(
                      AppLocalizations.of(context)!.faqTitle1Step6Text5,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          overflow: TextOverflow.clip,
                          color: YouScribeColors.secondaryTextColor),
                    ),
                    Text(
                      AppLocalizations.of(context)!.faqTitle1Step6Text6,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          overflow: TextOverflow.clip,
                          color: YouScribeColors.secondaryTextColor),
                    ),
                    Text(
                      AppLocalizations.of(context)!.faqTitle1Step6Text7,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          overflow: TextOverflow.clip,
                          color: YouScribeColors.secondaryTextColor),
                    ),
                  ],
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
