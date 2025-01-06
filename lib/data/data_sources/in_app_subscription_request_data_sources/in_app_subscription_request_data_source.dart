import 'package:youscribe/core/models/requests/save_in_app_subscription.dart';
import 'package:youscribe/core/models/responses/google_play_model.dart';
import 'package:youscribe/core/models/responses/in_app_purchase_pay_model.dart';

abstract class InAppSubscriptionRequestDataSource {
  Future<InAppPurchasePayModel?> createSubscriptionWithReceiptAsync(
      String itunesId, String receipt);

  Future<GooglePlayPayModel?> createSubscriptionGooglePlayAsync(
      SaveInAppSubscription saveInAppSubscription);
}
