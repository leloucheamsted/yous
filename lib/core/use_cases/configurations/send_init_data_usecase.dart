import 'dart:async';

import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/core/repositories/user_account_repository.dart';

class SendInitDataUseCase
    extends AsyncUseCase<SendInitDataUseCaseParameters, void> {
  SendInitDataUseCase(this._userAccountRepository);

  final UserAccountRepository _userAccountRepository;

  @override
  FutureOr<void> onStart(SendInitDataUseCaseParameters? params) {
    if (params == null) {
      throw Exception('You must provide a DownloadProductParameters');
    }
  }

  @override
  FutureOrResult<void> execute(SendInitDataUseCaseParameters? params) async {
    await _userAccountRepository.sendUserInitializationInfoToAPI(
        params!.countryCode, 
        params.firebaseToken,
        params.languageCode,
        params.deviceIdentifier);

    return const Ok(null);
  }
}

class SendInitDataUseCaseParameters {
  SendInitDataUseCaseParameters({
    required this.firebaseToken,
    required this.languageCode,
    required this.countryCode,
    this.deviceIdentifier = '',
  });

  final String firebaseToken;
  final String languageCode;
  final String countryCode;
  final String deviceIdentifier;
}
