import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class YSBottomNavigationBar extends StatefulWidget {
  const YSBottomNavigationBar(
      {required this.onTabSelected, required this.selectedindex, super.key});
  final int selectedindex;
  final Future<void> Function(int index) onTabSelected;

  @override
  State<YSBottomNavigationBar> createState() => _YSBottomNavigationBarState();
}

class _YSBottomNavigationBarState extends State<YSBottomNavigationBar> {
  _YSBottomNavigationBarState();


  @override
  Widget build(BuildContext context) {
    const double iconSize = 22;

    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomAppBar(
          color: Theme.of(context).primaryColorLight,
          clipBehavior: Clip.antiAlias,
          shape: const CircularNotchedRectangle(),
          elevation: 0,
          height: 89,
          notchMargin: 7,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            currentIndex: widget.selectedindex,
            onTap: (index) {
              //NOTE: If the index is that of the empty item, just ignore it.
              widget.onTabSelected(index);
            },
            elevation: 0,
            selectedItemColor: YouScribeColors
                .primaryAppColor, //Theme.of(context).iconTheme.color,
            unselectedItemColor:
                YouScribeColors.whiteColor, //YouScribeColors.primaryTextColor,
            // backgroundColor: Theme.of(context).primaryColor,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColorLight,
                icon: FontAwesomeTextIcon(
                  font: FontIcons.fontAwesomeHome,
                  fontSize: iconSize,
                  color: widget.selectedindex == 0
                      ? YouScribeColors.primaryAppColor
                      : Theme.of(context).colorScheme.secondary,
                ),
                label: AppLocalizations.of(context)!.home,
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColorLight,
                icon: FontAwesomeTextIcon(
                  fontSize: iconSize,
                  font: FontIcons.fontAwesomeBooks,
                  color: widget.selectedindex == 1
                      ? YouScribeColors.primaryAppColor
                      : Theme.of(context).colorScheme.secondary,
                ),
                label: AppLocalizations.of(context)!.explore,
              ),

              //NOTE: This is an empty item, to let place for the search FAB
              const BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Text(""),
                label: '',
              ),

              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColorLight,
                icon: FontAwesomeTextIcon(
                  fontSize: iconSize,
                  font: FontIcons.fontAwesomeList,
                  color: widget.selectedindex == 3
                      ? YouScribeColors.primaryAppColor
                      : Theme.of(context).colorScheme.secondary,
                ),
                label: AppLocalizations.of(context)!.myLists,
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColorLight,
                icon: FontAwesomeTextIcon(
                  fontSize: iconSize,
                  font: FontIcons.fontAwesomeUser,
                  color: widget.selectedindex == 4
                      ? YouScribeColors.primaryAppColor
                      : Theme.of(context).colorScheme.secondary,
                ),
                label: AppLocalizations.of(context)!.myAccount,
              ),
            ],
          ),
        ));
  }
}
