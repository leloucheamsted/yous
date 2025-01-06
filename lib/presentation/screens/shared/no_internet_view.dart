import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:youscribe/utilities/constants.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Lottie.asset(AssetsName.animationNoInternet,
            height: 500, width: 500, repeat: false));
  }
}
