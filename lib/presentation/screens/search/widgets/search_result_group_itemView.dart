// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:youscribe/core/entities/collection_search_output_item_entity.dart';
import 'package:youscribe/core/entities/people_search_output_item_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/models/responses/multi_type_search_output_model.dart';
import 'package:youscribe/presentation/screens/search/widgets/search_item_tag.dart';
import 'package:youscribe/presentation/widgets/item_image_view.dart';

class SearchResultGroupItemView extends StatelessWidget {
  const SearchResultGroupItemView(
      {required this.searchResultItemSelected,
      required this.searchResultGroupType,
      super.key,
      this.product,
      this.collection,
      this.author});
  final void Function(int id) searchResultItemSelected;
  final SearchResultGroupType searchResultGroupType;

  final ProductEntity? product;
  final CollectionSearchOutputItemEntity? collection;
  final PeopleSearchOutputItemEntity? author;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        int id = 0;
        if (product != null) {
          id = product!.id!;
        } else if (collection != null) {
          id = collection!.id!;
        } else if (author != null) {
          id = author!.id!;
        }
        searchResultItemSelected(id);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Row(
          children: [
            SizedBox(
              child: ItemImageView(
                  placeholderSize: 20,
                  productImageUrl: genereateImageUrl(searchResultGroupType),
                  height: 50,
                  borderRadius: BorderRadius.circular(5),
                  width: 50),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Text(
                    generateTitle(searchResultGroupType)!,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  child: searchResultGroupType == SearchResultGroupType.products
                      ? SearchItemTag(
                          productType:
                              generateProductType(product!.category!.name!)!,
                          title: product!.category!.label!,
                        )
                      : null,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  ProductType? generateProductType(String name) {
    switch (name) {
      case RootName.audiobooks:
        return ProductType.audioBook;
      case RootName.books:
        return ProductType.book;
      case RootName.bd:
        return ProductType.partition;
      case RootName.press:
        return ProductType.news;
    }
    return null;
  }

  String genereateImageUrl(SearchResultGroupType typeSearch) {
    switch (typeSearch) {
      case SearchResultGroupType.products:
        return product?.imageUrl ?? '';
      case SearchResultGroupType.collections:
        return collection?.thumbnailUrlM ?? '';
      case SearchResultGroupType.authors:
        return author?.image ?? '';
    }
  }

  String? generateTitle(SearchResultGroupType typeSearch) {
    switch (typeSearch) {
      case SearchResultGroupType.products:
        return product!.title;
      case SearchResultGroupType.collections:
        return collection!.title;
      case SearchResultGroupType.authors:
        return author!.name;
    }
  }
}

class RootName {
  static const String audiobooks = "audiobooks_root";
  static const String books = "book_root";
  static const String bd = "bd_root";
  static const String press = "press_root";
}
