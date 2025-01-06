import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/collection_search_output_item_entity.dart';
import 'package:youscribe/core/entities/people_search_output_item_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/models/responses/multi_type_search_output_model.dart';
import 'package:youscribe/presentation/screens/search/widgets/search_result_group_itemView.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class SearchResultGroupView extends StatelessWidget {
  const SearchResultGroupView({
    required this.searchResultGroupType,
    required this.groupTitle,
    required this.seeMoreAction,
    required this.length,
    this.onProductSelected,
    this.onAuthorSelected,
    this.onCollectionSelected,
    super.key,
    this.products,
    this.collections,
    this.authors,
  });

  final SearchResultGroupType searchResultGroupType;
  final String groupTitle;
  final void Function() seeMoreAction;
  final List<ProductEntity>? products;
  final List<CollectionSearchOutputItemEntity>? collections;
  final List<PeopleSearchOutputItemEntity>? authors;

  final void Function(int productId)? onProductSelected;
  final void Function(int authorId, String title)? onAuthorSelected;
  final void Function(int collectionId, String title)? onCollectionSelected;

  final int length;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          ColoredBox(
            color: YouScribeColors.secondaryTextColor.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      FontAwesomeTextIcon(
                          font: getFontAwesomeIconForCategory(),
                          fontSize: 18,
                          color: YouScribeColors.primaryAppColor),
                      const SizedBox(width: 8),
                      Text(
                        "$groupTitle ($length)",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: YouScribeColors.primaryAppColor,
                            fontWeight: FontWeight.w800),
                      )
                    ],
                  )),
                  ElevatedButton(
                      onPressed: seeMoreAction,
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        '${AppLocalizations.of(context)!.seeMore} +',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: YouScribeColors.whiteColor,
                            fontWeight: FontWeight.w800),
                      ))
                ],
              ),
            ),
          ),
          ...List.generate(length, (index) {
            return SizedBox(
              child: searchResultGroupType == SearchResultGroupType.products
                  ? SearchResultGroupItemView(
                      product: products![index],
                      searchResultGroupType: searchResultGroupType,
                      searchResultItemSelected: onProductSelected!,
                    )
                  : searchResultGroupType == SearchResultGroupType.collections
                      ? SearchResultGroupItemView(
                          collection: collections.isNullOrEmpty
                              ? null
                              : collections![index],
                          searchResultGroupType: searchResultGroupType,
                          searchResultItemSelected: (id) {
                            if (onCollectionSelected != null &&
                                collections.isNotNullOrEmpty) {
                              onCollectionSelected!(
                                  id, collections![index].title ?? '');
                            }
                          },
                        )
                      : SearchResultGroupItemView(
                          author: authors![index],
                          searchResultGroupType: searchResultGroupType,
                          searchResultItemSelected: (id) {
                            if (onAuthorSelected != null &&
                                authors.isNotNullOrEmpty) {
                              onAuthorSelected!(id, authors![index].name ?? '');
                            }
                          },
                        ),
            );
          })
        ],
      ),
    );
  }

  String getFontAwesomeIconForCategory() {
    switch (searchResultGroupType) {
      case SearchResultGroupType.products:
        return FontIcons.fontAwersoneText;
      case SearchResultGroupType.collections:
        return FontIcons.fontAwesomeBooks;
      case SearchResultGroupType.authors:
        return FontIcons.fontAwersoneBookUser;
    }
  }
}
