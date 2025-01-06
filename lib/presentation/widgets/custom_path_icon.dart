import 'package:flutter/material.dart';
import 'package:path_icon/path_icon.dart';

class CustomPathIcon extends StatelessWidget {
  const CustomPathIcon({required this.path, super.key, this.fontSize, this.color});
  final PathIconData path;
  final double? fontSize;
  final Color? color;
  
  @override
  Widget build(BuildContext context) {
    return PathIcon(
      path,
      color: color ?? Colors.white,
      size: fontSize,
    );
  }
}
