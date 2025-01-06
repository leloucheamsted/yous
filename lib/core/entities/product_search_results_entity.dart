import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/language_entity.dart';
import 'package:youscribe/core/entities/product_category_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/entities/product_facet_entity.dart';
import 'package:youscribe/core/models/base/base_model.dart';
import 'package:youscribe/core/models/constants.dart';
import 'package:youscribe/core/models/responses/product_search_output_model.dart';

class ProductSearchResultsEntity extends BaseModel {
  ProductSearchResultsEntity({
    this.products,
    this.themes,
    this.categories,
    this.languages,
    this.classifications,
    this.totalResults,
  });
  ProductSearchResultsEntity.fromModel(
    ProductSearchOutputModel productSearchOutputModel, {
    bool isHomeSuggestion = false,
  }) {
    themes = [];
    classifications = [];
    categories = [];
    products = [];
    languages = [];
    totalResults = productSearchOutputModel.totalResults;

    if (productSearchOutputModel.themes != null) {
      for (final theme in productSearchOutputModel.themes!) {
        if (ModelConstants.excludedThemeIds.contains(theme.id)) {
          continue;
        }

        final newTheme = ProductFacetEntity(
          label: theme.label,
          id: theme.id,
          name: theme.name,
        )..children = [];

        if (theme.children.isNotNullOrEmpty) {
          for (final child in theme.children!) {
            if (ModelConstants.excludedThemeIds.contains(child.id)) {
              continue;
            }

            newTheme.children.add(
              ProductFacetEntity(
                label: child.label,
                id: child.id,
                parent: newTheme,
              ),
            );
          }
        } else {
          if (theme.children2 != null) {
            for (final child in theme.children2!) {
              if (ModelConstants.excludedThemeIds.contains(child.id)) {
                continue;
              }

              newTheme.children.add(
                ProductFacetEntity(
                  label: child.label,
                  id: child.id,
                  parent: newTheme,
                ),
              );
            }
          }
        }
        themes!.add(newTheme);
      }
    }

    if (productSearchOutputModel.classifications != null) {
      for (final classification in productSearchOutputModel.classifications!) {
        final newClassification = ProductFacetEntity(
          label: classification.label,
          id: classification.id,
        )..children = [];

        if (classification.children != null) {
          for (final child in classification.children!) {
            newClassification.children.add(
              ProductFacetEntity(
                label: child.label,
                id: child.id,
                parent: newClassification,
              ),
            );
          }
        }

        classifications!.add(newClassification);
      }
    }

    if (productSearchOutputModel.categories != null) {
      for (final category in productSearchOutputModel.categories!) {
        categories!.add(
          ProductCategoryEntity(
            label: category.label,
            id: category.id,
          ),
        );
      }
    }

    if (productSearchOutputModel.products != null) {
      for (final product in productSearchOutputModel.products!) {
        final productPres = ProductEntity(id: 0)
          ..fromProductSearchItemOutputModel(product, isHomeSuggestion);
        products!.add(productPres);
      }
    }

    if (productSearchOutputModel.languages != null) {
      for (final item in productSearchOutputModel.languages!) {
        languages!.add(
          LanguageEntity(id: item.id, name: item.name, label: item.label),
        );
      }
    }
  }
  static const String productFreeOfferType = "Free";
  static const String productSubscriptionOfferType = "Subscription";
  static const String mostReadSortOption = "nb_reads_for_thirty_days";
  static const String scoreSortOption = "score";
  static const String mostRecentSortOption = "online_date";

  static const String themeFacet = "theme";
  static const String languageFacet = "language";
  static const String classificationFacet = "classification";
  static const String categoryFacet = "categorie";
  static const List<int> excludedThemeIds = [111, 50, 146];
  List<ProductEntity>? products;
  List<ProductFacetEntity>? themes;
  List<ProductCategoryEntity>? categories;
  List<LanguageEntity>? languages;
  List<ProductFacetEntity>? classifications;
  int? totalResults;
}
