import 'package:go_router/go_router.dart';
import 'package:youscribe/config/router/page_protection.dart';

/// Defines if a GoRoute is public or not.
///
/// By default, all routes are in the [PageProtection.none] state.
extension GoRouteGuard on GoRoute {
  static final _guard = Expando<PageProtection>();

  /// Returns `true` if the route is public.
  bool get isPublic => _guard[this] == PageProtection.public;

  /// Returns `true` if the route is protected.
  bool get isProtected => _guard[this] == PageProtection.protected;

  /// Returns `true` if the route is neither public nor protected.
  /// This is the default state.
  bool get isNone => _guard[this] == PageProtection.none;

  /// Sets the route to be public.
  /// This is useful for routes that should be accessible
  /// without authentication.
  /// ```dart
  /// GoRoute(
  ///  path: '/sign_in',
  ///  ...
  /// )..setPublic(),
  /// ```
  void setPublic() => _guard[this] = PageProtection.public;

  /// Sets the route to be protected.
  /// This is useful for routes that should only be accessible
  /// with authentication.
  void setProtected() => _guard[this] = PageProtection.protected;

  PageProtection get guard => _guard[this] ?? PageProtection.none;
}
