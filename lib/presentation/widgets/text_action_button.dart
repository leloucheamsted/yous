import 'package:flutter/material.dart';
import 'package:youscribe/utilities/constants.dart';

class TextActionButton extends StatelessWidget {
  const TextActionButton(
      {required this.child, required this.onPressed, super.key});
  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        textStyle: const MaterialStatePropertyAll<TextStyle>(TextStyle(
          fontFamily: FontName.openSans,
        )),
        backgroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).buttonTheme.colorScheme!.primary),
        foregroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).buttonTheme.colorScheme!.secondary,
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
