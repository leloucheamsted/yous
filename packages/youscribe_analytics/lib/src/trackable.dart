import 'package:youscribe_analytics/src/analytics_tracker.dart';

mixin Trackable {
  /// Access to the tracker instance
  AnalyticsTracker get tracker => AnalyticsTracker.instance;
}
