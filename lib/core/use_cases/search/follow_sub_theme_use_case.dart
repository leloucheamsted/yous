import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class FollowSubthemeUseCase
    extends AsyncUseCase<FollowSubthemeUseCaseParams, bool>
    with Debuggable, Loggable {
  final UserAccountRepository _userAccRepository = locator();

  @override
  String get debugName => 'FollowSubthemeUseCase';

  @override
  FutureOrResult<bool> execute(FollowSubthemeUseCaseParams? params) async {
    try {
      if (params!.shouldFollow) {
        await _userAccRepository.followSubTheme(
            params.themeId, params.categoryId);
      } else {
        await _userAccRepository.unFollowSubTheme(
            params.themeId, params.categoryId);
      }

      return const Ok(true);
    } on APIRequestException catch (e) {
      logError("API Error while following subtheme in search.", error: e);
      return Err(e);
    } catch (e) {
      logError("Error while following subtheme in search.",
          error: e as Exception);
      rethrow;
    }
  }
}

class FollowSubthemeUseCaseParams {
  FollowSubthemeUseCaseParams(
      {required this.categoryId,
      required this.shouldFollow,
      required this.themeId});
  final int categoryId;
  final int themeId;
  final bool shouldFollow;
}
