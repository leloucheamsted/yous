import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:youscribe/core/extensions/build_context_extension.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe/presentation/blocs/my_lists/my_selection_details/my_selection_details_bloc.dart';
import 'package:youscribe/presentation/blocs/my_lists/my_selection_details/my_selection_product/my_selection_product_cubit.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/screens/my_lists/selections/widgets/my_selection_product_item.dart';
import 'package:youscribe/presentation/screens/products/widgets/light_product_list_skeleton_loader.dart';
import 'package:youscribe/presentation/screens/shared/empty_view.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/styles/youscribe_theme.dart';

class MySelectionDetailsScreen extends StatefulWidget {
  const MySelectionDetailsScreen(
      {required this.selectionId, required this.selectionnTitle, super.key});
  final int selectionId;
  final String selectionnTitle;

  @override
  State<MySelectionDetailsScreen> createState() =>
      _MySelectionDetailsScreenState();
}

class _MySelectionDetailsScreenState extends State<MySelectionDetailsScreen> {
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
      context.read<MySelectionDetailsBloc>().add(const LoadNewPageEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0.5,
        title: Image(
            height: 35,
            image: AssetImage(Provider.of<YouScribeTheme>(context).brand)),
      ),
      body: BlocBuilder<MySelectionDetailsBloc, MySelectionDetailsState>(
          builder: (context, state) {
        final bloc = context.read<MySelectionDetailsBloc>();

        if (state is MySelectionDetailsErrorState) {
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
        if (state is InitMySelectionDetails) {
          return const LightProductListSkeletonLoader();
        }
        if (state is MySelectionDetailsEmptyState) {
          return EmptyView(
            message: widget.selectionnTitle,
          );
        }

        final loadedState = state as MySelectionDetailsLoadedState;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: SingleChildScrollView(
            controller: _scrollViewController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.selectionnTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: YouScribeColors.accentColor,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                ...List.generate(loadedState.products.length, (index) {
                  final myproductListItemCubit =
                      MySelectionProductCubit(loadedState.products[index]);

                  return BlocProvider.value(
                    value: myproductListItemCubit,
                    child: MySelectionProductItem(
                      cubit: myproductListItemCubit,
                      selectionId: widget.selectionId,
                    ),
                  );
                })
              ],
            ),
          ),
        );
      }),
    );
  }
}
