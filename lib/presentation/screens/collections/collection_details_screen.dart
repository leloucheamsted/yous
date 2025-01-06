import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/extensions/build_context_extension.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe/presentation/blocs/collection/collection_bloc.dart';
import 'package:youscribe/presentation/screens/collections/widgets/collection_product_item_view.dart';
import 'package:youscribe/presentation/screens/collections/widgets/collection_view_skeleton.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/styles/youscribe_theme.dart';

class CollectionDetailsScreen extends StatefulWidget {
  const CollectionDetailsScreen(
      {required this.collectionId, required this.collectionTitle, super.key});
  final int collectionId;
  final String collectionTitle;
  @override
  State<CollectionDetailsScreen> createState() =>
      _CollectionDetailsScreenState();
}

class _CollectionDetailsScreenState extends State<CollectionDetailsScreen> {
  bool isLoading = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController(initialScrollOffset: 5)
      ..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      context
          .read<CollectionDetailsBloc>()
          .add(LoadNewPageEvent(widget.collectionId, widget.collectionTitle));
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
        body: BlocBuilder<CollectionDetailsBloc, CollectionState>(
            builder: (context, state) {
          if (state is CollectionErrorState) {
            //TODO: Handle error better.
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
          }
          if (state is CollectionInitialState) {
            return const Center(
              child: Center(child: CollectionViewSkeleton()),
            );
          }
          final loadedState = state as CollectionLoadedState;
          return Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loadedState.collectionTitle!,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        overflow: TextOverflow.clip,
                        fontWeight: FontWeight.w600,
                        color: YouScribeColors.accentColor),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.count(
                      controller: _scrollController,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 2,
                      childAspectRatio: 0.96,
                      crossAxisCount: 2,
                      primary: false,
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: loadedState.products.map((value) {
                        final product = value as ProductEntity;
                        return CollectionItemView(product: product);
                      }).toList(),
                    ),
                  ),
                ],
              ));
        }));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
