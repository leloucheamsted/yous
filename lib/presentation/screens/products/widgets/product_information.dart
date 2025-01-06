import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/utilities/constants.dart';

class ProductInformation extends StatelessWidget {
  const ProductInformation(
      {required this.title,
      required this.author,
      required this.language,
      required this.isAudio,
      required this.size,
      required this.isPremium,
      required this.duration,
      required this.ownerDisplayableUserName,
      required this.authorId,
      required this.ownerId,
      super.key,
      this.totalPages});
  final String title;
  final String author;
  final int authorId;
  final int ownerId;
  final String language;
  final bool isAudio;
  final bool isPremium;
  final int? totalPages;
  final String duration;
  final String ownerDisplayableUserName;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w600, overflow: TextOverflow.clip),
        ),
        const SizedBox(height: 5),
        SizedBox(child: isPremium ? _premiumWidget(context) : null),
        GestureDetector(
          onTap: () async {
            if (context.mounted) {
              await context.pushNamed(Routes.authorPage, queryParameters: {
                Routes.authorIdParamName: authorId.toString(),
                Routes.authorTitleParamName: author
              });
            }
          },
          child: RichText(
            text: TextSpan(
              text: '${AppLocalizations.of(context)!.author} ',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.w600),
              children: [
                TextSpan(
                  text: author,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: YouScribeColors.secondaryTextColor,
                      decoration: TextDecoration.underline),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          child: ownerDisplayableUserName.isNotEmpty
              ? GestureDetector(
                  onTap: () async {
                    if (context.mounted) {
                      await context.pushNamed(Routes.publisherProducts,
                          queryParameters: {
                            Routes.publisherIdParamName: ownerId.toString(),
                            Routes.publisherTitleParamName:
                                ownerDisplayableUserName
                          });
                    }
                  },
                  child: RichText(
                    text: TextSpan(
                      text: '${AppLocalizations.of(context)!.publishedBy} ',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w600),
                      children: <TextSpan>[
                        TextSpan(
                          text: ownerDisplayableUserName,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: YouScribeColors.secondaryTextColor,
                                  decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                )
              : null,
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const FontAwesomeTextIcon(
              font: FontIcons.fontAwesomeClock,
              color: YouScribeColors.accentColor,
              fontSize: 20,
            ),
            Text(
              ' $duration ${AppLocalizations.of(context)!.minutes}',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: YouScribeColors.secondaryTextColor),
            ),
          ],
        ),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            text: '${AppLocalizations.of(context)!.language} ',
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w600),
            children: <TextSpan>[
              TextSpan(
                text: generateLanguage(context, language),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: YouScribeColors.secondaryTextColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          child: !isAudio
              ? RichText(
                  text: TextSpan(
                    text: '${AppLocalizations.of(context)!.numberOfPages} ',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.w600),
                    children: <TextSpan>[
                      TextSpan(
                        text: totalPages.toString(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: YouScribeColors.secondaryTextColor),
                      ),
                    ],
                  ),
                )
              : null,
        ),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            text: '${AppLocalizations.of(context)!.size} ',
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w600),
            children: <TextSpan>[
              TextSpan(
                text: '$size MB',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: YouScribeColors.secondaryTextColor),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _premiumWidget(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 110,
              height: 40,
              child: ElevatedButton(
                  onPressed: () async {
                    await Dialogs.displayPremiunInfoAlert(context: context);
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        YouScribeColors.primaryAppColor,
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        YouScribeColors.whiteColor,
                      )),
                  child: Text(
                    AppLocalizations.of(context)!.premiumBook,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontSize: WidgetStyles.caption1Size,
                        color: YouScribeColors.whiteColor,
                        fontWeight: FontWeight.w500),
                  )),
            ),
            const SizedBox(width: 5),
            Image.asset(ImagesName.premiumBadgeImg, height: 40, width: 40)
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  String generateLanguage(BuildContext context, String languageCode) {
    switch (languageCode) {
      case "FRA":
        return AppLocalizations.of(context)!.frenchLanguage;
      case "ENG":
        return AppLocalizations.of(context)!.englishLanguage;
      default:
        return AppLocalizations.of(context)!.arabeLanguage;
    }
  }
}
