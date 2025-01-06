import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:youscribe/presentation/blocs/my_lists/my_favorites/my_favorites_bloc.dart';
import 'package:youscribe/presentation/blocs/my_lists/my_last_reads/my_last_reads_bloc.dart';
import 'package:youscribe/presentation/blocs/my_lists/my_offlines/my_offlines_bloc.dart';
import 'package:youscribe/presentation/blocs/my_lists/my_selections/my_selections_bloc.dart';
import 'package:youscribe/presentation/screens/my_lists/my_favorites_screen.dart';
import 'package:youscribe/presentation/screens/my_lists/my_last_reads_screen.dart';
import 'package:youscribe/presentation/screens/my_lists/my_offlines_screen.dart';
import 'package:youscribe/presentation/screens/my_lists/selections/my_selections_screen.dart';
import 'package:youscribe/presentation/screens/shared/sliding_app_bar.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_theme.dart';

class MyListsScreen extends StatefulWidget {
  const MyListsScreen({required this.isFirstOpenMyListTab, super.key});
  final bool isFirstOpenMyListTab;
  @override
  State<MyListsScreen> createState() => _MyListsScreenState();
}

class _MyListsScreenState extends State<MyListsScreen>
    with TickerProviderStateMixin {
  ScrollController _scrollViewController = ScrollController();

  bool isScrollingDown = false;
  int occurence_lastScreen = 1;
  int occurence_offlineScreen = 0;
  int occurence_favScreen = 0;

  double _appBarSize = 60;
  late final AnimationController _appBarAnimationController;
  @override
  void initState() {
    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.offset <= 1) {
        setState(() {
          _appBarSize = 60;
        });
      } else if (_scrollViewController.offset > 0) {
        setState(() {
          _appBarSize = 60 - (_scrollViewController.offset / 10) > 0
              ? 60 - (_scrollViewController.offset / 10)
              : 0;
        });
      }
    });

    super.initState();

    _appBarAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _appBarAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double fontIconSize = 25;
    const int tabLength = 4;
    return Scaffold(
      appBar: SlidingAppBar(
          visible: true,
          controller: _appBarAnimationController,
          child: AppBar(
            toolbarHeight: _appBarSize,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            elevation: 0.5,
            title: Image(
                height: _appBarSize - 15,
                image: AssetImage(Provider.of<YouScribeTheme>(context).brand)),
          )),
      body: DefaultTabController(
          length: tabLength,
          child: Builder(builder: (context) {
            //NOTE: We put the builder, having the builder makes the
            //init method of the bloc called after every navigation.
            final tabController = DefaultTabController.of(context);
            tabController.addListener(() {
              if (tabController.index == 0) {
                setState(() {
                  occurence_lastScreen += 1;
                });
              }
              if (tabController.index == 1) {
                setState(() {
                  occurence_offlineScreen += 1;
                });
              }
              if (tabController.index == 2) {
                setState(() {
                  occurence_favScreen += 1;
                });
              }
            });
            return Column(children: [
              TabBar(
                  labelStyle: WidgetStyles.title3TextStyle
                      .copyWith(fontSize: WidgetStyles.caption1Size),
                  unselectedLabelStyle: TextStyle(
                      fontSize: WidgetStyles.caption1Size,
                      color: Theme.of(context).disabledColor),
                  tabs: [
                    Tab(
                        text: AppLocalizations.of(context)!.nowReading,
                        icon: FontAwesomeTextIcon(
                            font: FontIcons.fontAwesomeBookReader,
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: fontIconSize)),
                    Tab(
                        text: AppLocalizations.of(context)!.offline,
                        icon: FontAwesomeTextIcon(
                            font: FontIcons.fontAwesomeCloudDownload,
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: fontIconSize)),
                    Tab(
                        text: AppLocalizations.of(context)!.myFavorites,
                        icon: FontAwesomeTextIcon(
                            color: Theme.of(context).colorScheme.secondary,
                            font: FontIcons.fontAwesomeStar,
                            fontSize: fontIconSize)),
                    Tab(
                        text: AppLocalizations.of(context)!.mySelections,
                        icon: FontAwesomeTextIcon(
                            font: FontIcons.fontAwesomeBookArrowUp,
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: fontIconSize)),
                  ]),
              Expanded(
                  child: TabBarView(children: [
                BlocProvider(
                    create: (context) =>
                        MyLastReadsBloc()..add(InitMyLastReadsEvent()),
                    child: MyLastReadScreen(
                        occurenceLatReadScreen: occurence_lastScreen,
                        isFirstOpenMyListTab: widget.isFirstOpenMyListTab,
                        scrollController: _scrollViewController)),
                BlocProvider(
                    create: (context) =>
                        MyOfflinesBloc()..add(InitMyOfflinesEvent()),
                    child: MyOfflinesScreen(
                        occurence0fflineScreen: occurence_offlineScreen,
                        isFirstOpenMyListTab: widget.isFirstOpenMyListTab,
                        scrollController: _scrollViewController)),
                BlocProvider(
                    create: (context) =>
                        MyFavoritesBloc()..add(InitMyFavoritesEvent()),
                    child: MyFavoritesScreen(
                        isFirstOpenTab: true,
                        occurenceFavoriteScreen: occurence_favScreen,
                        isFirstOpenMyListTab: widget.isFirstOpenMyListTab,
                        scrollController: _scrollViewController)),
                BlocProvider(
                    create: (context) =>
                        MySelectionsBloc()..add(const InitMySelectionsEvent()),
                    child: MySelectionsScreen(
                        scrollController: _scrollViewController)),
              ])),
            ]);
          })),
    );
  }
}
