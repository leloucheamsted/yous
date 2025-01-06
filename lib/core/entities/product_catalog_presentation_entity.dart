import 'package:youscribe/core/entities/product_search_results_entity.dart';
import 'package:youscribe/core/models/responses/catalog_page_model.dart';
import 'package:youscribe/core/models/utilities.dart';

class ProductCatalogPresentationEntity extends ProductSearchResultsEntity {
  ProductCatalogPresentationEntity({
    this.htmlDescription,
    this.title,
  });

  ProductCatalogPresentationEntity.fromCatalogPageModel(
      CatalogPageModel catalog)
      : super.fromModel(catalog) {
    htmlDescription = catalog.description ?? '';
    title = catalog.title;
  }

  String? htmlDescription;
  String get description => parseHtmlToPlainString(htmlDescription ?? '');
  String? title;
}
