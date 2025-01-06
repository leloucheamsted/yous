import 'package:flutter/material.dart';
import 'package:youscribe/core/entities/product_entity.dart';
import 'package:youscribe/core/use_cases/downloads/download_product_usecase.dart';
import 'package:youscribe/presentation/screens/products/widgets/base_product_widget.dart';
import 'package:youscribe/presentation/screens/products/widgets/download_progress_indicator.dart';
import 'package:youscribe/presentation/screens/products/widgets/simple_product_view.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

// ignore: must_be_immutable
class ProductView extends StatefulWidget with BaseProductWidget {
  ProductView(
      {required this.productId,
      required this.productImageUrl,
      required this.height,
      required this.width,
      required this.productType,
      required this.onProductSelected,
      required this.downloadProgressStream,
      this.isPremium = false,
      super.key,
      this.imgBorderRadius,
      this.floatingWidgetSize});

  final int productId;
  final String productImageUrl;
  final double height;
  final double width;
  final ProductType productType;
  final bool isPremium;
  Future<void> Function(int productId) onProductSelected;
  Stream<DownloadProgressWithStatus> downloadProgressStream;
  final BorderRadius? imgBorderRadius;
  final double? floatingWidgetSize;
  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  int _percentage = 0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.imgBorderRadius ?? BorderRadius.circular(0),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: Stack(children: [
          SimpleProductView(
              productId: widget.productId,
              productImageUrl: widget.productImageUrl,
              height: widget.height,
              width: widget.width,
              isPremium: widget.isPremium,
              floatingWidgetSize: widget.floatingWidgetSize,
              imgBorderRadius: widget.imgBorderRadius,
              productType: widget.productType,
              onProductSelected: widget.onProductSelected),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => widget.onProductSelected(widget.productId),
              child: StreamBuilder(
                  stream: widget.downloadProgressStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final progressData = snapshot.data!;
                      if (progressData.downloadProgress.productId ==
                          widget.productId) {
                        _percentage =
                            progressData.downloadProgress.progress.toInt();
                      }
                    }
                    return DownloadProgressIndicator(
                        percentage: _percentage,
                        indicatorColor: YouScribeColors.accentColor,
                        size: 35);
                  }),
            ),
          )
        ]),
      ),
    );
  }
}
