// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youscribe/core/entities/collection_search_output_item_entity.dart';
import 'package:youscribe/core/entities/people_search_output_item_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/models/responses/multi_type_search_output_model.dart';
import 'package:youscribe/presentation/screens/search/widgets/search_result_group_view.dart';

class SearchView extends StatefulWidget {
  const SearchView(
      {required this.products,
      required this.authors,
      required this.onProductGroupSelected,
      required this.onCollectionsGroupSelected,
      required this.onAuthorsGroupSelected,
      required this.onProductSelected,
      required this.onAuthorSelected,
      required this.onCollectionSelected,
      super.key,
      this.collections});
  final List<ProductEntity> products;
  final List<CollectionSearchOutputItemEntity>? collections;
  final List<PeopleSearchOutputItemEntity> authors;
  final void Function() onProductGroupSelected;
  final void Function() onCollectionsGroupSelected;
  final void Function() onAuthorsGroupSelected;
  final void Function(int productId) onProductSelected;
  final void Function(int authorId, String title) onAuthorSelected;
  final void Function(int collectionId, String title) onCollectionSelected;
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              child: widget.products.isNotEmpty
                  ? SearchResultGroupView(
                      onProductSelected: widget.onProductSelected,
                      groupTitle: AppLocalizations.of(context)!.publications,
                      length: widget.products.length,
                      products: widget.products,
                      seeMoreAction: widget.onProductGroupSelected,
                      searchResultGroupType: SearchResultGroupType.products)
                  : null,
            ),
            SizedBox(
              child: widget.collections?.length != 0
                  ? SearchResultGroupView(
                      groupTitle: AppLocalizations.of(context)!.collections,
                      onCollectionSelected: widget.onCollectionSelected,
                      length: widget.collections?.length ?? 0,
                      seeMoreAction: widget.onCollectionsGroupSelected,
                      collections: widget.collections,
                      searchResultGroupType: SearchResultGroupType.collections)
                  : null,
            ),
            SizedBox(
              child: widget.authors.length != 0
                  ? SearchResultGroupView(
                      seeMoreAction: widget.onAuthorsGroupSelected,
                      groupTitle: AppLocalizations.of(context)!.authors,
                      length: widget.authors.length,
                      onAuthorSelected: widget.onAuthorSelected,
                      authors: widget.authors,
                      searchResultGroupType: SearchResultGroupType.authors)
                  : null,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
