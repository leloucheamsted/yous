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

class SyncLastReadProductsUsecase extends AsyncUseCase<void, bool>
    with Debuggable, Loggable {
  late final ProductRepository productRepository = locator();

  @override
  String get debugName => 'SyncLastReadProductsUsecase';

  @override
  FutureOrResult<bool> execute(void params) async {
    try {
      logInfo("Syncing last read products.");
      final currentUser = await AuthenticationManager.getCurrentUser();

      final onlineProducts = (await productRepository.getLastReadingProducts(
        currentUser!.id!,
        currentUser.trackingId,
      ))
          .toList();

      if (!(await productRepository.hasLastReadProducts())) {
        logInfo(
            // ignore: lines_longer_than_80_chars
            "User has no local last read products, so we update the local database's content");
        await productRepository.saveLastReadProducts(onlineProducts,
            setDate: false, synchronized: true);
        return const Ok(true);
      }

      if (onlineProducts.isNotNullOrEmpty) {
        final productsOnlineButNotInLocal = <ProductEntity>[];

        for (final product in onlineProducts) {
          logInfo("Last Read Product: ${product.id}");
          final lastRead =
              await productRepository.lastReadProductExists(product.id!);

          if (lastRead == null) {
            product.lastReadSynced = true;
            productsOnlineButNotInLocal.add(product);
          } else {
            if (product.dateLastRead != null &&
                lastRead.dateLastRead != null &&
                product.dateLastRead!.toLocal().totalSeconds >
                    lastRead.dateLastRead!.totalSeconds) {
              await productRepository
                  .updateLastReadProductDateOnSynchronization(
                      product.id!, product.dateLastRead!.toLocal());
            }
          }
        }

        await productRepository.saveLastReadProducts(
            productsOnlineButNotInLocal,
            setDate: false,
            synchronized: true);
      }

      final productsInLocalButNotOnline =
          await productRepository.readLastReadProductsNotSyncedAndNotInList(
              onlineProducts.map((p) => p.id!).toList());
      // final everyLastReadProduct =
      //     await productRepository.readLastReadProducts();

      // final Set<int> onlinePIds = onlineProducts.map((e) => e.id!).toSet();
      // final Set<int> offlinePIds =
      //     everyLastReadProduct.map((e) => e.id!).toSet();
      // final intersection = onlinePIds.intersection(offlinePIds);

      if (productsInLocalButNotOnline.isNotNullOrEmpty) {
        for (final prod in productsInLocalButNotOnline) {
          if (!(prod.lastReadSynced ?? false)) {
            try {
              await productRepository.addToLastRead(
                  prod, currentUser.id!, currentUser.trackingId);
              await productRepository.saveLastReadProduct(prod,
                  setDate: false, synchronized: true);
            } catch (e) {
              logError("Error adding product to online last read.",
                  error: Exception(e));
            }
          }
        }
      }

      final finalProducts = await productRepository.readLastReadProducts();

      if (finalProducts.isNotNullOrEmpty && finalProducts.length > pageSize) {
        for (final product in finalProducts
            //.sort((a, b) => (b.dateLastRead?.totalSeconds ?? 0)
            //> (a.dateLastRead?.totalSeconds ?? 0))
            .skip(pageSize)
            .toList()) {
          await productRepository.removeFromLastReadProducts(product.id!);
        }
      }
      return const Ok(true);
    } on APIRequestException catch (e) {
      logError('API Error syncing last reads: $e', error: e);
      return Err(e);
    } catch (e) {
      logError('API Error syncing last reads: $e', error: Exception(e));
      rethrow;
    }
  }
}
