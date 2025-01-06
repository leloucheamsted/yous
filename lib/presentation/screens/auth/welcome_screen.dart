import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/entities/user_global_settings_entity.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe/presentation/blocs/app_purchase/app_purchase_cubit.dart';
import 'package:youscribe/presentation/blocs/auth/welcome/welcome_bloc.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final CarouselController _carouselController = CarouselController();
  late int _currentIndex = 0;
  final UserAccountRepository _userAccountRepository = locator();
  late UserGlobalSettingsEntity localSettings;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _setLocalSettings();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown
    ]);

    super.dispose();
  }

  Future<void> _setLocalSettings() async {
    localSettings = await _userAccountRepository.getUserSettings();
  }

  Future<void> _registerUser() async {
    final purchaseCubit = AppPurchaseCubit();
    final isInappPurchaseAllowed = await purchaseCubit.isAnAppPurchaseAllowd();

    if (Platform.isAndroid &&
        localSettings.countryConfiguration != null &&
        !localSettings.countryConfiguration!.registerAllowed!) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Dialogs.displaySmsSubscriptionAlert(
            redirectToSMSApp: purchaseCubit.redirectToSMSApp,
            config: isInappPurchaseAllowed.$2!,
            context: context);
      });
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await GoRouter.of(context).pushNamed(Routes.signUp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WelcomeBloc, WelcomeState>(builder: (context, state) {
      final cubit = context.read<WelcomeBloc>();
      final state = cubit.state as WelcomeInitialState;

      return Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ColoredBox(
            color: YouScribeColors.onboardingBackgroundColor,
            child: Stack(children: [
              CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  height: MediaQuery.of(context).size.height,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: state.carouselImages.map((image) {
                  String title = '';
                  String description = '';

                  if (_currentIndex == 0) {
                    title = AppLocalizations.of(context)!.welcomeOnboardingText;
                  } else if (_currentIndex == 1) {
                    title =
                        AppLocalizations.of(context)!.secondOnboardingPageTitle;
                  } else if (_currentIndex == 2) {
                    title =
                        AppLocalizations.of(context)!.thirdOnboardingPageTitle;
                  } else if (_currentIndex == 3) {
                    title =
                        AppLocalizations.of(context)!.fourthOnboardingPageTitle;
                  }

                  if (_currentIndex == 0) {
                    description = AppLocalizations.of(context)!
                        .welcomeOnboardingTextDescription;
                  } else if (_currentIndex == 1) {
                    description = AppLocalizations.of(context)!
                        .secondOnboardingPageDescription;
                  } else if (_currentIndex == 2) {
                    description = AppLocalizations.of(context)!
                        .thirdOnboardingPageDescription;
                  } else if (_currentIndex == 3) {
                    description = AppLocalizations.of(context)!
                        .fourthOnboardingPageDescription;
                  }

                  return Builder(
                    builder: (context) {
                      return Stack(children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset("assets/images/$image"),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, bottom: 30),
                            height: 230,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  style: WidgetStyles.title1TextStyle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: YouScribeColors.whiteColor),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Text(description,
                                      maxLines: 5,
                                      textAlign: TextAlign.left,
                                      style: WidgetStyles.textStyle.copyWith(
                                          color: YouScribeColors.whiteColor)),
                                )
                              ],
                            ),
                          ),
                        )
                      ]);
                    },
                  );
                }).toList(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 30),
                        child: AnimatedSmoothIndicator(
                          activeIndex: _currentIndex,
                          count: state.carouselImages.length,
                          effect: const WormEffect(
                            dotColor: YouScribeColors.superLightGray,
                            radius: 32,
                            activeDotColor: YouScribeColors.whiteColor,
                            spacing: 6,
                            dotHeight: 7,
                            dotWidth: 7,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            YouScribeColors.whiteColor),
                                    onPressed: () async {
                                      if (_currentIndex == 0) {
                                        await GoRouter.of(context)
                                            .pushNamed(Routes.signIn);
                                        return;
                                      }
                                      // I Already have an account
                                      await _carouselController.previousPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.linear);
                                    },
                                    child: Text(
                                      _currentIndex == 0
                                          ? AppLocalizations.of(context)!
                                              .iAlreadyHaveAnAccount
                                          : AppLocalizations.of(context)!
                                              .previous,
                                      style: WidgetStyles.caption1TextStyle
                                          .copyWith(
                                              color:
                                                  YouScribeColors.accentColor),
                                    )),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            YouScribeColors.accentColor),
                                    onPressed: () async {
                                      if (_currentIndex == 3) {
                                        await _registerUser();
                                      }
                                      await _carouselController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.linear);
                                    },
                                    child: Text(
                                      _currentIndex < 3
                                          ? AppLocalizations.of(context)!.next
                                          : localSettings
                                                          .countryConfiguration !=
                                                      null &&
                                                  localSettings
                                                          .countryConfiguration!
                                                          .countryCode !=
                                                      'fr' &&
                                                  Platform.isAndroid
                                              ? AppLocalizations.of(context)!
                                                  .iSubscribe
                                              : AppLocalizations.of(context)!
                                                  .register,
                                      style: WidgetStyles.caption1TextStyle
                                          .copyWith(
                                              color:
                                                  YouScribeColors.whiteColor),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      );
    });
  }
}
