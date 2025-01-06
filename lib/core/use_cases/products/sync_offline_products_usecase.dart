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

class SyncOfflineProductsUsecase extends AsyncUseCase<void, bool>
    with Debuggable, Loggable {
  late final ProductRepository productRepository = locator();

  @override
  String get debugName => 'SyncOfflineProductsUsecase';

  @override
  FutureOrResult<bool> execute(void params) async {
    try {
      logInfo("Loading Offline products from API");
      final currentUser = await AuthenticationManager.getCurrentUser();

      final onlineProducts = await productRepository.getOfflineProducts(
          currentUser!.id!, pageSize);

      // Check for existing offline productsSyncBookmarks
      if (await productRepository.hasOfflineProducts()) {
        logInfo("User has no local offline products, saving API results");
        await productRepository.saveOfflineProducts(onlineProducts,
            setDate: false, synchronized: true);
        return const Ok(true);
      }

      // Handle products online but not locally
      if (onlineProducts.isNotNullOrEmpty) {
        final productsOnlineButNotInLocal = <ProductEntity>[];
        for (final product in onlineProducts) {
          final rem =
              await productRepository.isProductRemovedFromOfflines(product.id!);
          if (rem != null) {
            // Handle removed products
            if (rem.dateRemovedFromOfflines!.totalSeconds >
                product.dateAddedToOfflines!.toLocal().totalSeconds) {
              await productRepository.removeFromOfflines(rem.id!);
              await productRepository
                  .removeFromOfflineProductsOnSynchronization(rem);
            } else {
              await productRepository.saveOfflineProduct(product, false,
                  setDate: false, synchronized: true);
            }
            continue;
          }

          final offlineProduct =
              await productRepository.offlineProductExists(product.id!);
          if (offlineProduct == null) {
            productsOnlineButNotInLocal.add(product);
          } else if (offlineProduct.dateAddedToOfflines!.totalSeconds <
                  product.dateAddedToOfflines!.toLocal().totalSeconds ||
              !offlineProduct.offlineSynced! ||
              offlineProduct.offlineAddedLocally!) {
            offlineProduct
              ..dateAddedToOfflines = product.dateAddedToOfflines
              ..offlineSynced = true
              ..offlineAddedLocally = false;
            await productRepository.updateProduct(offlineProduct);
          }
        }

        await productRepository.saveOfflineProducts(productsOnlineButNotInLocal,
            setDate: false, synchronized: true);
      }

      // Handle products locally but not online
      final productsInLocalButNotOnline =
          await productRepository.readOfflineProductsNotInList(
              onlineProducts.map((e) => e.id!).toList());
      if (productsInLocalButNotOnline.isNotEmpty) {
        for (final prod in productsInLocalButNotOnline) {
          if (prod.offlineSynced!) {
            await productRepository
                .removeFromOfflineProductsOnSynchronization(prod);
          } else if (prod.offlineAddedLocally!) {
            try {
              await productRepository.addToOfflines(prod.id!);
              await productRepository.saveOfflineProduct(prod, false,
                  synchronized: true);
            } catch (e) {
              logError("Error adding product to online favs.",
                  error: Exception(e));
            }
          }
        }
      }

      return const Ok(true);
    } on APIRequestException catch (e) {
      logError('API Error syncing offlines: $e', error: e);
      return Err(e);
    } catch (e) {
      logError('API Error syncing offlines: $e', error: Exception(e));
      rethrow;
    }
  }
}
