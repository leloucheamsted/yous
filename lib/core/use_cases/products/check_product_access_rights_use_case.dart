import 'dart:async';

import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/infrastructure/file_service.dart';
import 'package:youscribe/core/repositories/document_repository.dart';
import 'package:youscribe/core/repositories/products_repository.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

/// Checks if the user has access rights to a product
/// either to read it, or to download it.
class CheckProductAccessRightsUseCase extends AsyncUseCase<
    CheckProductAccessRightsUseCaseParameters,
    ProductAccessState> with Debuggable, Loggable {
  CheckProductAccessRightsUseCase(this._productRepository,
      this._documentRepository, this._fileService, this._userAccountRepository);

  final ProductRepository _productRepository;
  final DocumentRepository _documentRepository;
  final FileService _fileService;
  final UserAccountRepository _userAccountRepository;
  final ConnectivityService _connectivityService = locator();

  @override
  String get debugName => 'CheckProductAccessRightsUseCase';

  @override
  FutureOr<void> onStart(CheckProductAccessRightsUseCaseParameters? params) {
    if (params == null) {
      throw ArgumentError.notNull('parameters');
    }
  }

  @override
  FutureOrResult<ProductAccessState> execute(
      CheckProductAccessRightsUseCaseParameters? params) async {
    try {
      logInfo('Checking product access rights for ${params!.product.id}');
      final productExtension = params.product.getProductExtension();
      final currentUser = await AuthenticationManager.getCurrentUser();

      if (params.product.isPublished == false) {
        return const Ok(ProductAccessState.notPublished);
      }

      final downloadProgress = await _documentRepository
          .readProductDownloadProgressForProduct(params.product.id!);
      if (downloadProgress != null) {
        return const Ok(ProductAccessState.isDownloading);
      }

      if (await _fileService.productFileExists(
          currentUser!.id!, params.product.id!, productExtension)) {
        if (!params.shouldRead) {
          return const Ok(ProductAccessState.fileAvailable);
        }
        if (!await _connectivityService.isInternetAvailable &&
            await _is30DaysLimitReached()) {
          return const Ok(ProductAccessState.reached30DaysLimit);
        }

        return const Ok(ProductAccessState.canRead);
      }

      if (params.shouldRead) {
        if (!await _connectivityService.isInternetAvailable) {
          return const Ok(ProductAccessState.internetNeeded);
        } else if (productExtension == ProductEntity.mp3Extension) {
          return const Ok(ProductAccessState.canStream);
        } else {
          final hasRights =
              await _productRepository.hasRightsForProduct(params.product.id!);
          if (!hasRights) {
            if (params.product.isPremium ?? false) {
              return const Ok(ProductAccessState.lackRightsForPremium);
            }

            return const Ok(ProductAccessState.lackRights);
          }

          return const Ok(ProductAccessState.fileNotAvailable);
        }
      } else {
        if (!await _connectivityService.isInternetAvailable) {
          return const Ok(ProductAccessState.internetNeeded);
        } else if (!await _productRepository
            .hasRightsForProduct(params.product.id!)) {
          if (params.product.isPremium ?? false) {
            return const Ok(ProductAccessState.lackRightsForPremium);
          }

          if (currentUser.isSubscriber ?? false) {
            logWarning(
                // ignore: lines_longer_than_80_chars
                'User ${currentUser.id} is subscriber, but lacks rights for product ${params.product.id}');
            return const Ok(ProductAccessState.lackRightsButIsSubscriber);
          }

          return const Ok(ProductAccessState.lackRights);
        }

        return const Ok(ProductAccessState.canDownload);
      }
    } on Exception catch (e, s) {
      logError(
        // ignore: lines_longer_than_80_chars
        "Error while adding product ${params!.product.id} to offlines",
        error: e,
        stackTrace: s,
      );
      if (e is AppException) {
        return Err(e);
      }

      rethrow;
    } catch (ex) {
      logError(
        // ignore: lines_longer_than_80_chars
        "Error while adding product ${params!.product.id} to offlines, Error: $ex",
        error: Exception(ex),
      );
      if (ex is AppException) {
        return Err(ex);
      }

      rethrow;
    }
  }

  Future<bool> _is30DaysLimitReached() async {
    final userSettings = await _userAccountRepository.getUserSettings();

    if (userSettings.lastTimeConnectedToInternet == null) {
      return false;
    }
    final DateTime now = DateTime.now().toUtc();
    final DateTime lastTimeConnectedToInternet =
        userSettings.lastTimeConnectedToInternet!.toUtc();

    if (now.difference(lastTimeConnectedToInternet).inDays >= 30) {
      return true;
    } else {
      return false;
    }
  }
}

class CheckProductAccessRightsUseCaseParameters {
  CheckProductAccessRightsUseCaseParameters({
    required this.product,
    required this.shouldRead,
  });
  final ProductEntity product;
  final bool shouldRead;
}

enum ProductAccessState {
  canDownload,
  fileAvailable,
  canRead,
  //If we should stream the book.
  canStream,
  internetNeeded,
  notPublished,
  reached30DaysLimit,
  lackRights,
  //If the user lacks rights, but can purchase this premium product
  lackRightsForPremium,
  lackRightsButIsSubscriber,
  //If the user wants to read, but the file is not available in local storage.
  fileNotAvailable,
  isDownloading,
  zipDownloaded
}
