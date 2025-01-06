import 'dart:async';
import 'dart:io';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/app_settings.dart';
import 'package:youscribe/config/iap_connection.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/models/requests/save_in_app_subscription.dart';
import 'package:youscribe/core/models/responses/google_play_model.dart';
import 'package:youscribe/data/data_sources/in_app_subscription_request_data_sources/in_app_subscription_request_data_source.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class BillingService with Debuggable, Loggable {
  final iapConnection = IAPConnection.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  late final AppSettings appSettings = locator();

  final InAppSubscriptionRequestDataSource _appSubscriptionRequestDataSource =
      locator();

  @override
  String get debugName => "BillingService";

  Future<void> _acknowledgePurchase(GooglePlayPurchaseDetails purchase) async {
    if (purchase.billingClientPurchase.purchaseState ==
        PurchaseStateWrapper.purchased) {
      try {
        await iapConnection.completePurchase(purchase);
      } catch (e) {
        logError("Little error occured while acknowledging an inapp purchase.",
            error: Exception(e));
      }
    }
  }

  Future<bool> _purchaseGoogleSubscription(
      GooglePlayPurchaseDetails purchase, bool sendMessage) async {
    final saveModel = SaveInAppSubscription(
      platform: "Android",
      productId: purchase.productID,
      purchaseId: purchase.purchaseID,
      purchaseToken: purchase.billingClientPurchase.purchaseToken,
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

  Future<bool> _purchaseAppleSubscription(
      String itunesId, String receipt) async {
    final response = await _appSubscriptionRequestDataSource
        .createSubscriptionWithReceiptAsync(itunesId, receipt);
    return response?.isValid ?? false;
  }

  Future<List<ProductDetails>> getProducts(List<String> productIds) async {
    final Set<String> ids = Set.from(productIds);
    final ProductDetailsResponse response =
        await iapConnection.queryProductDetails(ids);

    if (response.notFoundIDs.isNotEmpty) {
      logWarning("Not found products");
      return [];
    }
    return response.productDetails;
  }

  Future<void> clearPurchase() async {
    final paymentWrapper = SKPaymentQueueWrapper();
    if (Platform.isIOS) {
      final transactions = await paymentWrapper.transactions();
      for (final transaction in transactions) {
        if (transaction.transactionState ==
            SKPaymentTransactionStateWrapper.purchased) {
          try {
            await paymentWrapper.finishTransaction(transaction);
          } catch (e) {
            logError("Error while finishing transaction", error: Exception(e));
            return;
          }
        }
      }
    }
  }

  Future<bool> makePurchase(ProductDetails product) async {
    final purchaseUpdated = iapConnection.purchaseStream;
    final currentUser = await AuthenticationManager.getCurrentUser();
    final itunesId = currentUser!.trackingId;
    final purchaseParam =
        PurchaseParam(productDetails: product, applicationUserName: itunesId);
    await clearPurchase();
    await iapConnection.buyNonConsumable(purchaseParam: purchaseParam);
    final Completer<bool> complete = Completer();
    _subscription = purchaseUpdated.listen(
      (purchaseDetailsList) async {
        for (final purchaseDetails in purchaseDetailsList) {
          if (purchaseDetails.status == PurchaseStatus.restored ||
              purchaseDetails.status == PurchaseStatus.purchased) {
            if (purchaseDetails.productID.isNotEmpty) {
              if (Platform.isAndroid) {
                final purchaseAndroid =
                    purchaseDetails as GooglePlayPurchaseDetails;
                final result =
                    await _purchaseGoogleSubscription(purchaseAndroid, true);
                await _subscription.cancel();
                complete.complete(result);
              } else {
                final purchaseiOs = purchaseDetails as AppStorePurchaseDetails;
                final result = await _purchaseAppleSubscription(itunesId,
                    purchaseiOs.verificationData.localVerificationData);
                complete.complete(result);
              }
            }
          }
          if (purchaseDetails.status == PurchaseStatus.canceled) {
            await _subscription.cancel();
            complete.complete(false);
          }
          if (purchaseDetails.status == PurchaseStatus.error) {
            await InAppPurchase.instance.completePurchase(purchaseDetails);
            logError(purchaseDetails.error!.message,
                error: Exception(purchaseDetails.error));
          }
          if (purchaseDetails.pendingCompletePurchase) {
            await InAppPurchase.instance.completePurchase(purchaseDetails);
          }
        }

        await _subscription.cancel();
      },
    );
    return complete.future;
  }

  Future<bool> purchasePending(ProductDetails product) async {
    final purchaseUpdated = iapConnection.purchaseStream;

    final Completer<bool> complete = Completer();
    _subscription = purchaseUpdated.listen(
      (purchaseDetailsList) async {
        await _subscription.cancel();
        if (purchaseDetailsList.isNotNullOrEmpty) {
          final purchaseDetails = purchaseDetailsList
              .firstWhere((element) => element.productID == product.id);
          final purchaseAndroid = purchaseDetails as GooglePlayPurchaseDetails;
          if (purchaseDetails.isNotNull) {
            if (purchaseAndroid.billingClientPurchase.purchaseState ==
                    PurchaseStateWrapper.pending ||
                purchaseDetails.status == PurchaseStatus.pending) {
              await iapConnection
                  .completePurchase(purchaseDetails)
                  .then((value) async {
                if (purchaseDetails.productID.isNotEmpty) {
                  final result =
                      await _purchaseGoogleSubscription(purchaseAndroid, true);
                  complete.complete(result);
                }
              });
            }
          }
          complete.complete(false);
        }
        complete.complete(false);
      },
    );
    return complete.future;
  }
}
