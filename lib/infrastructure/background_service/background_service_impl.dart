import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/app_settings.dart';
import 'package:youscribe/config/flavors.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/infrastructure/background_service.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/infrastructure/file_service.dart';
import 'package:youscribe/core/repositories/bookmark_repository.dart';
import 'package:youscribe/core/repositories/country_config_repository.dart';
import 'package:youscribe/core/repositories/products_repository.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe/core/use_cases/configurations/get_country_configuration_use_case.dart';
import 'package:youscribe/core/use_cases/configurations/get_user_settings_use_case.dart';
import 'package:youscribe/core/use_cases/configurations/send_init_data_usecase.dart';
import 'package:youscribe/core/use_cases/configurations/set_user_country_config_use_case.dart';
import 'package:youscribe/core/use_cases/my_selections/get_my_selection_use_case.dart';
import 'package:youscribe/core/use_cases/products/sync_book_mark_use_case.dart';
import 'package:youscribe/core/use_cases/products/sync_fav_products_usecase.dart';
import 'package:youscribe/core/use_cases/products/sync_last_read_products_usecase.dart';
import 'package:youscribe/core/use_cases/products/sync_offline_products_usecase.dart';
import 'package:youscribe/core/use_cases/user/is_user_subscribe_use_case.dart';
import 'package:youscribe/core/use_cases/user/save_user_selections_use_case.dart';
import 'package:youscribe/data/data_sources/product_data_sources/product_local_data_source.dart';
import 'package:youscribe/data/data_sources/product_data_sources/product_remote_data_source.dart';
import 'package:youscribe/data/data_sources/product_data_sources/reading_stat_local_data_source.dart';
import 'package:youscribe/data/data_sources/user_acount_data_sources/user_account_local_data_source.dart';

class BackgroundServiceImpl extends BackgroundService {
  BackgroundServiceImpl(this.locator);
  final GetIt locator;
  late final AppSettings appSettings = locator();
  late final GetMySelectionsUseCase getMySelectionsUseCase = locator();
  late final SaveUserSelectionsUseCase saveUserSelectionsUseCase = locator();
  late final IsUserSubscribeUseCase _isUserSubscribeUseCase = locator();
  late final UserAccountRepository userAccountRepository = locator();
  late final UserAccountLocalDataSource userAccountLocalDataSource = locator();
  late final FileService fileService = locator();
  late final ConnectivityService connectivityService = locator();
  late final ProductRepository productRepository = locator();
  late final UserAccountRepository _userAccountRepository = locator();
  late final ProductLocalDataSource productLocalDataSource = locator();
  late final SendInitDataUseCase _sendInitDataUseCase = locator();
  late final GetUserSettingsUseCase _getUserSettingsUseCase = locator();
  late final GetCountryConfigurationUseCase getCountryConfigurationUseCase =
      locator();
  late final SetUserCountryConfigUseCase setUserCountryConfigUseCase =
      locator();
  late final CountryConfigRepository countryConfigRepository =
      locator<CountryConfigRepository>();
  late final ProductRemoteDataSource productRemoteDataSource = locator();
  late final ReadingStatsLocalDataSource readingStatsLocalDataSource =
      locator();
  late final ProductRemoteDataSource productService = locator();
  late final BookmarkRepository bookmarkRepository = locator();
  late final SyncFavoriteProductsUsecase _syncFavoriteProductsUsecase =
      locator();
  late final SyncOfflineProductsUsecase _syncOfflineProductsUsecase = locator();
  late final SyncLastReadProductsUsecase _syncLastReadProductsUsecase =
      locator();
  late final SyncBookMarkUsecase _syncBookMarkUsecase = locator();

  @override
  Future<void> saveUserSelections() async {
    try {
      final result = await getMySelectionsUseCase(null);
      if (result.ok != null && result.ok!.isNotEmpty) {
        final saveResponse = await saveUserSelectionsUseCase(result.ok);
        if (saveResponse.isErr) {
          logError("An error occured while saving selections.",
              error: Exception(saveResponse.err));
          return;
        }
      }
    } catch (e) {
      logError("An error occured while retreiving selections.",
          error: Exception(e));
    }
  }

  @override
  Future<void> checkIfUserIsSubscribedOnServers() async {
    try {
      final isSub = await _isUserSubscribeUseCase(null);
      final userAccount = await AuthenticationManager.getCurrentUser();
      if (isSub.isErr) {
        logError("Error occured while checking if user is subscribed or not.",
            error: isSub.err);
        return;
      }
      if (isSub.ok != userAccount!.isSubscriber) {
        userAccount.isSubscriber = isSub.ok;
        await _userAccountRepository.saveUserAccount(userAccount);
      }
    } catch (e) {
      logError("Error occured while checking if user is subscribed or not.",
          error: Exception(e));
    }
  }

  @override
  Future<void> cleanBookDirectory(int userId) async {
    try {
      logInfo("Cleaning book directory.");

      final localProducts = await fileService.getEveryDownloadedBook(userId);

      await deleteEveryBookWithoutRights(localProducts, userId);
      await deleteExpiredBooks(localProducts, userId);

      logInfo("Book directory cleaning completed successfully.");
    } catch (e) {
      logError("Error while clearing book dir", error: Exception(e));
    }
  }

  @override
  Future<void> syncBookmarks() async {
    try {
      final result = await _syncBookMarkUsecase(null);

      if (result.isErr) {
        logError("An error occured while syncing bookmarks.",
            error: result.err);
        return;
      }
    } catch (e) {
      logError("An error occured while syncing bookmarks.",
          error: Exception(e));
    }
  }

