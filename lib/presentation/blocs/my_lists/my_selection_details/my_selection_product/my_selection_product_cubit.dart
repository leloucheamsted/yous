import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/my_selection_product_entity.dart';
import 'package:youscribe/core/use_cases/my_selections/remove_product_from_selection_use_case.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'my_selection_product_state.dart';

class MySelectionProductCubit extends Cubit<MySelectionProductState>
    with Debuggable, Loggable {
  MySelectionProductCubit(this.selectionItem)
      : super(MySelectionProductStateInitial());

  final RemoveProductFromSelectionUseCase _removeProductFromSelectionUseCase =
      locator();

  final MySelectionProductEntity selectionItem;

  @override
  String get debugName => 'MySelectionProductCubit';

  Future<bool> onRemoveProduct(int selectionId) async {
    final RemoveProductFromSelectionParameters params =
        RemoveProductFromSelectionParameters(
            selectionItem.product!.id!, selectionId);
    final result = await _removeProductFromSelectionUseCase(params);
    result.fold((value) {
      return true;
    }, (error) {
      logError(
          // ignore: lines_longer_than_80_chars
          "Error while removing product from my selections. SelectionId: $selectionId, ProductId: {product.Product.Id}",
          error: Exception(error));
      return false;
    });

    return true;
  }
}
