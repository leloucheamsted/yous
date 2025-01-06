import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/repositories/products_repository.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe/utilities/view_utilities.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class SyncFavoriteProductsUsecase extends AsyncUseCase<void, bool>
    with Debuggable, Loggable {
  late final ProductRepository productRepository = locator();

  @override
  String get debugName => 'SyncFavoriteProductsUsecase';

  @override
  FutureOrResult<bool> execute(void params) async {
    try {
      logInfo('Loading Favorite products from API');
      final currentUser = await AuthenticationManager.getCurrentUser();

      final onlineProducts = await productRepository.getFavoriteProducts(
          currentUser!.id!, pageSize);

      // Check for local favorites first
      if (!(await productRepository.hasFavoriteProducts())) {
        // Cache online products if no locals exist
        logInfo('User has no local favorite products, caching online products');

        await productRepository.saveFavoriteProducts(onlineProducts,
            setDate: false, synchronized: true);

        return const Ok(true);
      }

      // Handle online products
      if (onlineProducts.isNotEmpty) {
        logInfo('${onlineProducts.length} products loaded from API');
        final productsOnlineButNotInLocal = <ProductEntity>[];

        for (final product in onlineProducts) {
          final rem = await productRepository
              .isProductRemovedFromFavorites(product.id!);

          if (rem != null) {
            // Handle removed product
            logInfo('Product ${rem.id} was removed');
            if (rem.dateRemovedFromFavorites!.totalSeconds >
                product.dateAddedToFavorites!.toLocal().totalSeconds) {
              await productRepository.removeFromFavorites(rem.id!);
              await productRepository
                  .removeFromFavoriteProductsOnSynchronization(rem.id!);
            } else {
              await productRepository.saveFavoriteProduct(product, false,
                  setDate: false, synchronized: true);
            }
            continue;
          }

          final favProduct =
              await productRepository.favoriteProductExists(product.id!);
          if (favProduct == null) {
            productsOnlineButNotInLocal.add(product);
          } else if (favProduct.dateAddedToFavorites!.toLocal().totalSeconds <
                  product.dateAddedToFavorites!.toLocal().second ||
              !favProduct.favoriteSynced! ||
              favProduct.favoriteAddedLocally!) {
            favProduct
              ..dateAddedToFavorites = product.dateAddedToFavorites!.toLocal()
              ..favoriteSynced = true
              ..favoriteAddedLocally = false;
            await productRepository.updateProduct(favProduct);
          }
        }

        // Save products online but not in local
        logInfo(
            // ignore: lines_longer_than_80_chars
            'Products online but not in local favorites: ${productsOnlineButNotInLocal.length}');
        //ERR
        await productRepository.saveFavoriteProducts(
            productsOnlineButNotInLocal,
            setDate: false,
            synchronized: true);
      }

      // Handle local products not online
      final productsInLocalButNotOnline =
          await productRepository.readFavoriteProductsNotInList(
              onlineProducts.map((p) => p.id!).toList());
      if (productsInLocalButNotOnline.isNotEmpty) {
        logInfo(
            // ignore: lines_longer_than_80_chars
            'Products in local db but not online: ${productsInLocalButNotOnline.length}');
        for (final prod in productsInLocalButNotOnline) {
          if (!prod.favoriteSynced!) {
            await productRepository
                .removeFromFavoriteProductsOnSynchronization(prod.id!);
          } else if (prod.favoriteAddedLocally!) {
            try {
              await productRepository.addToFavorites(prod.id!);
              await productRepository.saveFavoriteProduct(prod, false,
                  synchronized: true);
            } catch (e) {
              logError('Error adding product to online favs.',
                  error: Exception(e));
            }
          }
        }
      }

      return const Ok(true);
    } on APIRequestException catch (e) {
      logError('API Error syncing favs: $e', error: e);
      return Err(e);
    } catch (e) {
      logError('Error syncing favs: $e', error: Exception(e));
      rethrow;
    }
  }
}
