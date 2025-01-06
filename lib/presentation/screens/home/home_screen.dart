// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/entities/editorial_entity.dart';
import 'package:youscribe/core/entities/selection_model.dart';
import 'package:youscribe/core/entities/ys_notification.dart';
import 'package:youscribe/core/extensions/build_context_extension.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/presentation/blocs/app_purchase/app_purchase_cubit.dart';
import 'package:youscribe/presentation/blocs/home/home_bloc.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/screens/home/widgets/home_view.dart';
import 'package:youscribe/presentation/screens/home/widgets/skeleton_home_loader.dart';
import 'package:youscribe/presentation/screens/shared/app_purchase_view.dart';
import 'package:youscribe/presentation/screens/shared/sliding_app_bar.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/styles/youscribe_theme.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe/utilities/youscribe_premium.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class HomeScreen extends StatefulWidget with Debuggable, Loggable {
  const HomeScreen({super.key});

  @override
  String get debugName => 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  ScrollController _scrollViewController = ScrollController();
  bool isScrollingDown = false;
  double _appBarSize = appBarHeight;
  StreamSubscription<RemoteMessage>? _remoteMessageSub;
  StreamSubscription<RemoteMessage>? _remoteMessageSub2;

  late final AnimationController _appBarAnimationController;
  final ValueNotifier<double> opacity = ValueNotifier(0);
  final cubit = AppPurchaseCubit();
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

    //TODO: Resolve this issue:
    //  Missing google_app_id. Firebase Analytics disabled
    //TODO: Check this doc: https://firebase.google.com/docs/cloud-messaging/flutter/receive?hl=en#apple_platforms_and_android
    // WARNING: This listener makes Pspdfkit events not working on Android.
    _remoteMessageSub =
        FirebaseMessaging.onMessage.listen(_firebaseForegroundMessageReceived);
    _remoteMessageSub2 = FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _performInitNotificationActions(message, true);
    });

    //Get the message that woke the app up when notification was tapped.
    final initMessage = FirebaseMessaging.instance.getInitialMessage();
    _handleInitNotification(initMessage);
  }

  // ignore: unused_element
  Future<void> _firebaseForegroundMessageReceived(RemoteMessage message) async {
    widget.logInfo("Foreground notification received ${message.data}");
    return _performInitNotificationActions(message);
  }

  Future<void> _handleInitNotification(
      Future<RemoteMessage?> messageFuture) async {
    final remoteMessage = await messageFuture;
    if (remoteMessage != null) {
      widget.logInfo(
          "Notification received when app opened ${remoteMessage.data}");
      await _performInitNotificationActions(remoteMessage, true);
    }
  }

  Future<bool?> _displayNotificationPopup(YsNotification notification) {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(notification.title),
            content: SizedBox(
              height: notification.image == null ? 150 : 300,
              child: Column(
                children: [
                  SizedBox(
                    height: 90,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        child: Text(
                          notification.body ?? '',
                          overflow: TextOverflow.clip,
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: WidgetStyles.secondaryTextStyle.copyWith(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (notification.image != null)
                    Container(
                        height: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(notification.image!)))),
                  if (notification.image != null)
                    const SizedBox(
                      height: 5,
                    ),
                  Row(children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: Text(AppLocalizations.of(context)!.ok)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: Text(AppLocalizations.of(context)!.cancel)),
                    ),
                  ])
                ],
              ),
            ),
          );
        });
  }

  //we handle notification reception here.
  //pending states that the app is handling a notification that should be
  //displayed as the app is coming from the back-ground.
  Future<void> _performInitNotificationActions(RemoteMessage message,
      [bool isPending = false]) async {
    try {
      if (message.data.isEmpty) {
        return;
      }

      final strData =
          message.data.map((key, value) => MapEntry(key, value.toString()));
      final notif = YsNotification(message.notification?.title ?? "",
          message.notification?.body ?? "", strData);
      bool? result = true;

      if (!isPending) {
        result = await _displayNotificationPopup(notif);
      }

      if (result ?? false) {
        if (context.mounted) {
          if (notif.type == YsNotificationType.openProductPage) {
            await context.pushNamed(Routes.productDetails, queryParameters: {
              Routes.productIdParamName: notif.productId.toString(),
            });
          } else if (notif.type == YsNotificationType.openAuthorPage) {
            await context.pushNamed(Routes.authorPage, queryParameters: {
              Routes.authorIdParamName: notif.authorId.toString(),
            });
          } else if (notif.type == YsNotificationType.openEditorPage) {
            await context.pushNamed(Routes.publisherProducts, queryParameters: {
              Routes.publisherIdParamName: notif.editorId.toString(),
            });
          } else if (notif.type == YsNotificationType.openSelection) {
            await context.pushNamed(Routes.selectionDetails, queryParameters: {
              Routes.selectionIdParamName: notif.editorId.toString(),
            });
          } else if (notif.type == YsNotificationType.openUrl &&
              notif.urlToOpen != null) {
            final Uri url = Uri.parse(notif.urlToOpen!);
            if (!await launchUrl(url)) {
              widget.logError(
                  'Could not open url: "${notif.urlToOpen}" from notification:',
                  error: Exception("Couldn't open url $url"));
            }
          }
        }
      }
    } catch (e) {
      widget.logError(
          // ignore: lines_longer_than_80_chars
          "Fatal error while handling notifications. ${message.data}",
          error: Exception(e));
    }
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _appBarAnimationController.dispose();
    if (_remoteMessageSub != null) {
      _remoteMessageSub!.cancel();
    }
    if (_remoteMessageSub2 != null) {
      _remoteMessageSub2!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<YouScribePremium>(context, listen: false)
        .loadUserStatePremiumSubscription();
    Provider.of<YouScribeTheme>(context, listen: false).getCobraString();
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
                  image:
                      AssetImage(Provider.of<YouScribeTheme>(context).brand)),
            )),
        body: AppPurchasView(
          cubit: cubit,
          child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            if (state is HomeExceptionState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.showErrorSnackBar(
                    AppLocalizations.of(context)!.errorOccuredGeneralTitle);
              });
              context.read<HomeBloc>().add(DialogsDisplayedEvent());
              state = state.previousState;
            }

            if (state is HomeShowRateState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Dialogs.showStarRateDialog(context);
              });
              context.read<HomeBloc>().add(DialogsDisplayedEvent());
              state = state.previousState;
            }

            if (state is HomeLoadedState) {
              if (!state.isRefreshedData) {
                return HomeView(
                  cubit: cubit,
                  shouldShowSubscriptionBanner:
                      state.shouldShowSubscriptionBanner,
                  scrollController: _scrollViewController,
                  editorials: state.editorials,
                  suggestions: state.gleephSeggestions,
                  selections: state.selections,
                  purchaseSubscription: _purchaseSubscription,
                  onEditorialSelected: (editorial) =>
                      _onEditorSeleted(context, editorial),
                  onSelectionSelected: (selection) =>
                      _onSelectionSelected(context, selection),
                  onsuggestionsSelected: _onsuggestionsSeleted,
                );
              }
              if (state.isRefreshedData) {
                return const SkeletonHomeLoader();
              }
            }
            return const SkeletonHomeLoader();
          }),
        ));
  }

  Future<void> _onEditorSeleted(
      BuildContext context, EditorialEntity editorial) async {
    if (editorial.link.isNullOrEmpty) {
      widget.logError(
        // ignore: lines_longer_than_80_chars
        "editorial  link was null. ImageUrl: ${editorial.imageUrl}, TypeId ${editorial.typeId}",
      );
      return;
    }

    await _navigateToProductsInSelectionPage(context, editorial.link!);
  }

  Future<void> _onSelectionSelected(
      BuildContext context, SelectionEntity selection) async {
    late final ConnectivityService connectivityService = locator();
    if (!await connectivityService.isInternetAvailable) {
      if (context.mounted) {
        await Dialogs.displayInternetNeededAlert(context: context);
      }
      return;
    }
    if (selection.selectionUrl.isNullOrEmpty) {
      widget.logError(
        // ignore: lines_longer_than_80_chars
        "Selection url was null. SelectionId: ${selection.id}",
      );
      return;
    }

    await _navigateToProductsInSelectionPage(context, selection.selectionUrl!);
  }

  Future<void> _navigateToProductsInSelectionPage(
      BuildContext context, String selectionUrl) async {
    final selectionId = selectionUrl.replaceAll("?", "").split('=');

    if (context.mounted) {
      await context.pushNamed(Routes.productsInYsSelection, queryParameters: {
        Routes.ysSelectionIdParamName: selectionId,
      });
    }
  }

  void _onsuggestionsSeleted() {}
  void _purchaseSubscription() {
    cubit.callSubscriptionPopup(false);
  }
}
