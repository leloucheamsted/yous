import 'package:go_router/go_router.dart';

/// Flatten the [GoRoute] tree.
extension RouteBaseExtension on RouteBase {
  List<GoRoute> flatten() {
    final List<GoRoute> routes = [];
    if (this is GoRoute) {
      routes.add(this as GoRoute);
    } else if (this is ShellRoute) {
      routes.addAll(
        (this as ShellRoute)
            .routes
            .map((route) => route.flatten())
            .expand((routeList) => routeList),
      );
    }

    return routes;
  }
}
