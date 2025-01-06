// ignore_for_file: cascade_invocations

import 'package:flutter/material.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class DownloadProgressIndicator extends StatelessWidget {
  const DownloadProgressIndicator(
      {required this.percentage,
      required this.indicatorColor,
      required this.size,
      super.key});
  final int percentage;
  final Color indicatorColor;
  final double size;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: double.infinity,
        ),
        child: SizedBox(
            child: percentage > 0 && percentage < 100
                ? ColoredBox(
                    color: YouScribeColors.blackColor.withOpacity(0.3),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipPath(
                            clipper: MyClipper1(),
                            child: Container(
                              color:
                                  YouScribeColors.whiteColor.withOpacity(0.3),
                              width: size,
                              height: size * 2,
                              child: Row(
                                children: [
                                  Container(
                                    color: indicatorColor,
                                    width: percentage < 51
                                        ? (percentage * size) / 50
                                        : size,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 1),
                          ClipPath(
                            clipper: MyClipper2(),
                            child: Container(
                              color:
                                  YouScribeColors.whiteColor.withOpacity(0.3),
                              width: size,
                              height: size * 2,
                              child: Row(
                                children: [
                                  Container(
                                    color: indicatorColor,
                                    width: percentage > 51
                                        ? ((percentage - 50) * size) / 50
                                        : 0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : null));
  }
}

class MyClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final Offset center = size.center(Offset.zero);
    path
      ..moveTo(0, 0)
      ..quadraticBezierTo(center.dx, 0, size.width, size.width / 2)
      ..quadraticBezierTo(size.width, 0, size.width, size.height)
      ..quadraticBezierTo(center.dx, size.height / 1.2, 0, size.height / 1.2)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class MyClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path
      ..moveTo(0, size.width / 2)
      ..quadraticBezierTo(size.width / 2, 0, size.width, 0)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height / 1.2)
      ..quadraticBezierTo(size.height / 4, size.height / 1.2, 0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
