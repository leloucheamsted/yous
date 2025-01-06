// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/language_entity.dart';
import 'package:youscribe/core/entities/product_category_entity.dart';
import 'package:youscribe/core/entities/product_facet_entity.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/presentation/blocs/search/search_results/search_results_bloc.dart';
import 'package:youscribe/presentation/blocs/search/shared.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/screens/search/widgets/popup_sub_menu.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/utilities/constants.dart';

// ignore: must_be_immutable
class SearchOptionsView extends StatefulWidget {
  SearchOptionsView(
      {required this.tableDisplayChanged,
      required this.scrollViewController,
      this.premiumDisplayOption,
      this.searchContext = SearchContext.product,
      this.sortOption = SortOption.relevance,
      this.categories = const [],
      this.themes = const [],
      this.languages = const [],
      this.searchText = '',
      this.title = '',
      this.selectedCategoryId,
      this.selectedLanguageId,
      this.selectedThemeId,
      super.key,
      this.isYsClassfification = true});

  final PremiumDisplayOption? premiumDisplayOption;
  final SearchContext searchContext;
  final SortOption sortOption;
  final List<ProductCategoryEntity> categories;
  final List<ProductFacetEntity> themes;
  final List<LanguageEntity> languages;
  final ScrollController scrollViewController;
  final bool isYsClassfification;

  final String searchText;
  final String title;
  final Future<void> Function(bool isLarge) tableDisplayChanged;
  late int? selectedLanguageId;
  late int? selectedCategoryId;
  late int? selectedThemeId;
  List<int> get categoryIds =>
      categories.isEmpty ? [] : categories.map((e) => e.id!).toList();
  List<int> get themeIds =>
      categories.isEmpty ? [] : themes.map((e) => e.id!).toList();

  @override
  State<SearchOptionsView> createState() => _SearchOptionsViewState();
}

