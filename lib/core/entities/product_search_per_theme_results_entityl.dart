import 'package:youscribe/core/entities/product_search_results_entity.dart';
import 'package:youscribe/core/models/responses/products_per_theme_search_output_model.dart';

class ProductSearchPerThemeResultsEntity extends ProductSearchResultsEntity {
  ProductSearchPerThemeResultsEntity(
    ProductsPerThemeSearchOutputModel super.productSearchOutputModel, {
    this.themeId,
    this.classificationId,
  }) : super.fromModel();

  int? themeId;
  int? classificationId;
}
