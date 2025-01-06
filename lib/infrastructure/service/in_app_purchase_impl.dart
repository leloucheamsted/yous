import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/app_settings.dart';
import 'package:youscribe/core/infrastructure/in_app_purchase_service.dart';
import 'package:youscribe/core/models/requests/save_in_app_subscription.dart';
import 'package:youscribe/core/models/responses/google_play_model.dart';
import 'package:youscribe/data/data_sources/in_app_subscription_request_data_sources/in_app_subscription_request_data_source.dart';
import 'package:youscribe/infrastructure/service/billing_service.dart';

class InAppPurchaseServiceImpl extends InAppPurchaseService {
  InAppPurchaseServiceImpl();
  late final AppSettings appSettings = locator();
  final BillingService billingService = locator();
  final InAppSubscriptionRequestDataSource _appSubscriptionRequestDataSource =
      locator();
  final iapConnection = InAppPurchase.instance;

  @override
  Future<String> getProductPrice() async {
    try {
      final available = await iapConnection.isAvailable();
      if (!available) {
        return appSettings.inAppPurchaseDefaultPrice;
      }
      final List<ProductDetails> products = await billingService
          .getProducts([appSettings.inAppPurchaseSubscriptionId]);
      if (products.isNullOrEmpty) {
        return appSettings.inAppPurchaseDefaultPrice;
      }
      final inAppPurchaseItem = products
          .lastWhere((e) => e.id == appSettings.inAppPurchaseSubscriptionId);
      return inAppPurchaseItem.price;
    } catch (e) {
      return appSettings.inAppPurchaseDefaultPrice;
    }
  }

  @override
  Future<void> purchaseSubscription(List<PurchaseDetails> purchases) async {
    try {
      logInfo("Android purchase was updated.");
      if (purchases.any((element) => element.isNull)) {
        for (final purchase in purchases) {
          await _purchaseSubscription(purchase, true);
        }
      }
      logInfo("Disconnecting the billing library.");
    } catch (e) {
      logError("Error while validating a pending purchase.",
          error: Exception(e));
    }
  }

  @override
  Future<bool> subscribe() async {
    final available = await iapConnection.isAvailable();
    if (!available) {
      return false;
    }
    try {
      final List<ProductDetails> products = await billingService
          .getProducts([appSettings.inAppPurchaseSubscriptionId]);

      final product = products
          .firstWhere((e) => e.id == appSettings.inAppPurchaseSubscriptionId);
      final response = await billingService.makePurchase(product);
      return response;
    } catch (e) {
      logError("Fatal error occured while subscribing users.",
          error: Exception(e));
      return false;
    }
  }

  Future<bool> _purchaseSubscription(
      PurchaseDetails purchase, bool sendMessage) async {
    final saveModel = SaveInAppSubscription(
      platform: "Android",
      productId: appSettings.inAppPurchaseSubscriptionId,
      purchaseId: purchase.purchaseID,
      purchaseToken: purchase.verificationData.serverVerificationData,
    );
    final result = await _appSubscriptionRequestDataSource
        .createSubscriptionGooglePlayAsync(saveModel);
    if (result!.isValid! &&
        result.status == GooglePlayPayStatus.ok &&
        sendMessage) {}

    logInfo(
      "Finalizing purchase with transaction Id: ${purchase.purchaseID}",
    );
    await _acknowledgePurchase(purchase);
    return result.isValid! && result.status == GooglePlayPayStatus.ok;
  }

  Future<void> _acknowledgePurchase(PurchaseDetails purchase) async {
    if (purchase.status == PurchaseStatus.purchased) {
      try {
        return iapConnection.completePurchase(purchase);
      } catch (e) {
        logError("Little error occured while acknowledging an inapp purchase.",
            error: Exception(e));
      }
    }
  }

  @override
  Future<bool> wasSubscriptionPurchased() async {
    try {
      final available = await iapConnection.isAvailable();
      if (!available) {
        return false;
      }
      final List<ProductDetails> products = await billingService
          .getProducts([appSettings.inAppPurchaseSubscriptionId]);
      if (products.isNullOrEmpty) {
        return false;
      }
      final inAppPurchaseItem = products
          .firstWhere((e) => e.id == appSettings.inAppPurchaseSubscriptionId);
      if (Platform.isAndroid) {
        final response =
            await billingService.purchasePending(inAppPurchaseItem);
        return response;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
