// ignore: lines_longer_than_80_chars
// ignore_for_file: public_member_api_docs, sort_constructors_first, inference_failure_on_function_return_type
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

import 'package:youscribe/core/entities/simple_library_entity.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

// ignore: must_be_immutable
class CreateSelectionDialog extends StatefulWidget {
  CreateSelectionDialog(
      {this.onCreate, this.onUpdate, super.key, this.selection});
  final SimpleLibraryEntity? selection;
  Function(SimpleLibraryEntity)? onUpdate;
  Function(String name, bool isPublic)? onCreate;

  @override
  State<CreateSelectionDialog> createState() => _CreateSelectionDialogState();
}

class _CreateSelectionDialogState extends State<CreateSelectionDialog> {
  bool _markPublic = false;
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..text = widget.selection!.label ?? "";
    _markPublic = widget.selection!.isPublic;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Builder(builder: (context) {
        final width = MediaQuery.of(context).size.width;
        return contentBox(context, width);
      }),
    );
  }

  Widget contentBox(BuildContext context, double width) {
    return Container(
      height: 200,
      width: width - 30,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context)!.createSelection,
                  textAlign: TextAlign.center,
                  style: WidgetStyles.title3TextStyle.copyWith(
                    overflow: TextOverflow.clip,
                  ),
                ),
                _buildPhoneInputFiled(context),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              YouScribeColors.primaryAppColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.cancel,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: YouScribeColors.whiteColor),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (widget.selection!.id.isNotNull) {
                            widget.onUpdate!(widget.selection!);
                          } else {
                            widget.onCreate!(_controller.text, _markPublic);
                          }
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              YouScribeColors.primaryAppColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.ok,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: YouScribeColors.whiteColor),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPhoneInputFiled(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: (value) => {
        if (value.isNotEmpty) {widget.selection!.label = value}
      },
      keyboardType: TextInputType.text,
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.selectionName,
        hintStyle: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}

enum TypeName {
  personal,
  public,
}
