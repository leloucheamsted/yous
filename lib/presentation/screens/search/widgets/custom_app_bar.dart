import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/utilities/constants.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({required this.handleSearchTextChange, super.key});
  final void Function(String) handleSearchTextChange;
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isTyping = false;
  double _width = 0;
  double _sizeCircleSearch = 0;
  final Duration _animatioDuration = const Duration(seconds: 1);
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: appBarHeight * 2,
      alignment: Alignment.bottomCenter,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _searchBar(),
            // SizedBox(width: isTyping ? 5 : 0),
            AnimatedContainer(
                width: _sizeCircleSearch,
                height: 45,
                alignment: Alignment.center,
                duration: _animatioDuration,
                curve: Curves.fastOutSlowIn,
                child: IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                  },
                  icon: const FontAwesomeTextIcon(
                      font: FontIcons.fontAwesomeSearch,
                      fontSize: 25,
                      color: YouScribeColors.primaryAppColor),
                ))
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return AnimatedContainer(
      height: 45,
      width: _width == 0 ? MediaQuery.of(context).size.width - 16 : _width,
      decoration: BoxDecoration(
        border: Border.all(
          color: YouScribeColors.primaryAppColor,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      duration: _animatioDuration,
      curve: Curves.fastOutSlowIn,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(child: _buildPhoneInputFiled()),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  _searchCtrl.clear();
                  hideCancelBtn();
                },
                child: AnimatedOpacity(
                  opacity: isTyping ? 1.0 : 0.0,
                  duration: _animatioDuration,
                  child: const FontAwesomeTextIcon(
                      font: FontIcons.fontAwersoneCancel,
                      fontSize: 20,
                      color: YouScribeColors.primaryAppColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneInputFiled() {
    return TextField(
      autofocus: true,
      controller: _searchCtrl,
      onChanged: (value) {
        if (value.length >= 3) {
          widget.handleSearchTextChange(value);
          showCancelBtn();
        }
      },
      autocorrect: false,
      keyboardType: TextInputType.text,
      textAlign: TextAlign.left,
      textAlignVertical: TextAlignVertical.bottom,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        isCollapsed: true,
        focusedBorder: InputBorder.none,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: AppLocalizations.of(context)!.search,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: YouScribeColors.secondaryTextColor),
      ),
    );
  }

  void hideCancelBtn() {
    setState(() {
      isTyping = false;
      _width = MediaQuery.of(context).size.width - 16;
      _sizeCircleSearch = 0;
      isTyping = false;
    });
  }

  void showCancelBtn() {
    setState(() {
      _width = MediaQuery.of(context).size.width - 66;
      _sizeCircleSearch = 50;
      isTyping = true;
    });
  }
}
