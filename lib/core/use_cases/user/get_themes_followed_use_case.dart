import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/entities/follow_item_entity.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class GetThemesFollowedUseCase
    extends AsyncUseCase<void, List<FollowItemEntity>>
    with Debuggable, Loggable {
  GetThemesFollowedUseCase(UserAccountRepository userAccountRepository)
      : _userAccountRepository = userAccountRepository;

  final UserAccountRepository _userAccountRepository;

  @override
  String get debugName => 'GetThemesFollowedUseCase';

  @override
  // ignore: avoid_renaming_method_parameters
  FutureOrResult<List<FollowItemEntity>> execute(void params) async {
    try {
      final followers = await _userAccountRepository.getThemesFollowed();
      return Ok(followers);
    } on APIRequestException catch (e) {
      logError("Error getting editor's followed : $e", error: Exception(e));
      return Err(e);
    } catch (e) {
      logError("Error getting editor's followed : $e", error: Exception(e));
      rethrow;
    }
  }
}
