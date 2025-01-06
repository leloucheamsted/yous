import 'package:youscribe_analytics/src/analytics_tracker.dart';

/// Enum representing the different analytics events that can be tracked.
enum AnalyticsEvent {
  ratingRequestAcceptedEvent('rating_request_accepted'),
  gleephHomeSuggestionsClicked('home_recos_gleeph'),
  suggestsHomeSuggestionsClicked('home_recos_suggest'),
  suggestsProdPageSuggestionsClicked('fp_recos_suggest'),
  gleephProdPageSuggestionsClicked('fp_recos_gleeph'),
  suggestsReadSuggestionsClicked('reader_recos_suggest'),
  gleephReadSuggestionsClicked('reader_recos_gleeph'),
  facebookAuthEvent('facebook_authentication'),
  canalPlusAuthEvent('canal_plus_authentication'),
  ysDynamicAuthEvent('youscribe_dynamic_authentication'),
  garAuthEvent('gar_authentication'),
  appleAuthEvent('apple_authentication'),
  ratingRequestInitiatedEvent('rating_request_initiated'),
  emailSignupEvent('email_sign_up'),
  ratingRequestDeclinedEvent('rating_request_declined'),
  emailLoginEvent('email_login'),
  downloadPausedEvent('download_paused'),
  downloadFailedEvent('download_failed'),
  signoutEvent('sign_out'),
  pushNotificationTappedEvent('push_notification_tapped'),
  productSelectedEvent('product_selected'),
  productAddedToFavEvent('product_added_to_favorite'),
  productRemovedFromFavEvent('product_removed_from_favorite'),
  productDownloadedEvent('product_downloaded'),
  productAddedToOfflineEvent('product_added_to_offline'),
  productRemovedFromOfflineEvent('product_removed_from_offline'),
  productReadEvent('product_read'),
  inAppPurchaseSucceededEvent('in_app_purchase_succeeded'),
  pdfBookReadEvent('pdf_book_read'),
  audiobookReadEvent('audiobook_read'),
  offlineAudiobookReadEvent('offline_audiobook_read'),
  productSyncedEvent('product_synced'),
  bookCategoryExploredEvent('book_category_browsed'),
  bookSearchedEvent('book_searched'),
  userSeekedHelpEvent('user_seeked_help'),
  userInitiatedContactSupportEvent('user_initiated_contact_support'),
  selectionBrowsedEvent('selection_browsed'),
  inAppPurchaseInitiatedEvent('in_app_purchase_initiated'),
  inAppPurchaseCanceledEvent('in_app_purchase_canceled'),
  inAppPurchaseFailedEvent('in_app_purchase_failed'),
  epubBookReadEvent('epub_book_read');

  const AnalyticsEvent(this.value);

  /// The value of the event that will be sent to the analytics service.
  final String value;

  @override
  String toString() => value;
}

extension AnalyticsTrackerExtensions on AnalyticsTracker {
  Future<void> trackFacebookAuthentication() async {
    await AnalyticsTracker.instance.track(AnalyticsEvent.facebookAuthEvent);
  }

  Future<void> trackCanalPlusAuthentication() async {
    await AnalyticsTracker.instance.track(AnalyticsEvent.canalPlusAuthEvent);
  }

  Future<void> trackYSDynamicAuthentication() async {
    await AnalyticsTracker.instance.track(AnalyticsEvent.ysDynamicAuthEvent);
  }

  Future<void> trackGarAuthentication() async {
    await AnalyticsTracker.instance.track(AnalyticsEvent.garAuthEvent);
  }

  Future<void> trackAppleAuthentication() async {
    await AnalyticsTracker.instance.track(AnalyticsEvent.appleAuthEvent);
  }

  Future<void> trackRatingRequestInitiated() async {
    await AnalyticsTracker.instance
        .track(AnalyticsEvent.ratingRequestInitiatedEvent);
  }

  Future<void> trackRatingRequestAccepted() async {
    await AnalyticsTracker.instance
        .track(AnalyticsEvent.ratingRequestAcceptedEvent);
  }

  Future<void> trackRatingRequestDeclined() async {
    await AnalyticsTracker.instance
        .track(AnalyticsEvent.ratingRequestDeclinedEvent);
  }

  Future<void> trackEmailSignup() async {
    await AnalyticsTracker.instance.track(AnalyticsEvent.emailSignupEvent);
  }

  Future<void> trackEmailLogin() async {
    await AnalyticsTracker.instance.track(AnalyticsEvent.emailLoginEvent);
  }

  Future<void> trackDownloadPaused({required String productId}) async {
    await AnalyticsTracker.instance.track(AnalyticsEvent.downloadPausedEvent,
        parameters: {'product_id': productId});
  }

  Future<void> trackDownloadFailed({required String productId}) async {
    await AnalyticsTracker.instance.track(AnalyticsEvent.downloadFailedEvent,
        parameters: {'product_id': productId});
  }

