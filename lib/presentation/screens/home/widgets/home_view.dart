import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/editorial_entity.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/entities/selection_model.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/presentation/blocs/app/app_bloc_bloc.dart';
import 'package:youscribe/presentation/blocs/app_purchase/app_purchase_cubit.dart';
import 'package:youscribe/presentation/blocs/home/home_bloc.dart';
import 'package:youscribe/presentation/blocs/home/home_product_item/home_product_item_cubit.dart';
import 'package:youscribe/presentation/screens/home/widgets/product_list_view_item.dart';
import 'package:youscribe/presentation/screens/home/widgets/skeleton_home_loader.dart';
import 'package:youscribe/presentation/screens/shared/app_purchase_view.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/utilities/constants.dart';
import 'package:youscribe/utilities/youscribe_premium.dart';

// ignore: must_be_immutable
class HomeView extends StatefulWidget {
  HomeView({
    required this.editorials,
    required this.scrollController,
    required this.selections,
    required this.suggestions,
    required this.onEditorialSelected,
    required this.onSelectionSelected,
    required this.onsuggestionsSelected,
    required this.purchaseSubscription,
    required this.shouldShowSubscriptionBanner,
    required this.cubit,
    super.key,
  });
  List<EditorialEntity> editorials;
  ScrollController scrollController;
  List<SelectionEntity> selections;
  List<ProductEntity> suggestions;
  AppPurchaseCubit cubit;

  final bool shouldShowSubscriptionBanner;
  void Function(EditorialEntity editorial) onEditorialSelected;
  void Function(SelectionEntity selections) onSelectionSelected;
  void Function() onsuggestionsSelected;
  void Function() purchaseSubscription;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  final CarouselController _controller = CarouselController();
  int _current = 0;
  bool _isConnect = true;
  final RefreshController _refreshController = RefreshController();
  final ConnectivityService connectivityService = locator();

  @override
  Widget build(BuildContext context) {
    checkConnectionAvailabe();
    return SmartRefresher(
      scrollController: widget.scrollController,
      controller: _refreshController,
      header: const WaterDropMaterialHeader(
        backgroundColor: YouScribeColors.primaryAppColor,
      ),
      onRefresh: () {
        final Locale myLanguage = Localizations.localeOf(context);
        context
            .read<HomeBloc>()
            .add(RefreshHomeEvent(language: myLanguage.toString()));
        _refreshController.refreshCompleted();
      },
      child: ListView(controller: widget.scrollController, children: [
        SizedBox(
            child: !Provider.of<YouScribePremium>(context).isPremium
                ? _freeTrialBannerView()
                : null),
        const SizedBox(height: 10),
        if (_isConnect) _editorView(),
        SizedBox(
          child: widget.suggestions.isEmpty ? null : _suggestionView([]),
        ),
        ...List.generate(widget.selections.length, (index) {
          return _selectionsView(widget.selections[index]);
        }),
        const SizedBox(height: 150),
      ]),
    );
  }

  Future<void> checkConnectionAvailabe() async {
    _isConnect = await connectivityService.isInternetAvailable;
  }

  Widget _freeTrialBannerView() {
    final cubit = AppPurchaseCubit();
    return SizedBox(
      height: 220,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagesName.subscribeBanner),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.freeTrialDescription,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: WidgetStyles.title2Size,
                    color: YouScribeColors.whiteColor),
              ),
              const SizedBox(height: 20),
              AppPurchasView(
                  cubit: cubit,
                  child: ElevatedButton(
                      onPressed: () {
                        widget.purchaseSubscription();
                      },
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.resolveWith(
                            (states) {
                              return states.contains(MaterialState.pressed)
                                  ? YouScribeColors.accentColor
                                  : null;
                            },
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            YouScribeColors.primaryAppColor,
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            YouScribeColors.whiteColor,
                          )),
                      child: Text(
                        AppLocalizations.of(context)!.startFreeTrial,
                      )))
            ],
          ),
        ),
      ),
    );
  }

  Widget _suggestionView(List<ProductEntity> suggestions) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: widget.onsuggestionsSelected,
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Text(AppLocalizations.of(context)!.recommendedForYou,
                          style: Theme.of(context).textTheme.bodyLarge)
                      .copyWith(
                          style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  )),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 185,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(
              parent: ClampingScrollPhysics(),
            ),
            children: [
              ...List.generate(widget.suggestions.length, (index) {
                final productListItemCubit =
                    HomeProductListItemCubit(widget.suggestions[index]);

                return BlocProvider.value(
                    value: productListItemCubit,
                    child: ProductListViewItem(
                      cubit: productListItemCubit,
                      product: widget.suggestions[index],
                    ));
              })
            ],
          ),
        ),
      ]);
    });
  }

  Widget _editorView() {
    return SizedBox(
      child: widget.editorials.isNotEmpty
          ? Column(
              children: [
                CarouselSlider.builder(
                  carouselController: _controller,
                  options: CarouselOptions(
                    scrollPhysics: const PageScrollPhysics(),
                    viewportFraction: 1,
                    height: 135,
                    disableCenter: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                  itemCount: widget.editorials.length,
                  itemBuilder: (context, itemIndex, pageViewIndex) => Padding(
                    padding: const EdgeInsets.all(4),
                    child: GestureDetector(
                      onTap: () => widget
                          .onEditorialSelected(widget.editorials[itemIndex]),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget
                                  .editorials[itemIndex].imageUrl
                                  .toString()),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 100,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                AnimatedSmoothIndicator(
                  activeIndex: _current,
                  count: widget.editorials.length,
                  effect: const WormEffect(
                    dotColor: YouScribeColors.superLightGray,
                    radius: 32,
                    activeDotColor: YouScribeColors.blackColor,
                    spacing: 6,
                    dotHeight: 7,
                    dotWidth: 7,
                  ),
                ),
              ],
            )
          : null,
    );
  }

  Widget _selectionsView(SelectionEntity selection) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: InkWell(
            onTap: () => widget.onSelectionSelected(selection),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: Text(selection.title!,
                          style: Theme.of(context).textTheme.bodyLarge)
                      .copyWith(
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis)),
                ),
                Container(
                  height: 25,
                  width: 25,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: YouScribeColors.primaryAppColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      )),
                  child: Transform.rotate(
                      angle: 100 * pi / 200,
                      child: const FontAwesomeTextIcon(
                          font: FontIcons.fontAwersoneSearchPlus,
                          fontSize: 16,
                          color: YouScribeColors.whiteColor)),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 185,
          child: selection.products.isNotEmpty
              ? ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...List.generate(selection.products.length, (index) {
                      final productListItemCubit =
                          HomeProductListItemCubit(selection.products[index]);

                      return BlocProvider.value(
                          value: productListItemCubit,
                          child: ProductListViewItem(
                            cubit: productListItemCubit,
                            product: selection.products[index],
                          ));
                    })
                  ],
                )
              : const SkeletonHorilList(),
        ),
      ]);
    });
  }
}
