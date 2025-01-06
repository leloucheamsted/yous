import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyatt_bloc_helper/wyatt_bloc_helper.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/repositories/products_repository.dart';
import 'package:youscribe/presentation/widgets/custom_path_icon.dart';
import 'package:youscribe/presentation/widgets/font_awesome_text_icon.dart';
import 'package:youscribe/styles/font_awesome_icons.dart';
import 'package:youscribe/styles/path_icons.dart';

sealed class ProductOfflineButtonState extends Equatable {
  const ProductOfflineButtonState();

  @override
  List<Object> get props => [];
}

class ProductOfflineButtonInitial extends ProductOfflineButtonState {
  const ProductOfflineButtonInitial();
}

class ProductOfflineButtonLoading extends ProductOfflineButtonState {
  const ProductOfflineButtonLoading();
}

class ProductOfflineButtonError extends ProductOfflineButtonState {
  const ProductOfflineButtonError();
}

class ProductOfflineButtonSuccess extends ProductOfflineButtonState {
  const ProductOfflineButtonSuccess({
    required this.productIsOffline,
    required this.productDownloaded,
    required this.productNeedSync,
    required this.productCannotBeDownloaded,
  });

  /// The product is downloadable, which means the product is flagged as offline
  /// on the user's account
  final bool productIsOffline;

  /// The product is downloaded, and can be played offline
  final bool productDownloaded;

  /// The product is not downloaded, but can be downloaded
  final bool productNeedSync;

  /// The product is not downloaded, and cannot be downloaded because of the
  /// user's rights
  final bool productCannotBeDownloaded;

  /// The product can be downloaded
  bool get productCanBeDownloaded => !productCannotBeDownloaded;

  @override
  List<Object> get props => [
        productIsOffline,
        productDownloaded,
        productNeedSync,
        productCannotBeDownloaded,
      ];
}

class ProductOfflineButtonCubit extends Cubit<ProductOfflineButtonState> {
  ProductOfflineButtonCubit({
    required this.productRepository,
  }) : super(const ProductOfflineButtonInitial());

  factory ProductOfflineButtonCubit.create() {
    return ProductOfflineButtonCubit(
      productRepository: locator<ProductRepository>(),
    );
  }

  final ProductRepository productRepository;

  FutureOr<void> checkProductOfflineState(ProductEntity product,
      {bool refresh = false}) async {
    if (!refresh) {
      emit(const ProductOfflineButtonLoading());
    }

    final productId = product.id;

    if (productId == null) {
      emit(const ProductOfflineButtonError());
      return;
    }

    // Check if the product is offline
    final productIsOffline = product.isOffline ?? false;

    // Check if the product need to be downloaded
    final productNeedSync = !(product.isFileAvailable ?? false);

    // Check if the product is downloaded
    final productDownloaded = productIsOffline && !productNeedSync;

    // Check if the product cannot be downloaded
    final isAudio = product.productType == ProductType.audioBook ||
        product.productType == ProductType.podcast ||
        product.productType == ProductType.partition;

    try {
      if (isAudio) {
        final audioInfo =
            await productRepository.getAudioBookInfoFromStreamingAPI(productId);

        final isPremium = product.isPremium ?? false;
        final isExtract = audioInfo.isExtract ?? false;

        if (isPremium && isExtract) {
          emit(const ProductOfflineButtonSuccess(
            productIsOffline: false,
            productDownloaded: false,
            productNeedSync: false,
            productCannotBeDownloaded: true,
          ));
          return;
        }
      }
    } catch (_) {
      // On error, we consider the product as not downloadable to avoid
      // any issue with the user's rights
    } finally {
      emit(ProductOfflineButtonSuccess(
        productIsOffline: productIsOffline,
        productDownloaded: productDownloaded,
        productNeedSync: productNeedSync,
        productCannotBeDownloaded: false,
      ));
    }
  }
}

class ProductOfflineButton<T extends StateStreamable<S>, S>
    extends CubitScreen<ProductOfflineButtonCubit, ProductOfflineButtonState> {
  const ProductOfflineButton({
    required this.product,
    required this.loading,
    required this.rebuildWhen,
    required this.colors,
    this.onDownloadPressed,
    this.onSyncPressed,
    this.showSync = false,
    this.minimalist = false,
    super.key,
  });

  final ProductEntity product;
  final bool loading;

  final bool showSync;
  final bool minimalist;

  final FutureOr<void> Function(ProductOfflineButtonSuccess state)?
      onDownloadPressed;
  final FutureOr<void> Function(ProductOfflineButtonSuccess state)?
      onSyncPressed;

  final bool Function(S state) rebuildWhen;

  final (Color, Color) colors;

  @override
  ProductOfflineButtonCubit create(BuildContext context) =>
      ProductOfflineButtonCubit.create();

  @override
  ProductOfflineButtonCubit init(
          BuildContext context, ProductOfflineButtonCubit bloc) =>
      bloc..checkProductOfflineState(product);

  @override
  Widget onBuild(BuildContext context, ProductOfflineButtonState state) {
    return BlocListener<T, S>(
      listener: (context, testState) {
        if (rebuildWhen(testState)) {
          bloc(context).checkProductOfflineState(product, refresh: true);
        }
      },
      child: switch (state) {
        ProductOfflineButtonInitial() ||
        ProductOfflineButtonLoading() ||
        ProductOfflineButtonError() =>
          const SizedBox.shrink(),
        final ProductOfflineButtonSuccess productOfflineButtonSuccess => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (productOfflineButtonSuccess.productCanBeDownloaded ||
                  productOfflineButtonSuccess.productCannotBeDownloaded) ...[
                InkWell(
                  onTap: (onDownloadPressed != null)
                      ? () async {
                          if (!loading) {
                            await onDownloadPressed
                                ?.call(productOfflineButtonSuccess);
                          }
                        }
                      : null,
                  child: SizedBox(
                    child: productOfflineButtonSuccess.productDownloaded &&
                            !minimalist
                        ? CustomPathIcon(
                            path: PathIcons.filledFontAwesomeCloudDownloadIcon,
                            fontSize: 30,
                            color: !loading ? colors.$1 : colors.$2)
                        : FontAwesomeTextIcon(
                            font: FontIcons.fontAwesomeCloudDownload,
                            fontSize: 25,
                            color: !loading ? colors.$1 : colors.$2),
                  ),
                )
              ],
              if (productOfflineButtonSuccess.productNeedSync && showSync) ...[
                const SizedBox(width: 10),
                InkWell(
                  onTap: (onSyncPressed != null)
                      ? () async {
                          if (!loading) {
                            await onSyncPressed
                                ?.call(productOfflineButtonSuccess);
                          }
                        }
                      : null,
                  child: SizedBox(
                    child: FontAwesomeTextIcon(
                      font: FontIcons.fontAwesomeSync,
                      fontSize: 25,
                      color: !loading ? colors.$1 : colors.$2,
                    ),
                  ),
                )
              ],
            ],
          )
      },
    );
  }
}