  Future<void> trackSignout() async {
    await AnalyticsTracker.instance.track(AnalyticsEvent.signoutEvent);
  }

  Future<void> trackPushNotificationTapped() async {
    await AnalyticsTracker.instance
        .track(AnalyticsEvent.pushNotificationTappedEvent);
  }

  Future<void> trackProductSelected() async {
    await AnalyticsTracker.instance.track(AnalyticsEvent.productSelectedEvent);
  }

  Future<void> trackProductAddedToFav({
    required String productId,
  }) async {
    await AnalyticsTracker.instance
        .track(AnalyticsEvent.productAddedToFavEvent, parameters: {
      'product_id': productId,
    });
  }

  Future<void> trackProductRemovedFromFav({
    required String productId,
  }) async {
    await AnalyticsTracker.instance
        .track(AnalyticsEvent.productRemovedFromFavEvent, parameters: {
      'product_id': productId,
    });
  }

  Future<void> trackProductDownloaded() async {
    await AnalyticsTracker.instance
        .track(AnalyticsEvent.productDownloadedEvent);
  }

  Future<void> trackProductAddedToOffline({
    required String productId,
  }) async {
    await AnalyticsTracker.instance
        .track(AnalyticsEvent.productAddedToOfflineEvent, parameters: {
      'product_id': productId,
    });
  }

  Future<void> trackProductRemovedFromOffline({
    required String productId,
  }) async {
    await AnalyticsTracker.instance
        .track(AnalyticsEvent.productRemovedFromOfflineEvent, parameters: {
      'product_id': productId,
    });
  }

  Future<void> trackProductRead({
    required String productId,
  }) async {
    await AnalyticsTracker.instance.track(AnalyticsEvent.productReadEvent,
        parameters: {'product_id': productId});
  }

  Future<void> trackInAppPurchaseSucceeded() async {
    await AnalyticsTracker.instance
        .track(AnalyticsEvent.inAppPurchaseSucceededEvent);
  }

  Future<void> trackPDFBookRead() async {
    await AnalyticsTracker.instance.track(AnalyticsEvent.pdfBookReadEvent);
  }

  Future<void> trackAudiobookRead() async {
    await AnalyticsTracker.instance.track(AnalyticsEvent.audiobookReadEvent);
  }

  Future<void> trackOfflineAudiobookRead() async {
    await AnalyticsTracker.instance
        .track(AnalyticsEvent.offlineAudiobookReadEvent);
  }

  Future<void> trackProductSynced() async {
    await AnalyticsTracker.instance.track(AnalyticsEvent.productSyncedEvent);
  }

  Future<void> trackBookCategoryExplored() async {
    await AnalyticsTracker.instance
        .track(AnalyticsEvent.bookCategoryExploredEvent);
  }

  Future<void> trackBookSearched() async {
    await AnalyticsTracker.instance.track(AnalyticsEvent.bookSearchedEvent);
  }

  Future<void> trackUserSeekedHelp() async {
    await AnalyticsTracker.instance.track(AnalyticsEvent.userSeekedHelpEvent);
  }

  Future<void> trackUserInitiatedContactSupport() async {
    await AnalyticsTracker.instance
        .track(AnalyticsEvent.userInitiatedContactSupportEvent);
  }

  Future<void> trackSelectionBrowsed() async {
    await AnalyticsTracker.instance.track(AnalyticsEvent.selectionBrowsedEvent);
  }

  Future<void> trackInAppPurchaseInitiated() async {
    await AnalyticsTracker.instance
        .track(AnalyticsEvent.inAppPurchaseInitiatedEvent);
  }

  Future<void> trackInAppPurchaseCanceled() async {
    await AnalyticsTracker.instance
        .track(AnalyticsEvent.inAppPurchaseCanceledEvent);
  }

  Future<void> trackInAppPurchaseFailed() async {
    await AnalyticsTracker.instance
        .track(AnalyticsEvent.inAppPurchaseFailedEvent);
  }

  Future<void> trackEpubBookRead() async {
    await AnalyticsTracker.instance.track(AnalyticsEvent.epubBookReadEvent);
  }

  Future<void> trackGleephHomeSuggestionsClicked() async {
    await AnalyticsTracker.instance
        .track(AnalyticsEvent.gleephHomeSuggestionsClicked);
  }

  Future<void> trackSuggestsHomeSuggestionsClicked() async {
    await AnalyticsTracker.instance
        .track(AnalyticsEvent.suggestsHomeSuggestionsClicked);
  }

  Future<void> trackSuggestsProdPageSuggestionsClicked() async {
    await AnalyticsTracker.instance
        .track(AnalyticsEvent.suggestsProdPageSuggestionsClicked);
  }

  Future<void> trackGleephProdPageSuggestionsClicked() async {
    await AnalyticsTracker.instance
        .track(AnalyticsEvent.gleephProdPageSuggestionsClicked);
  }
}
