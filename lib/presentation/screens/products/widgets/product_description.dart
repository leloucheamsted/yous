import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:readmore/readmore.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription(
      {required this.plainDescription,
      required this.subjects,
      required this.showHeader,
      super.key,
      this.comments,
      this.opinion});
  final String plainDescription;
  final String? comments;
  final List<String> subjects;
  final String? opinion;
  final void Function(bool) showHeader;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          ReadMoreText(
            callback: showHeader,
            plainDescription,
            trimLines: 3,
            preDataTextStyle: const TextStyle(fontWeight: FontWeight.w500),
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),
            colorClickableText: YouScribeColors.secondaryTextColor,
            trimMode: TrimMode.Line,
            trimCollapsedText: AppLocalizations.of(context)!.readMore,
            trimExpandedText: AppLocalizations.of(context)!.readLess,
          ),
          const SizedBox(height: 10),
          SizedBox(
            child: comments.isNotNull
                ? IntrinsicHeight(
                    child: Row(
                      children: [
                        const FontAwesomeTextIcon(
                            font: FontIcons.fontAwesomeQuoteLeft,
                            fontSize: 36,
                            color: YouScribeColors.accentColor),
                        const SizedBox(width: 5),
                        const VerticalDivider(
                          thickness: 2,
                          color: YouScribeColors.accentColor,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Text(
                                opinion!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        fontSize: 20,
                                        overflow: TextOverflow.clip,
                                        fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                comments!,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                        color: YouScribeColors.commentsJetGray,
                                        fontSize: 12,
                                        overflow: TextOverflow.clip),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 20),
          SizedBox(
            child: subjects.isNotEmpty
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.subjects} ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: [
                            ...List.generate(subjects.length, (index) {
                              return _tags(subjects[index]);
                            })
                          ],
                        ),
                      )
              
                    ],
                  )
                : null,
          )
        ],
      ),
    );
  }

  Widget _tags(String content) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
          border: Border.all(color: YouScribeColors.accentColor, width: 1.3),
          borderRadius: BorderRadius.circular(15)),
      child: Text(content,
          style: WidgetStyles.caption1TextStyle.copyWith(
              color: YouScribeColors.accentColor,
              fontWeight: FontWeight.w500,
              fontSize: 14)),
    );
  }
}
