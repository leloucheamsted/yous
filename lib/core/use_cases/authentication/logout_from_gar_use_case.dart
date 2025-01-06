import 'package:dio/dio.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/app_settings.dart';
import 'package:youscribe/core/entities/current_user_account_entity.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';

class LogoutFromGARUseCase
    extends AsyncUseCase<CurrentUserAccountEntity, void> {
  LogoutFromGARUseCase(UserAccountRepository userAccountRepository)
      : _userAccountRepository = userAccountRepository;

  final UserAccountRepository _userAccountRepository;

  @override
  FutureOrResult<void> execute(CurrentUserAccountEntity? params) async {
    try {
      final appSettings = locator<AppSettings>();
      final userSettings = await _userAccountRepository.getUserSettings();
      final garSSOUrl = userSettings.countryConfiguration?.garLogoutUrl ??
          appSettings.logoutGarUrl;

      final url = garSSOUrl.replaceAll('userId', params?.id.toString() ?? '');

      // final result = await FlutterWebAuth2.authenticate(
      //   url: url,
      //   callbackUrlScheme: 'youscribe',
      //   options: const FlutterWebAuth2Options(
      //     preferEphemeral: true,
      //     intentFlags: ephemeralIntentFlags,
      //   ),
      // );

      // print(result);

      // return const Ok(null);

      final dio = Dio();
      // ignore: inference_failure_on_function_invocation
      final req = await dio.post(url);
      // ignore: avoid_dynamic_calls
      if (req.data['status'] == 'success') {
        return const Ok(null);
      }
      throw const ServerException('Failed to logout from GAR');
    } catch (e) {
      if (e is AppException) {
        return Err(e);
      } else {
        return Err(ClientException(e.toString()));
      }
    }
  }
}
