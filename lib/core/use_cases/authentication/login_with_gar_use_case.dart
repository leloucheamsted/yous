import 'package:flutter/widgets.dart';
import 'package:oauth_webauth/oauth_webauth.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/app_settings.dart';
import 'package:youscribe/core/entities/current_user_account_entity.dart';
import 'package:youscribe/core/models/responses/mobile_account_model.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';

class LoginWithGARUseCase
    extends AsyncUseCase<BuildContext, CurrentUserAccountEntity> {
  LoginWithGARUseCase(UserAccountRepository userAccountRepository)
      : _userAccountRepository = userAccountRepository;

  final UserAccountRepository _userAccountRepository;

  @override
  FutureOrResult<CurrentUserAccountEntity> execute(BuildContext? params) async {
    try {
      final appSettings = locator<AppSettings>();
      final userSettings = await _userAccountRepository.getUserSettings();
      final garSSOUrl = userSettings.countryConfiguration?.garAuthRedirectUrl ??
          appSettings.garSSOAuthUrl;

      await OAuthWebAuth.instance.clearAll();
      final result = await BaseWebScreen.start(
        context: params!,
        configuration: BaseConfiguration(
          initialUrl: garSSOUrl,
          redirectUrls: ['youscribe://'],
          onCertificateValidate: (certificate) {
            return true;
          },
          refreshBtnVisible: false,
          clearCacheBtnVisible: false,
          goBackBtnVisible: false,
          goForwardBtnVisible: false,
        ),
      );

      if (result is! String) {
        throw const ClientException('Invalid result type');
      }

      final queryParameters = result.split('&');
      final currentUser = MobileAccountModel(
          token: queryParameters
              .firstWhere((element) => element.contains('access_token'))
              .split('=')[1],
          id: int.parse(queryParameters
              .firstWhere((element) => element.contains('account_id'))
              .split('=')[1]),
          isSubscriber: queryParameters
                  .firstWhere((element) => element.contains('is_subscriber'))
                  .split('=')[1] ==
              'True',
          cobranding: queryParameters
              .firstWhere((element) => element.contains('cobranding'))
              .split('=')[1],
          email: queryParameters
              .firstWhere((element) => element.contains('email'))
              .split('=')[1]
              .replaceAll("%40", '@'),
          trackingId: queryParameters
              .firstWhere((element) => element.contains('tracking_id'))
              .split('=')[1]);

      return Ok(CurrentUserAccountEntity.fromMobileAccount(currentUser));
    } catch (e) {
      if (e is AppException) {
        return Err(e);
      } else {
        return Err(ClientException(e.toString()));
      }
    }
  }
}