  @override
  Future<void> syncConfigurations() async {
    try {
      if (!await connectivityService.isInternetAvailable) {
        return;
      }
      final countryConfig = await getCountryConfigurationUseCase(null);
      if (countryConfig.ok.isNotNull) {
        await setUserCountryConfigUseCase(countryConfig.ok);
      }
      //TODO: Canal+ is no longer used. Remove it everywhere when time comes.
      if (currentFlavor == Flavor.youscribedev) {
        final canalplusConfig =
            await countryConfigRepository.getCanalplusConfig();
        await _userAccountRepository.setCanalplusConfig(canalplusConfig!);
      }
    } catch (e) {
      logError("Error while loading configurations.", error: Exception(e));
    }
    try {
      final currentUser = await AuthenticationManager.getCurrentUser();
      final settings = await _getUserSettingsUseCase(null);
      _sendInitDataUseCase(SendInitDataUseCaseParameters(
          firebaseToken: currentUser!.firebaseToken ?? '',
          languageCode: settings.ok!.preferredLanguageCode,
          countryCode: settings.ok!.countryConfiguration!.countryCode!));
    } catch (e) {
      logError("Error while sending user settings to API.",
          error: Exception(e));
    }
  }

  Future<void> deleteEveryBookWithoutRights(
      List<LocalBook> localProducts, int userId) async {
    logInfo('Starting the deletion of books without rights.');

    if (!await connectivityService.isInternetAvailable) {
      return; // Exit if no internet connection
    }

    final productsToDelete = <int>[];

    for (final file in localProducts) {
      try {
        final hasRights =
            await productRepository.hasRightsForProduct(file.productId);

        if (!hasRights) {
          logInfo('Product ${file.productId} does not have rights.');
          productsToDelete.add(file.productId);
          if (file.extension == 'mp3') {
            productsToDelete.add(file.productId); // Add twice for MP3 deletion
          }
        }
      } catch (e) {
        logError('Error checking rights for product ${file.productId}',
            error: Exception(e));
      }
    }

    if (productsToDelete.isNotEmpty) {
      logInfo('Products to delete:\n$productsToDelete');
      await fileService.deleteProductFiles(userId, productsToDelete);
    }
  }

  Future<void> deleteExpiredBooks(
      List<LocalBook> localProducts, int userId) async {
    final hasOfflineProducts = await productRepository.hasOfflineProducts();
    final productsToDelete = <int>[];

    if (hasOfflineProducts && localProducts.isNotEmpty) {
      final offlineProducts =
          await productLocalDataSource.readOfflineProducts();
      final localProductsThatAreNotOffline = localProducts
          .where((lp) => !offlineProducts.any((of) => of.id == lp.productId));

      logInfo('Local Products: \n$localProducts');
      logInfo('Offline Products: \n${offlineProducts.map((p) => p.id)}');

      for (final localProduct in localProductsThatAreNotOffline) {
        final dateDif = DateTime.now().difference(localProduct.creationDate);
        if (dateDif >= Duration(days: appSettings.daysLeftBeforeBookExpiry)) {
          productsToDelete.add(localProduct.productId);
        }
      }

      if (productsToDelete.isNotEmpty) {
        logInfo('Products to delete: \n$productsToDelete');
        await fileService.deleteProductFiles(userId, productsToDelete);
      }
    }
  }

  @override
  Future<void> syncFavoriteProducts() async {
    try {
      final result = await _syncFavoriteProductsUsecase(null);

      if (result.isErr) {
        logError("An error occured while syncing favs.", error: result.err);
        return;
      }
    } catch (e) {
      logError("An error occured while syncing favs.", error: Exception(e));
    }
  }

  @override
  Future<void> syncLastReadProducts() async {
    try {
      final result = await _syncLastReadProductsUsecase(null);

      if (result.isErr) {
        logError("An error occured while syncing last read.",
            error: result.err);
        return;
      }
    } catch (e) {
      logError("An error occured while syncing last read.",
          error: Exception(e));
    }
  }

  @override
  Future<void> syncOfflineProducts() async {
    try {
      final result = await _syncOfflineProductsUsecase(null);

      if (result.isErr) {
        logError("An error occured while syncing offlines.", error: result.err);
        return;
      }
    } catch (e) {
      logError("An error occured while syncing offlines.", error: Exception(e));
    }
  }

  @override
  Future<void> syncReadingStats() async {
    try {
      if (!await connectivityService.isInternetAvailable) {
        return;
      }

      logInfo("Sending Reading stats to API.");
      final everyStat = await readingStatsLocalDataSource.retrieveEveryStat();
      if (everyStat.isNotEmpty) {
        for (final stat in everyStat) {
          if (stat.trackingId == const Uuid().v1()) {
            logInfo("Reading stats issues.");
            logError("The tracking id has a default value.",
                error: Exception("Tracking id was default."));
          }
          await productService.sendReadingStats(stat);
        }

        await readingStatsLocalDataSource.deleteEveryStat();
      }
    } catch (e) {
      logError("Error while syncing stats.", error: Exception(e));
    }
  }

  @override
  Future<void> launchBackgroundSyncs() async {
    final currentUser = await AuthenticationManager.getCurrentUser();
    await checkIfUserIsSubscribedOnServers();
    await saveUserSelections();
    await syncReadingStats();
    await syncBookmarks();
    await syncConfigurations();
    await cleanBookDirectory(currentUser?.id ?? 0);
  }

  @override
  Future<void> syncProductList() async {
    try {
      logInfo("Launching book list syncs");
      await syncLastReadProducts();
      await syncFavoriteProducts();
      await syncOfflineProducts();
    } catch (e) {
      logError("Fatal error while launching book list syncs. $e",
          error: Exception(e));
    }
  }
}
