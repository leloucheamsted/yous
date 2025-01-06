import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youscribe/presentation/screens/products/widgets/product_description.dart';
import 'package:youscribe/presentation/screens/products/widgets/product_information.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/utilities/view_utilities.dart';

class ProductDetailsDescriptionWidget extends StatefulWidget {
  const ProductDetailsDescriptionWidget(
      {required this.title,
      required this.author,
      required this.language,
      required this.isAudio,
      required double size,
      required this.isPremium,
      required this.duration,
      required this.showHeader,
      required this.ownerDisplayableUserName,
      required this.authorId,
      required this.ownerId,
      super.key,
      this.plainDescription,
      this.opinion,
      this.comments,
      this.subjects,
      this.totalPages})
      : _size = size;

  final String? plainDescription;
  final String? comments;
  final List<String>? subjects;
  final void Function(bool) showHeader;

  final String title;
  final String author;
  final int authorId;
  final int ownerId;
  final String language;
  final bool isAudio;
  final String duration;
  final String? opinion;
  final int? totalPages;
  final String ownerDisplayableUserName;
  final bool isPremium;
  final double _size;
  double get size => _size.toPrecision(2);

  @override
  State<ProductDetailsDescriptionWidget> createState() =>
      _ProductDetailsDescriptionWidgetState();
}

class _ProductDetailsDescriptionWidgetState
    extends State<ProductDetailsDescriptionWidget>
    with TickerProviderStateMixin {
  late TabController controller;
  int _selectedTabbar = 0;

  @override
  void initState() {
    // TODO: implement initState
    controller = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 30,
          child: Stack(
            children: [
              Positioned(
                bottom: 1,
                right: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    height: 2,
                    thickness: 2,
                    color: YouScribeColors.secondaryTextColor.withOpacity(0.5),
                  ),
                ),
              ),
              TabBar(
                onTap: (index) {
                  setState(() {
                    _selectedTabbar = index;
                    widget.showHeader(true);
                  });
                },
                isScrollable: true,
                controller: controller,
                tabAlignment: TabAlignment.start,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                      width: 4, color: YouScribeColors.primaryAppColor),
                ),
                labelColor: YouScribeColors.primaryAppColor,
                unselectedLabelColor: YouScribeColors.secondaryTextColor,
                indicatorColor: YouScribeColors.primaryAppColor,
                labelStyle: WidgetStyles.title3TextStyle.copyWith(
                    fontSize: WidgetStyles.title3Size,
                    fontWeight: FontWeight.w600),
                unselectedLabelStyle:
                    const TextStyle(fontSize: WidgetStyles.title3Size),
                tabs: [
                  Tab(
                    text: AppLocalizations.of(context)!.description,
                  ),
                  Tab(
                    text: AppLocalizations.of(context)!.information,
                  )
                ],
              ),
            ],
          ),
        ),
        Builder(builder: (_) {
          if (_selectedTabbar == 0) {
            return ProductDescription(
              showHeader: widget.showHeader,
              plainDescription: widget.plainDescription ?? '',
              subjects: widget.subjects ?? [],
              comments: widget.comments,
              opinion: widget.opinion,
            ); //1st custom tabBarView
          } else {
            return ProductInformation(
              title: widget.title,
              authorId: widget.authorId,
              ownerId: widget.ownerId,
              duration: widget.duration,
              language: widget.language,
              ownerDisplayableUserName: widget.ownerDisplayableUserName,
              author: widget.author,
              isAudio: widget.isAudio,
              size: widget.size,
              totalPages: widget.totalPages,
              isPremium: widget.isPremium,
            ); //3rd tabView
          }
        }),
      ],
    );
  }
}
