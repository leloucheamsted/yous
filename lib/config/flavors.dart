enum Flavor {
  youscribedev,
  maktabatidev,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title => switch (appFlavor) {
        Flavor.youscribedev => 'YouScribe Dev',
        Flavor.maktabatidev => 'Maktabati Dev',
        _ => 'title',
      };
  static String get environment => switch (appFlavor) {
        Flavor.youscribedev => 'Dev',
        Flavor.maktabatidev => 'Dev',
        _ => 'Unknown',
      };
}
