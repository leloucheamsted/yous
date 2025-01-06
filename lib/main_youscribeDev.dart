// ignore_for_file: file_names

import 'package:youscribe/config/flavors.dart';
import 'package:youscribe/main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.youscribedev;
  await runner.main();
}
