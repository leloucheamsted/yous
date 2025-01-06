import 'package:firebase_analytics/firebase_analytics.dart';

abstract class AnalyticsConfig {
  const AnalyticsConfig();

  @override
  String toString() => 'AnalyticsConfig';
}

class FirebaseAnalyticsConfig extends AnalyticsConfig {
  const FirebaseAnalyticsConfig({
    required this.analytics,
  });

  /// Optional Firebase Analytics instance to use
  final FirebaseAnalytics? analytics;

  @override
  String toString() => 'FirebaseAnalyticsConfig';
}
