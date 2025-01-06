import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/flavors.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/repositories/country_config_repository.dart';
import 'package:youscribe/core/repositories/document_repository.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class LoadingInitUseCase extends AsyncUseCase<void, bool>
    with Debuggable, Loggable {
  final CountryConfigRepository _countryConfigRepository =
      locator<CountryConfigRepository>();
  final ConnectivityService _connectivityService =
      locator<ConnectivityService>();
  final DocumentRepository _documentRepository = locator<DocumentRepository>();

  @override
  String get debugName => "LoadingInitUseCase";

  @override
  FutureOrResult<bool> execute(void params) async {
    try {
      logInfo("App loading...");
      if (await _connectivityService.isInternetAvailable) {
        await _countryConfigRepository.getCountryConfiguration();

        if (currentFlavor == Flavor.youscribedev) {
          await _countryConfigRepository.getCanalplusConfig();
        }
      }

      await _documentRepository.deleteAllDownloadProgress();

      return const Ok(true);
    } catch (e) {
      if (e is AppException) {
        return Err(e);
      } else {
        return Err(ClientException(e.toString()));
      }
    }
  }
}
