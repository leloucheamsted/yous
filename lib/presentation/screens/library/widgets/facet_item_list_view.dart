import 'package:flutter/material.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class FacetItemListView extends StatelessWidget {
  const FacetItemListView(
      {required this.title, required this.onFacetSelected, super.key});
  final String title;
  final Function onFacetSelected;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        child: InkWell(
          onTap: () => onFacetSelected,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Divider(
                thickness: 1,
                height: 1,
                color: YouScribeColors.secondaryTextColor,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(width: 25),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: YouScribeColors.secondaryTextColor),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
