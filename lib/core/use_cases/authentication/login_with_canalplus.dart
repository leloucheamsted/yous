import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/app_settings.dart';
import 'package:youscribe/core/entities/current_user_account_entity.dart';
import 'package:youscribe/core/models/responses/mobile_account_model.dart';

class LoginWithCanalPlusUseCase
    extends AsyncUseCase<NoParam, CurrentUserAccountEntity> {
  LoginWithCanalPlusUseCase();

  @override
  FutureOrResult<CurrentUserAccountEntity> execute(NoParam? params) async {
    try {
      final appSettings = locator<AppSettings>();
      final canalPLusUrl = appSettings.canalPlusAuthUrl;
      final redirectUrl = appSettings.canalPlusYsRedirectUrl;
      final url = canalPLusUrl.replaceFirst('{0}', redirectUrl);

      final result = await FlutterWebAuth2.authenticate(
        url: url,
        callbackUrlScheme: 'youscribe',
      );
      final uri = Uri.parse(result);

      //
      //

      // TODO(youscribe): move this in repo/datasource and cache account to
      // enable auth persistence

      final currentUser = MobileAccountModel(
        token: uri.queryParameters['access_token'],
        id: int.parse(uri.queryParameters['account_id']!),
        isSubscriber: uri.queryParameters['is_subscriber'] == 'true',
        cobranding: uri.queryParameters['cobranding'],
        email: uri.queryParameters['email'],
        trackingId: uri.queryParameters['tracking_id'],
      );

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
