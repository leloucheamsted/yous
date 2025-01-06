import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/use_cases/user/is_user_subscribe_use_case.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class YouScribePremium with ChangeNotifier, Debuggable, Loggable {
  YouScribePremium() {
    loadUserStatePremiumSubscription();
  }
  bool _isPremium = true;
  bool get isPremium => _isPremium;

  @override
  String get debugName => 'YouScribePremium';

  Future<void> changepPremiunState() async {
    _isPremium = !_isPremium;
    notifyListeners();
  }

  Future<void> loadUserStatePremiumSubscription() async {
    late final IsUserSubscribeUseCase subscribeUseCase = locator();
    final currentUser = await AuthenticationManager.getCurrentUser();
    final prefs = await SharedPreferences.getInstance();
    final isUserSubscribed = await subscribeUseCase(null);
    if (isUserSubscribed.isErr) {
      logError(
          '''Error occured while checking if user is subscribed: ${isUserSubscribed.err}''',
          error: isUserSubscribed.err);
    }
    final isGarUserConnected = prefs.getBool(PreferenceKey.isGarUserConnected);

    _isPremium = isUserSubscribed.ok ?? currentUser!.isSubscriber ?? false;

    if (isGarUserConnected != null && isGarUserConnected) {
      _isPremium = true;
    }
    notifyListeners();
  }
}
