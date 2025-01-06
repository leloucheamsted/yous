// ignore_for_file: use_named_constants

import 'dart:async';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/utilities/view_utilities.dart';

class HelpTokens extends StatelessWidget {
  const HelpTokens(
      // ignore: lines_longer_than_80_chars
      {required this.keys,
      required this.scrollViewController,
      required this.isTokenExpand,
      super.key});
  final GlobalKey<ExpansionTileCardState> keys;
  final ScrollController scrollViewController;
  final bool isTokenExpand;

  @override
  Widget build(BuildContext context) {
    if (isTokenExpand) {
      keys.currentState?.expand();
      Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if (keys.globalPaintBounds?.top != null) {
          scrollViewController.animateTo(keys.globalPaintBounds!.top,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
          timer.cancel();
        }
      });
    }

    return ExpansionTileCard(
      elevation: 0,
      key: keys,
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
            AppLocalizations.of(context)!.faqTItle5,
            style: Theme.of(context).textTheme.labelLarge,
          )
        ],
      ),
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.faqTItle5Step1Text1,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  overflow: TextOverflow.clip,
                  color: YouScribeColors.secondaryTextColor),
            ),
            const SizedBox(height: 10),
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
                      AppLocalizations.of(context)!.faqTItle5Step2Title,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).dividerColor,
                          overflow: TextOverflow.clip,
                          fontSize: WidgetStyles.bodySize,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)!.faqTItle5Step2Text1,
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
                      AppLocalizations.of(context)!.faqTItle5Step3Title,
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
                  AppLocalizations.of(context)!.faqTItle5Step3Text1,
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
                      AppLocalizations.of(context)!.faqTItle5Step4Title,
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
                  AppLocalizations.of(context)!.faqTItle5Step4Text1,
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
                      AppLocalizations.of(context)!.faqTItle5Step5Title,
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
                  AppLocalizations.of(context)!.faqTItle5Step5Text1,
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
                      AppLocalizations.of(context)!.faqTItle5Step6Title,
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
                  AppLocalizations.of(context)!.faqTItle5Step6Text1,
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
                      AppLocalizations.of(context)!.faqTItle5Step7Title,
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
                const SizedBox(height: 15),
                Text(
                  AppLocalizations.of(context)!.faqTItle5Step7Text1,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      overflow: TextOverflow.clip,
                      color: YouScribeColors.secondaryTextColor),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
