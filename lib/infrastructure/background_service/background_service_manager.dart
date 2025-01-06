import 'package:get_it/get_it.dart';
import 'package:workmanager/workmanager.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/app_settings.dart';
import 'package:youscribe/config/flavors.dart';
import 'package:youscribe/core/use_cases/downloads/post_download_use_case.dart';
import 'package:youscribe/core/use_cases/products/unzip_epub_use_case.dart';
import 'package:youscribe/core/use_cases/products/unzip_mp3_use_case.dart';
import 'package:youscribe/data/data_locator_helper.dart';
import 'package:youscribe/infrastructure/background_service/background_service_impl.dart';
import 'package:youscribe/infrastructure/background_service/service_name.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

@pragma('vm:entry-point')
Future<void> callbackDispatcher() async {
  Workmanager().executeTask((taskName, inputData) async {
    final locator = GetIt.instance;
    await configureApp(F.appFlavor ?? Flavor.youscribedev, locator);
    await locator.setupDatabase();
    await Logger.init(
      LoggerConfig(
        sentryDsn: locator.get<AppSettings>().telemetryKey,
        environment: F.environment,
        clearLogIntervalMs:
            locator.get<AppSettings>().logIntervalInMiliSeconds.toInt(),
      ),
    );
    switch (taskName) {
      case ServiceName.unzip:
        await PostDownloadUseCase(
          unzipEpubUseCase: UnzipEpubUseCase(),
          unzipMp3UseCase: UnzipMp3UseCase(),
        )(
          PostDownloadUseCaseParameters(
            inputData!['productId'] as int,
            inputData['password'].toString(),
            inputData['filePath'].toString(),
            inputData['productExtension'].toString(),
          ),
        );
      case ServiceName.setupBackgroundActions:
        await BackgroundServiceImpl(locator).launchBackgroundSyncs();
      case ServiceName.syncBookListsActions:
        await BackgroundServiceImpl(locator).syncProductList();
    }
    return Future.value(true);
  });
}
