// ignore_for_file: use_named_constants

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/presentation/blocs/help/help_cubit.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class HelpContact extends StatelessWidget {
  const HelpContact({required this.baseUrl, super.key});
  final String baseUrl;
  @override
  Widget build(BuildContext context) {
    final cubit = HelpCubit();
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
          Text(AppLocalizations.of(context)!.faqTitle4,
              style: Theme.of(context).textTheme.labelLarge)
        ],
      ),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.faqTitle4Step1Text1Part1,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  overflow: TextOverflow.clip,
                  color: YouScribeColors.secondaryTextColor),
            ),
            GestureDetector(
              onTap: () async {
                final currentUser =
                    await AuthenticationManager.getCurrentUser();
                final clientInfo = AppLocalizations.of(context)!
                    .supportRequestEmailHeader(currentUser?.email ?? '',
                        currentUser?.id.toString() ?? '');
                await cubit.mailToSupportYouscribe(clientInfo);
              },
              child: Text(
                "user.support@youscribe.com",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(overflow: TextOverflow.clip, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.faqTitle4Step1Text2,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: YouScribeColors.secondaryTextColor),
            ),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.faqTitle4Step1Text3,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      overflow: TextOverflow.clip,
                      color: YouScribeColors.secondaryTextColor),
                ),
              ],
            ),
            Text(
              AppLocalizations.of(context)!.faqTitle4Step1Text4,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  overflow: TextOverflow.clip,
                  color: YouScribeColors.secondaryTextColor),
            ),
            Text(
              AppLocalizations.of(context)!.faqTitle4Step1Text5,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  overflow: TextOverflow.clip,
                  color: YouScribeColors.secondaryTextColor),
            ),
            const SizedBox(height: 15),
            Text(
              AppLocalizations.of(context)!.faqTitle4Step1Text6,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  overflow: TextOverflow.clip,
                  color: YouScribeColors.secondaryTextColor),
            ),
          ],
        ),
        Divider(
            thickness: 0.5, color: YouScribeColors.blackColor.withOpacity(0.4)),
      ],
    );
  }

  // _launchURL(String uri) async {
  //   final Uri url = Uri.parse(uri);
  //   if (!await launchUrl(url)) {
  //     throw Exception('Could not launch $url');
  //   }
  // }
}
