import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class SeeMoreButton extends StatelessWidget {
  const SeeMoreButton({required this.callBackAction, super.key});
  final void Function() callBackAction;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: 130,
      child: Center(
        child: ElevatedButton(
            onPressed: callBackAction,
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
                backgroundColor: MaterialStateProperty.all<Color>(
                  YouScribeColors.primaryAppColor,
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  YouScribeColors.whiteColor,
                )),
            child: Text(
              '${AppLocalizations.of(context)!.seeMore} +',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: YouScribeColors.whiteColor,
                  fontWeight: FontWeight.w800),
            )),
      ),
    );
  }
}
