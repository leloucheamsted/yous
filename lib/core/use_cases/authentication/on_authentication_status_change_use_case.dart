import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/authentication/authentication_status.dart';

class OnAuthenticationStatusChangeUseCase
    extends AsyncUseCase<AuthenticationStatus, void> {
  OnAuthenticationStatusChangeUseCase();

  @override
  FutureOrResult<void> execute(AuthenticationStatus? params) {
    //
    return const Ok(null);
  }
}
