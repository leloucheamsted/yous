import 'dart:async';
import 'package:youscribe/app.dart';
import 'package:youscribe/bootstrap.dart';
import 'package:youscribe/config/flavors.dart';
import 'package:youscribe/ys_method_channel.dart';

FutureOr<void> main() async {
  //NOTE: While debuging native lib, the flavor is sometimes null.
  F.appFlavor ??= Flavor.youscribedev;
  await bootstrap(App.new);
  YSMethodChannel.instance.configureChannel();
}
