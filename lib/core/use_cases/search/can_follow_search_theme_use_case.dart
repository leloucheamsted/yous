import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class CanFollowSearchThemeUseCase extends AsyncUseCase<
    CanFollowSearchThemeUseCaseParams,
    CanFollowSearchThemeUseCaseResult> with Debuggable, Loggable {
  final UserAccountRepository _userAccRepository = locator();

  @override
  String get debugName => 'CanFollowSearchThemeUseCase';

  @override
  FutureOrResult<CanFollowSearchThemeUseCaseResult> execute(
      CanFollowSearchThemeUseCaseParams? params) async {
    try {
      final currentUser = await AuthenticationManager.getCurrentUser();
      if (params!.themeId != null &&
          params.themeId != 0 &&
          params.categoryId != null &&
          params.categoryId != 0 &&
          currentUser!.isYSClassificationSettings) {
        final result = await _userAccRepository.isSubThemeFollowed(
            params.themeId ?? 0, params.categoryId ?? 0);
        return Ok(CanFollowSearchThemeUseCaseResult(
            canFollow: true, isFollowed: result));
      }

      return Ok(CanFollowSearchThemeUseCaseResult(
          canFollow: false, isFollowed: false));
    } on APIRequestException catch (e) {
      logError("API Error while searching products.", error: e);
      return Err(e);
    } catch (e) {
      logError("Error while searching products.", error: e as Exception);
      rethrow;
    }
  }
}

class CanFollowSearchThemeUseCaseParams {
  CanFollowSearchThemeUseCaseParams(
      {required this.themeId, required this.categoryId});

  final int? themeId;
  final int? categoryId;
}

class CanFollowSearchThemeUseCaseResult {
  CanFollowSearchThemeUseCaseResult(
      {required this.canFollow, required this.isFollowed});

  final bool canFollow;
  final bool isFollowed;
}