class _SearchOptionsViewState extends State<SearchOptionsView>
    with SingleTickerProviderStateMixin {
  bool _isInSearchMode = false;
  bool _shouldShowLargeResults = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  late SortOption _selectedSortOption;
  late PremiumDisplayOption _selectedpremiumOption;
  late int _selectedLanguageId;
  late int _selectedCategoryId;
  late int _selectedThemeId;
  late int _selectedSubThemeId = 0;
  late String _selectedCategoryName = "";
  late String _selectedThemeName = "";
  late String _selectedSubThemeName = "";
  late int _oldSelectedSubThemeId = 0;
  late SearchContext _searchContext;
  bool _isAuthorSearchContextVisible = false;

  final _sortOptions = [
    SortOption.mostRead,
    SortOption.mostRecent,
    SortOption.relevance
  ];
  final premiumOptions = {
    PremiumDisplayOption.display,
    PremiumDisplayOption.doNotDisplay,
    PremiumDisplayOption.displayOnly,
  };
  final ConnectivityService connectivityService = locator();

  @override
  void initState() {
    if (widget.selectedCategoryId != null && widget.selectedCategoryId != 0) {
      _selectedCategoryId = widget.selectedCategoryId!;
    } else {
      _selectedCategoryId = widget.categories.first.id!;
    }

    if (widget.selectedThemeId != null && widget.selectedThemeId != 0) {
      _selectedThemeId = !widget.isYsClassfification
          ? widget.selectedCategoryId!
          : widget.selectedThemeId!;
      _oldSelectedSubThemeId = widget.selectedThemeId!;
    } else {
      _selectedThemeId = widget.themes.first.id!;
    }
    _selectedLanguageId = widget.selectedLanguageId ??
        (widget.languages.isNotNullOrEmpty ? widget.languages.first.id! : 0);
    _searchContext = widget.searchContext;
    _selectedSortOption = widget.sortOption;
    _selectedpremiumOption =
        widget.premiumDisplayOption ?? PremiumDisplayOption.display;

    if (widget.searchText.isNotEmpty) {
      _searchController.text = widget.searchText;
      _isInSearchMode = true;
      _isAuthorSearchContextVisible = true;
    } else {
      if (widget.searchContext == SearchContext.author) {
        _searchContext = SearchContext.product;
      }
      _isAuthorSearchContextVisible = false;
    }
    // if (!widget.isYsClassfification) {
    //   _selectedSubThemeName =
    //       ", ${widget.themes.firstWhere((element) => element.id == _selectedThemeId).children.firstWhere((e) => e.id == widget.selectedThemeId).label!}";
    // }
    super.initState();
  }

  void setDropDownOptionSelectedItem() {
    if (_selectedCategoryId != 0) {
      final containsCategories =
          widget.categories.any((element) => element.id == _selectedCategoryId);
      if (!containsCategories) {
        _selectedCategoryId = widget.categories.first.id!;
      } else {
        _selectedCategoryName =
            "${widget.categories.where((element) => element.id == _selectedCategoryId).first.label}";
      }
    } else {
      _selectedCategoryName = "";
    }
    if (_selectedLanguageId != 0) {
      final containslang =
          widget.languages.any((element) => element.id == _selectedLanguageId);
      if (!containslang) {
        _selectedLanguageId = widget.languages.first.id!;
      }
    }
    if (_selectedThemeId != 0) {
      final containsThemes =
          widget.themes.any((element) => element.id == _selectedThemeId);
      if (!containsThemes) {
        _selectedThemeId = widget.themes.first.id!;
      } else {
        {
          _selectedThemeName = _selectedCategoryName.isEmpty
              ? widget.themes
                  .where((element) => element.id == _selectedThemeId)
                  .first
                  .label!
              : ", ${widget.themes.where((element) => element.id == _selectedThemeId).first}";

          // !widget.isYsClassfification
          //     ? _selectedThemeName.isNotEmpty
          //         ? _selectedSubThemeName =
          //             ", ${widget.themes.where((element) => element.id == _selectedThemeId).first.children.firstWhere((e) => e.id == widget.selectedThemeId).label!}"
          //         : ''
          //     : '';
        }
      }
    } else {
      setState(() {
        _selectedThemeName = "";
        _selectedSubThemeName = "";
      });
    }
    // sendSearchOptionChangedEvent(context);
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(
    //     "### CatLength: ${widget.categories.length}, ThemeLength: ${widget.themes.length} LangLength: ${widget.languages.length} ");
    // print(
    //     "### Widget: CatId: ${widget.selectedCategoryId}, ThemeId: ${widget.selectedThemeId} LangId: ${widget.selectedLanguageId} ");
    // print(
    //     "### State: CatId: ${_selectedCategoryId}, ThemeId: ${_selectedThemeId} LangId: ${_selectedLanguageId} ");

    setDropDownOptionSelectedItem();

    // print("After drop");

    // print(
    //     "### CatLength: ${widget.categories.length}, ThemeLength: ${widget.themes.length} LangLength: ${widget.languages.length} ");
    // print(
    //     "### Widget: CatId: ${widget.selectedCategoryId}, ThemeId: ${widget.selectedThemeId} LangId: ${widget.selectedLanguageId} ");
    // print(
    //     "### State: CatId: ${_selectedCategoryId}, ThemeId: ${_selectedThemeId} LangId: ${_selectedLanguageId} ");
    return Center(
      child: SizedBox(
        height: 296,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ShaderMask(
              shaderCallback: YouScribeColors.ysGradient.createShader,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImagesName.headerBackground),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 30),

                //Search bar
                Container(
                  height: 80,
                  margin: const EdgeInsets.only(
                    top: 15,
                  ),
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    child: Row(children: [
                      BackButton(
                          onPressed: () {
                            if (_isInSearchMode) {
                              FocusScope.of(context).unfocus();
                              _searchController.text = "";
                              setState(() {
                                _isInSearchMode = false;
                                // _isAuthorSearchContextVisible = false;
                              });
                            } else {
                              context.pop();
                            }
                          },
                          color: YouScribeColors.whiteColor),
                      Expanded(
                          child: Stack(
                        children: [
                          AnimatedOpacity(
                            opacity: _isInSearchMode ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 250),
                            child: TextField(
                              onEditingComplete: () async {
                                FocusManager.instance.primaryFocus?.unfocus();

                                await _searchPressed(context);
                              },
                              onChanged: (value) {
                                if (value.isNullOrEmpty) {
                                  setState(() {
                                    _isInSearchMode = false;
                                    _isAuthorSearchContextVisible = false;
                                  });
                                  //Remove focus from the search entry.
                                  FocusScope.of(context).unfocus();
                                } else {
                                  setState(() {
                                    _isAuthorSearchContextVisible = true;
                                  });
                                }
                              },
                              controller: _searchController,
                              focusNode: _searchFocusNode,
                              cursorColor: YouScribeColors.blackColor,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: YouScribeColors.blackColor),
                              decoration: WidgetStyles.textFieldInputDecoration
                                  .copyWith(
                                      filled: true,
                                      fillColor: YouScribeColors.whiteColor,
                                      hintText:
                                          AppLocalizations.of(context)!.search),
                            ),
                          ),
                          if (!_isInSearchMode)
                            AnimatedOpacity(
                              opacity: !_isInSearchMode ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 250),
                              child: Center(
                                child: Text(
                                    "$_selectedCategoryName$_selectedThemeName$_selectedSubThemeName",
                                    maxLines: 1,
                                    style: WidgetStyles.title3TextStyle
                                        .copyWith(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w600,
                                            color: YouScribeColors.whiteColor)),
                              ),
                            )
                        ],
                      )),
                      IconButton(
                        onPressed: () => _searchPressed(context),
                        icon: const FontAwesomeTextIcon(
                          fontSize: 23,
                          color: YouScribeColors.whiteColor,
                          font: FontIcons.fontAwesomeSearch,
                        ),
                      )
                    ]),
                  ),
                ),

                //Search options
                ClipRRect(
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(50)),
                  child: Container(
                      padding: const EdgeInsets.only(left: 25),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(children: [
                          //Row 1
                          Row(
                            children: [
                              Expanded(
                                  child: DropdownButton<SortOption>(
                                isExpanded: true,
                                items: _sortOptions.map((e) {
                                  return DropdownMenuItem<SortOption>(
                                    value: e,
                                    child: Text(
                                        _sortOptionsToString(e, context),
                                        style: WidgetStyles.caption1TextStyle),
                                  );
                                }).toList(),
                                value: _selectedSortOption,
                                onChanged: (o) =>
                                    _sortOptionSelected(context, o),
                              )),
                              const SizedBox(width: 5),
                              Expanded(
                                  child: SizedBox(
                                child: DropdownButton<int>(
                                  isExpanded: true,
                                  items: widget.languages
                                      .map((e) => DropdownMenuItem<int>(
                                            value: e.id,
                                            child: Text(e.label ?? '',
                                                style: WidgetStyles
                                                    .caption1TextStyle
                                                    .copyWith(
                                                        overflow: TextOverflow
                                                            .ellipsis)),
                                          ))
                                      .toList(),
                                  value: _selectedLanguageId,
                                  onChanged: (o) =>
                                      _languageSelected(context, o),
                                ),
                              )),
                              const SizedBox(width: 5),
                              Flexible(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: _smallTableOptionSelected,
                                    icon: FontAwesomeTextIcon(
                                      font: FontIcons.fontAwesomeTh,
                                      color: _shouldShowLargeResults
                                          ? YouScribeColors.secondaryTextColor
                                          : YouScribeColors.primaryAppColor,
                                      fontSize: 30,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: _largeTableOptionSelected,
                                    icon: FontAwesomeTextIcon(
                                      font: FontIcons.fontAwesomeThLarge,
                                      color: _shouldShowLargeResults
                                          ? YouScribeColors.primaryAppColor
                                          : YouScribeColors.secondaryTextColor,
                                      fontSize: 30,
                                    ),
                                  ),
                                ],
                              )),
                            ],
                          ),

                          //Row 2
                          Row(
                              // mainAxisAlignment:
                              //     MainAxisAlignment.start,
                              children: [
                                if (widget.categories.isNotNullOrEmpty)
                                  Expanded(
                                      child: DropdownButton<int>(
                                    isExpanded: true,
                                    items: widget.categoryIds
                                        .map((e) => DropdownMenuItem<int>(
                                              value: e,
                                              child: Text(
                                                  widget.categories
                                                          .firstWhere(
                                                              (element) =>
                                                                  element.id ==
                                                                  e)
                                                          .label ??
                                                      '',
                                                  style: WidgetStyles
                                                      .caption1TextStyle
                                                      .copyWith(
                                                          overflow: TextOverflow
                                                              .ellipsis)),
                                            ))
                                        .toList(),
                                    value: _selectedCategoryId,
                                    onChanged: (o) =>
                                        _categoryOptionSelected(context, o),
                                  )),

                                const SizedBox(width: 10),

                                if (widget.themes.isNotNullOrEmpty)
                                  Expanded(
                                    child: PopupMenuButton<int>(
                                      elevation: 20,
                                      initialValue: _selectedThemeId,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      onSelected: (o) =>
                                          _themeOptionSelected(context, o),
                                      itemBuilder: (context) {
                                        return <PopupMenuEntry<int>>[
                                          ...widget.themeIds.map((e) => widget
                                                  .themes
                                                  .firstWhere((element) =>
                                                      element.id == e)
                                                  .children
                                                  .isNullOrEmpty
                                              ? PopupMenuItem<int>(
                                                  value: e,
                                                  child: Text(
                                                      widget.themes
                                                              .firstWhere(
                                                                  (element) =>
                                                                      element
                                                                          .id ==
                                                                      e)
                                                              .label ??
                                                          '',
                                                      style: WidgetStyles
                                                          .caption1TextStyle
                                                          .copyWith(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis)),
                                                )
                                              : PopupSubMenuItem<int>(
                                                  parentId: e,
                                                  themes: widget.themes
                                                      .firstWhere((element) =>
                                                          element.id == e)
                                                      .children,
                                                  title: widget.themes
                                                          .firstWhere(
                                                              (element) =>
                                                                  element.id ==
                                                                  e)
                                                          .label ??
                                                      '',
                                                  items: [
                                                    e,
                                                    ...widget.themes
                                                        .firstWhere((element) =>
                                                            element.id == e)
                                                        .children
                                                        .map((e) => e.id!)
                                                  ],
                                                  onSelected: (o) {
                                                    if (o != e) {
                                                      setState(() {
                                                        _selectedSubThemeId = o;
                                                        _selectedThemeId = e;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        _selectedSubThemeId = e;
                                                        _selectedThemeId = e;
                                                      });
                                                    }
                                                    _themeOptionSelected(
                                                        context, o);
                                                    // }
                                                  },
                                                )),
                                        ];
                                      },
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.2)))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                    widget.themes
                                                            .firstWhere((element) =>
                                                                element.id ==
                                                                _selectedThemeId)
                                                            .label ??
                                                        '',
                                                    style: WidgetStyles
                                                        .caption1TextStyle
                                                        .copyWith(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis)),
                                              ),
                                              Icon(Icons.arrow_drop_down,
                                                  color: Colors.black
                                                      .withOpacity(0.6)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                const SizedBox(width: 10),

                                //Column 3 Row 2
                                if (widget.premiumDisplayOption != null)
                                  SizedBox(
                                      width: 130,
                                      child:
                                          DropdownButton<PremiumDisplayOption>(
                                        isExpanded: true,
                                        items: premiumOptions
                                            .map((e) => DropdownMenuItem<
                                                    PremiumDisplayOption>(
                                                value: e,
                                                child: Text(
                                                    _premiumOptionsToString(
                                                        e, context),
                                                    style: WidgetStyles
                                                        .caption1TextStyle)))
                                            .toList(),
                                        value: _selectedpremiumOption,
                                        onChanged: (o) =>
                                            _premiumOptionSelected(context, o),
                                      )),
                              ]),

                          //Row 3
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(children: [
                                      Radio<SearchContext>(
                                          activeColor:
                                              YouScribeColors.accentColor,
                                          groupValue: _searchContext,
                                          value: SearchContext.product,
                                          onChanged: (c) =>
                                              _searchContextChanged(
                                                  context, c)),
                                      Text(AppLocalizations.of(context)!.works,
                                          style:
                                              WidgetStyles.caption1TextStyle),
                                    ]),
                                  ),
                                  Expanded(
                                    child: Row(children: [
                                      Radio<SearchContext>(
                                          activeColor:
                                              YouScribeColors.accentColor,
                                          groupValue: _searchContext,
                                          value: SearchContext.collection,
                                          onChanged: (c) =>
                                              _searchContextChanged(
                                                  context, c)),
                                      Text(
                                          AppLocalizations.of(context)!
                                              .collections,
                                          style:
                                              WidgetStyles.caption1TextStyle),
                                    ]),
                                  ),
                                  if (_isAuthorSearchContextVisible)
                                    Expanded(
                                      child: Row(children: [
                                        Radio<SearchContext>(
                                            activeColor:
                                                YouScribeColors.accentColor,
                                            groupValue: _searchContext,
                                            value: SearchContext.author,
                                            onChanged: (c) =>
                                                _searchContextChanged(
                                                    context, c)),
                                        Text(
                                            AppLocalizations.of(context)!
                                                .authors,
                                            style:
                                                WidgetStyles.caption1TextStyle),
                                      ]),
                                    ),
                                ],
                              ),
                              const Divider(
                                color: YouScribeColors.primaryAppColor,
                                thickness: 2,
                              ),
                            ],
                          )
                        ]),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _searchPressed(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (!await connectivityService.isInternetAvailable) {
      if (context.mounted) {
        await Dialogs.displayInternetNeededAlert(context: context);
      }
      return;
    }
    _selectedSortOption = SortOption.relevance;
    if (_isInSearchMode) {
      if (context.mounted) {
        sendSearchOptionChangedEvent(context);
      }
    }
    setState(() {
      if (_searchController.text.isNullOrEmpty) {
        if (!_isInSearchMode) {
          _isInSearchMode = true;
          _searchFocusNode.requestFocus();
        } else {
          _isInSearchMode = false;
          FocusScope.of(context).unfocus();
        }
      } else {
        _isInSearchMode = true;
      }
    });
  }

  String _sortOptionsToString(SortOption option, BuildContext context) {
    switch (option) {
      case SortOption.mostRead:
        return AppLocalizations.of(context)!.mostRead;
      case SortOption.mostRecent:
        return AppLocalizations.of(context)!.mostRecent;
      case SortOption.relevance:
        return AppLocalizations.of(context)!.relevanceSortOption;
    }
  }

  String _premiumOptionsToString(
      PremiumDisplayOption option, BuildContext context) {
    switch (option) {
      case PremiumDisplayOption.display:
        return AppLocalizations.of(context)!.withPremium;
      case PremiumDisplayOption.doNotDisplay:
        return AppLocalizations.of(context)!.withoutPremium;
      case PremiumDisplayOption.displayOnly:
        return AppLocalizations.of(context)!.onlyPremium;
    }
  }

  Future<void> _searchContextChanged(
      BuildContext context, SearchContext? option) async {
    if (option == null) {
      return;
    }
    setState(() {
      _searchContext = option;
    });
    if (!await connectivityService.isInternetAvailable) {
      if (context.mounted) {
        await Dialogs.displayInternetNeededAlert(context: context);
      }
      return;
    }
    if (context.mounted) {
      sendSearchOptionChangedEvent(context);
    }
  }

  void _largeTableOptionSelected() {
    setState(() {
      _shouldShowLargeResults = true;
    });
    widget.tableDisplayChanged(_shouldShowLargeResults);
  }

  void _smallTableOptionSelected() {
    setState(() {
      _shouldShowLargeResults = false;
    });
    widget.tableDisplayChanged(_shouldShowLargeResults);
  }

  Future<void> _languageSelected(BuildContext context, int? option) async {
    if (option == null) {
      return;
    }
    setState(() {
      _selectedLanguageId = option;
    });
    if (!await connectivityService.isInternetAvailable) {
      if (context.mounted) {
        await Dialogs.displayInternetNeededAlert(context: context);
      }
      return;
    }
    if (context.mounted) {
      sendSearchOptionChangedEvent(context);
    }
  }

  Future<void> _sortOptionSelected(
      BuildContext context, SortOption? option) async {
    if (option == null) {
      return;
    }
    setState(() {
      _selectedSortOption = option;
    });
    if (!await connectivityService.isInternetAvailable) {
      if (context.mounted) {
        await Dialogs.displayInternetNeededAlert(context: context);
      }
      return;
    }
    if (context.mounted) {
      sendSearchOptionChangedEvent(context);
    }
  }

  Future<void> _categoryOptionSelected(
      BuildContext context, int? option) async {
    if (option == null) {
      return;
    }
    setState(() {
      _selectedCategoryId = option;
    });
    if (!await connectivityService.isInternetAvailable) {
      if (context.mounted) {
        await Dialogs.displayInternetNeededAlert(context: context);
      }
      return;
    }

    // if (widget.isYsClassfification) {
    if (context.mounted) {
      sendSearchOptionChangedEvent(context);
    }
    // } else {
    // if (_searchController.text.isNotNullOrEmpty) {
    // _selectedThemeId = _oldSelectedThemeId;
    // _selectedSubThemeId = _oldSelectedSubThemeId;
    // sendSearchOptionChangedEvent(context);
    // }
    // }
  }

  Future<void> _themeOptionSelected(BuildContext context, int? option) async {
    if (option == null) {
      return;
    }
    if (option == 0) {
      if (!widget.isYsClassfification) {
        _selectedThemeId = 0;
        _selectedSubThemeId = 0;
        _oldSelectedSubThemeId = widget.selectedThemeId!;
      }
    }
    if (_selectedSubThemeId != 0 &&
        option != 0 &&
        _selectedThemeId != _selectedSubThemeId) {
      setState(() {
        _selectedSubThemeName =
            ", ${widget.themes.firstWhere((element) => element.id == _selectedThemeId).children.firstWhere((e) => e.id == _selectedSubThemeId).label!}";
      });
    } else {
      setState(() {
        _selectedSubThemeName = "";
      });
    }

    // setState(() {
    //   _selectedThemeId = option;
    // });
    if (!await connectivityService.isInternetAvailable) {
      if (context.mounted) {
        await Dialogs.displayInternetNeededAlert(context: context);
      }
      return;
    }
    if (context.mounted) {
      sendSearchOptionChangedEvent(context);
    }
  }

  // Future<void> _subThemeOptionSelected(
  //     BuildContext context, int themeId, int? subTheme) async {
  //   setState(() {
  //     _selectedThemeId = themeId;
  //     _selectedSubThemeId = subTheme!;
  //   });
  //   if (!await connectivityService.isInternetAvailable) {
  //     if (context.mounted) {
  //       await Dialogs.displayInternetNeededAlert(context: context);
  //     }
  //     return;
  //   }
  //   sendSearchOptionChangedEvent(context);
  // }

  Future<void> _premiumOptionSelected(
      BuildContext context, PremiumDisplayOption? option) async {
    if (option == null) {
      return;
    }
    setState(() {
      _selectedpremiumOption = option;
    });
    if (!await connectivityService.isInternetAvailable) {
      if (context.mounted) {
        await Dialogs.displayInternetNeededAlert(context: context);
      }
      return;
    }
    if (context.mounted) {
      sendSearchOptionChangedEvent(context);
    }
  }

  Future<void> checkConnectionAvailabe() async {
    final ConnectivityService connectivityService = locator();
    if (!await connectivityService.isInternetAvailable) {
      if (context.mounted) {
        await Dialogs.displayInternetNeededAlert(context: context);
      }
      return;
    }
  }

  void sendSearchOptionChangedEvent(BuildContext context) {
    context.read<SearchResultsBloc>().add(SearchOptionChangedEvent(
          premiumDisplayOption: _selectedpremiumOption,
          languageId: _selectedLanguageId,
          searchContext: _searchContext,
          categoryId: !widget.isYsClassfification
              ? _searchContext == SearchContext.collection ||
                      _searchContext == SearchContext.author
                  ? widget.categories[1].id
                  : _selectedThemeId == 0
                      ? _selectedCategoryId
                      : _selectedCategoryId
              : _selectedCategoryId,
          sortOption: _selectedSortOption,
          themeId: !widget.isYsClassfification
              ? _selectedSubThemeId == 0 && _selectedThemeId == 0
                  ? widget.selectedThemeId
                  : _selectedSubThemeId == 0
                      ? _oldSelectedSubThemeId
                      : _selectedSubThemeId
              : (_selectedSubThemeId == 0)
                  ? _selectedThemeId
                  : _selectedSubThemeId,
          query: _searchController.text,
        ));
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      widget.scrollViewController.animateTo(0,
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      timer.cancel();
    });
  }
}
