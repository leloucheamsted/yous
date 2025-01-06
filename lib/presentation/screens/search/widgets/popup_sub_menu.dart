// ignore_for_file: inference_failure_on_function_return_type

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youscribe/core/entities/product_facet_entity.dart';
import 'package:youscribe/styles/widget_styles.dart';

/// [title] is the text which will be displayed in the pop up
/// [items] is the list of ints items to populate the sub menu
/// [themes] is the list of themes to populate the sub menu
/// [onSelected] is the callback to be fired if specific item is pressed

class PopupSubMenuItem<T> extends PopupMenuEntry<T> {
  const PopupSubMenuItem({
    required this.title,
    required this.items,
    required this.parentId,
    required this.themes,
    required this.onSelected,
    super.key,
  });

  final String title;
  final List<T> items;
  final T parentId;
  final List<ProductFacetEntity> themes;
  final Function(T) onSelected;

  @override
  double get height =>
      kMinInteractiveDimension; //Does not actually affect anything

  @override
  bool represents(T? value) =>
      false; //Our submenu does not represent any specific value for
      // the parent menu

  @override
  State createState() => _PopupSubMenuState<T>();
}

/// The [State] for [PopupSubMenuItem] subclasses.
class _PopupSubMenuState<T> extends State<PopupSubMenuItem<T>> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      color: Theme.of(context).scaffoldBackgroundColor,
      tooltip: widget.title,
      onCanceled: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      onSelected: (value) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        widget.onSelected.call(value);
      },
      itemBuilder: (context) {
        return widget.items
            .map(
              (item) => item == widget.parentId
                  ? PopupMenuItem<T>(
                      value: item,
                      child: Text(AppLocalizations.of(context)!.everySubThemes,
                          style: WidgetStyles.caption1TextStyle
                              .copyWith(overflow: TextOverflow.ellipsis)),
                    )
                  : PopupMenuItem<T>(
                      value: item,
                      child: Text(
                          widget.themes.firstWhere((e) => e.id == item).label ??
                              '',
                          style: WidgetStyles.caption1TextStyle
                              .copyWith(overflow: TextOverflow.ellipsis)),
                    ),
            )
            .toList();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 8, top: 12, bottom: 12),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(widget.title,
                  style: WidgetStyles.caption1TextStyle
                      .copyWith(overflow: TextOverflow.ellipsis)),
            ),
            Icon(
              Icons.arrow_right,
              size: 24,
              color: Theme.of(context).iconTheme.color,
            ),
          ],
        ),
      ),
    );
  }
}
