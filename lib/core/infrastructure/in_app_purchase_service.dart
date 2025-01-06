import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

abstract class InAppPurchaseService extends BaseRepository with Debuggable, Loggable {
  @override
  String get debugName => 'InAppPurchaseService';

  Future<String> getProductPrice();
  Future<bool> subscribe();
  Future<bool> wasSubscriptionPurchased();
  Future<void> purchaseSubscription(List<PurchaseDetails> purchases);
}
