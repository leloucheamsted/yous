import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:youscribe_analytics/src/analytics_config.dart';
import 'package:youscribe_analytics/src/analytics_event.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

abstract class AnalyticsTracker with Debuggable, Loggable {
  const AnalyticsTracker._(this.config);

  static AnalyticsTracker? _instance;

  /// Get the analytics tracker instance
  ///
  /// Throws an exception if the instance is not initialized
  static AnalyticsTracker get instance {
    if (_instance == null) {
      throw Exception('AnalyticsTracker instance is not initialized');
    }
    return _instance!;
  }

  /// Set the analytics tracker instance
  ///
  /// This is useful for testing purposes
  static set instance(AnalyticsTracker tracker) => _instance = tracker;

  /// Initialize the analytics tracker
  static Future<void> init({AnalyticsConfig? config}) async {
    _instance = FirebaseAnalyticsTracker(config as FirebaseAnalyticsConfig?);
  }

  /// Check if the analytics tracker is initialized
  static bool get isInitialized => _instance != null;

  /// Config used to initialize the analytics tracker
  final AnalyticsConfig? config;

  /// Track an event with optional parameters
  Future<void> track(
    AnalyticsEvent event, {
    Map<String, dynamic>? parameters,
  });

  /// Bind the user id to the analytics tracker
  Future<void> setUserId(String userId);

  /// Unbind the user id from the analytics tracker
  Future<void> resetUserId();

  /// Reset the analytics tracker
  Future<void> reset();
}

/// Firebase analytics tracker implementation
class FirebaseAnalyticsTracker extends AnalyticsTracker {
  /// Use this constructor to create a new instance of the
  /// FirebaseAnalyticsTracker, but it is recommended to use the
  /// [AnalyticsTracker.init] factory method to initialize the tracker
  /// and set the instance as the default tracker
  ///
  /// Useful if you want to use your own dependencies injection system
  /// instead of the singleton pattern
  FirebaseAnalyticsTracker(
    FirebaseAnalyticsConfig? super.config,
  )   : _analytics = config?.analytics ?? FirebaseAnalytics.instance,
        super._();

  final FirebaseAnalytics _analytics;

  @override
  String get debugName => 'FirebaseAnalyticsTracker';

  @override
  Future<void> resetUserId() => _analytics.setUserId();

  @override
  Future<void> setUserId(String userId) => _analytics.setUserId(id: userId);

  @override
  Future<void> reset() {
    logDebug('Resetting analytics data');
    return _analytics.resetAnalyticsData();
  }

  @override
  Future<void> track(
    AnalyticsEvent event, {
    Map<String, dynamic>? parameters,
  }) {
    logDebug(
        '''Track event: $event${parameters?.isNotEmpty ?? false ? ' with parameters: $parameters' : ''}''');

    return _analytics.logEvent(
      name: event.name,
      parameters: parameters,
    );
  }
}
