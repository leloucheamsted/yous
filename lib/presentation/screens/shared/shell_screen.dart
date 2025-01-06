import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:youscribe/app.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/app_settings.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/presentation/blocs/app_shell/app_shell_bloc.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/screens/shared/sliding_app_bar.dart';
import 'package:youscribe/presentation/screens/shared/ys_bottom_navigation_bar.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/presentation/widgets/player.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/styles/youscribe_theme.dart';

// ignore: must_be_immutable
class ShellScreen extends StatefulWidget {
  ShellScreen({required this.child, super.key});

  Widget child;

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen>
    with SingleTickerProviderStateMixin {
  bool _appBarVisible = false;
  late final AnimationController _appBarAnimationController;
  bool _shouldAppBarDisappear = true;
  int _selectedindex = 0;
  bool isFirstOpenMyListTab = true;
  @override
  void initState() {
    super.initState();
    _appBarAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    )..addStatusListener(_appbarHideAnimationCompleteListener);
  }

  ///Once the animation completes, hide the appbar completely by making it
  ///disappear.
  void _appbarHideAnimationCompleteListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        if (!_appBarVisible) {
          _shouldAppBarDisappear = true;
        } else {
          _shouldAppBarDisappear = false;
        }
      });
    }
  }

  void _screenSetup() {
    //Get current app language from device or database, and set it to the app.
    // TODO(youscribe): make it possible to change the language at runtime using this method: https://stackoverflow.com/a/65380235/7442601
  }

  void hideOrShowAppBar(bool visible) {
    setState(() {
      _shouldAppBarDisappear = false;
      _appBarVisible = visible;
    });
  }

  Future<void> startSearch() async {
    GoRouter.of(context).go('/${Routes.search}');
    setState(() {
      _shouldAppBarDisappear = true;
      _appBarVisible = false;
      _selectedindex = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    _screenSetup();
    return BlocBuilder<AppShellBloc, AppShellState>(builder: (context, state) {
      if (state is AppShellInitialState) {
        App.of(context)!.setLocale(Localizations.localeOf(context));
      }
      App.of(context)!
          .setDownloadNotificationConfig(AppLocalizations.of(context));

      return PopScope(
          canPop: false,
          onPopInvoked: (didOpop) async {
            if (_selectedindex != 0) {
              GoRouter.of(context).go('/${Routes.home}');
              setState(() {
                _shouldAppBarDisappear = true;
                _appBarVisible = false;
                _selectedindex = 0;
              });
              return;
            }
            final AppSettings appSettings = locator();
            final pop = await Dialogs.displayBackAlert(
                context: context,
                content: AppLocalizations.of(context)!
                    .canNavigateBackMessage(appSettings.appName));
            if (pop) {
              final AudioPlayer audioPlayer = locator();
              await audioPlayer.stop();
              await SystemNavigator.pop();
            }
            return;
          },
          child: scafoldPage());
    });
  }

  Scaffold scafoldPage() => Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: _shouldAppBarDisappear
          ? null
          : SlidingAppBar(
              visible: _appBarVisible,
              controller: _appBarAnimationController,
              child: AppBar(
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                elevation: 0.5,
                title: Image(
                    height: 35,
                    image:
                        AssetImage(Provider.of<YouScribeTheme>(context).brand)),
              )),
      body: Stack(
        children: [
          widget.child,
          const Player(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: YouScribeColors.primaryAppColor,
        shape: const CircleBorder(),
        child: const FontAwesomeTextIcon(
            font: FontIcons.fontAwesomeSearch,
            fontSize: 20,
            color: YouScribeColors
                .whiteColor //Theme.of(context).scaffoldBackgroundColor,
            ),
        onPressed: () async {
          await startSearch();
        },
      ),
      bottomNavigationBar: YSBottomNavigationBar(
          selectedindex: _selectedindex,
          onTabSelected: (index) async {
            setState(() {
              _selectedindex = index;
            });
            if (index == 0) {
              GoRouter.of(context).go('/${Routes.home}');
              setState(() {
                _shouldAppBarDisappear = true;
                _appBarVisible = false;
              });
            } else if (index == 1) {
              GoRouter.of(context).go('/${Routes.library}');
              setState(() {
                _shouldAppBarDisappear = true;
                _appBarVisible = false;
              });
            } else if (index == 2) {
              setState(() {
                _selectedindex = 2;
              });
              await startSearch();
            } else if (index == 3) {
              GoRouter.of(context)
                  .go('/${Routes.myLists}', extra: isFirstOpenMyListTab);
              setState(() {
                if (isFirstOpenMyListTab) {
                  isFirstOpenMyListTab = false;
                }
                _shouldAppBarDisappear = true;
                _appBarVisible = false;
              });
            } else if (index == 4) {
              GoRouter.of(context).go('/${Routes.account}');
              hideOrShowAppBar(true);
            }
          }));

  @override
  void dispose() {
    super.dispose();
    _appBarAnimationController.dispose();
  }
}
