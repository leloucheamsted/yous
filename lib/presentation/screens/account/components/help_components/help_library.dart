// ignore_for_file: use_named_constants

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class HelpLibrary extends StatelessWidget {
  const HelpLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
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
            AppLocalizations.of(context)!.faqTitle3,
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
              AppLocalizations.of(context)!.faqTitle3Step1Text1,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  overflow: TextOverflow.clip,
                  color: YouScribeColors.secondaryTextColor),
            ),
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
                    AppLocalizations.of(context)!.faqTitle3Step1Title,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).dividerColor,
                        fontSize: WidgetStyles.bodySize,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)!.faqTitle3Step2Text1,
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
                      AppLocalizations.of(context)!.faqTitle3Step2Title,
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
                  AppLocalizations.of(context)!.faqTitle3Step2Text1,
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
                      AppLocalizations.of(context)!.faqTitle3Step3Title,
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
                  AppLocalizations.of(context)!.faqTitle3Step3Text1,
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
                      AppLocalizations.of(context)!.faqTitle3Step4Title,
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
                  AppLocalizations.of(context)!.faqTitle3Step4Text1,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      overflow: TextOverflow.clip,
                      color: YouScribeColors.secondaryTextColor),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
