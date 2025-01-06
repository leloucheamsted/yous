import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:youscribe/config/router/routes.dart';
import 'package:youscribe/core/extensions/build_context_extension.dart';
import 'package:youscribe/presentation/blocs/author/author_bloc.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/screens/products/widgets/product_info_view.dart';
import 'package:youscribe/presentation/screens/products/widgets/simple_product_view.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class AuthorScreen extends StatefulWidget {
  const AuthorScreen(
      {required this.authorId, required this.authorName, super.key});
  final int authorId;
  final String authorName;
  @override
  State<AuthorScreen> createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> {
  late final ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();

    _scrollViewController = ScrollController(initialScrollOffset: 5)
      ..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollViewController.offset >=
            _scrollViewController.position.maxScrollExtent &&
        !_scrollViewController.position.outOfRange) {
      context.read<AuthorBloc>().add(const LoadNewPageEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<AuthorBloc, AuthorState>(builder: (context, state) {
      final bloc = context.read<AuthorBloc>();

      if (state is AuthorErrorState) {
        if (state.errorType == ErrorType.serverError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Dialogs.displayGeneralAPIErrorAlert(context: context);
          });
        } else if (state.errorType == ErrorType.noInternet) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Dialogs.displayInternetNeededAlert(context: context);
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.showErrorSnackBar(
                  AppLocalizations.of(context)!.errorOccuredGeneralTitle);
          });
        }
        bloc.add(const ErrorDisplayedEvent());
        state = state.previousState;
      }

      if (state is AuthorInitialState) {
        return _loadInitView();
      }
      final loadedState = state as AuthorStateLoadedState;
      if (loadedState.isBusy) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(
              duration: const Duration(seconds: 1),
              backgroundColor: YouScribeColors.accentColor,
              content: Text(AppLocalizations.of(context)!.done)));
        });
      }
      return Stack(children: [
        DecoratedBox(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.1,
              1,
            ],
            colors: [
              YouScribeColors.primaryAppColor,
              YouScribeColors.accentColor,
            ],
          )),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollViewController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          widget.authorName,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: YouScribeColors.whiteColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          AppLocalizations.of(context)!.publications,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: YouScribeColors.whiteColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 20,
                          runSpacing: -10,
                          children: [
                            ...List.generate(loadedState.products.length,
                                (index) {
                              final product = loadedState.products[index];
                              return SizedBox(
                                  height: 250,
                                  width:
                                      (MediaQuery.of(context).size.width / 2) -
                                          19,
                                  child: ProductInfoView(
                                    title: product.title!,
                                    author: product.author!,
                                    titleTextAlign: TextAlign.center,
                                    titleFontWeight: FontWeight.w700,
                                    titleSize: 14,
                                    titleColor: YouScribeColors.whiteColor,
                                    productWidget: SimpleProductView(
                                      productId: product.id!,
                                      productImageUrl: product.imageUrl!,
                                      height: 200,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      floatingWidgetSize: 30,
                                      imgBorderRadius: BorderRadius.circular(5),
                                      productType: product.productType,
                                      onProductSelected: (val) async {
                                        await context.pushNamed(
                                            Routes.productDetails,
                                            queryParameters: {
                                              Routes.productIdParamName:
                                                  val.toString()
                                            });
                                      },
                                    ),
                                  ));
                            })
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
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
                            AppLocalizations.of(context)!.done,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: YouScribeColors.whiteColor,
                                    fontWeight: FontWeight.w800),
                          )),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            context.read<AuthorBloc>().add(const FollowEvent());
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
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
                            !loadedState.isFollowing
                                ? AppLocalizations.of(context)!.follow
                                : AppLocalizations.of(context)!.unfollow,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: YouScribeColors.whiteColor,
                                    fontWeight: FontWeight.w800),
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        SizedBox(
          child: loadedState.isBusy
              ? const Center(
                  child: CircularProgressIndicator(
                    color: YouScribeColors.whiteColor,
                  ),
                )
              : null,
        ),
      ]);
    }));
  }

  Widget _loadInitView() {
    return const Stack(children: [
      DecoratedBox(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
            0.1,
            1,
          ],
          colors: [
            YouScribeColors.primaryAppColor,
            YouScribeColors.accentColor,
          ],
        )),
        child: Center(
          child: CircularProgressIndicator(
            color: YouScribeColors.whiteColor,
          ),
        ),
      )
    ]);
  }
}
