import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/utilities/constants.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({required this.message, this.color, super.key});

  final String message;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: YouScribeColors.accentColor,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Center(
              child: Lottie.asset(AssetsName.animationEmptyBox,
                  height: 300, width: 300, repeat: false)),
          Text(
            AppLocalizations.of(context)!.emptyListText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: color,
                fontWeight: FontWeight.w300,
                overflow: TextOverflow.clip),
          ),
        ],
      ),
    );
  }
}
