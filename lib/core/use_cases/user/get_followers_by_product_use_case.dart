import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/product_follow_output_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class GetFollowersByProductUseCase
    extends AsyncUseCase<int, ProductFollowOutputEntity>
    with Debuggable, Loggable {
  GetFollowersByProductUseCase(UserAccountRepository userAccountRepository)
      : _userAccountRepository = userAccountRepository;

  final UserAccountRepository _userAccountRepository;

  @override
  String get debugName => 'GetFollowersByProductUseCase';

  @override
  // ignore: avoid_renaming_method_parameters
  FutureOrResult<ProductFollowOutputEntity> execute(int? productId) async {
    try {
      final followers =
          await _userAccountRepository.getFolowedByProduct(productId!);
      return Ok(followers);
    } on APIRequestException catch (e) {
      logError('Error getting Follow items for product $productId: $e',
          error: Exception(e));
      return Err(e);
    } catch (e) {
      logError('Error getting Follow items for product $productId: $e',
          error: Exception(e));
      rethrow;
    }
  }
}
