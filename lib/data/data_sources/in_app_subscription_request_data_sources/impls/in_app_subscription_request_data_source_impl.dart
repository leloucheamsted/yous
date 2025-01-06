import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:youscribe/core/models/requests/save_in_app_subscription.dart';
import 'package:youscribe/core/models/responses/google_play_model.dart';
import 'package:youscribe/core/models/responses/in_app_purchase_pay_model.dart';
import 'package:youscribe/data/data_sources/base_remote_data_source.dart';
import 'package:youscribe/data/data_sources/in_app_subscription_request_data_sources/in_app_subscription_request_data_source.dart';
import 'package:youscribe/utilities/constants.dart';

class InAppSubscriptionRequestDataSourceImpl extends BaseRemoteDataSource
    implements InAppSubscriptionRequestDataSource {
  InAppSubscriptionRequestDataSourceImpl(
      {required super.dio, required super.appSettings});

  @override
  Future<GooglePlayPayModel> createSubscriptionGooglePlayAsync(
      SaveInAppSubscription saveInAppSubscription) async {
    final url =
        '${appSettings.mobileAPIUrl}/v1/subscriptions/googleplay/subscribe';
    final body = json.encode({
      "platform": "${saveInAppSubscription.platform}",
      "productId": "${saveInAppSubscription.productId}",
      "purchaseId": "${saveInAppSubscription.purchaseId}",
      "purchaseToken": "${saveInAppSubscription.purchaseToken}"
    });
    final response = await postStringBody(url, body);
    final reponseDynamic = response.data as dynamic;
    final res =
        GooglePlayPayModel.fromJson(reponseDynamic as Map<String, dynamic>);
    return res;
  }

  @override
  Future<InAppPurchasePayModel> createSubscriptionWithReceiptAsync(
      String itunesId, String receipt) async {
    final url =
        "${appSettings.mobileAPIUrl}/v1/subscriptions/in-app-purchase?itunesId=${Uri.encodeComponent(itunesId)}";

    final response = await postStringBody(url, json.encode(receipt));
    final reponseDynamic = response.data as dynamic;
    return InAppPurchasePayModel.fromJson(
        reponseDynamic as Map<String, dynamic>);
  }
}
