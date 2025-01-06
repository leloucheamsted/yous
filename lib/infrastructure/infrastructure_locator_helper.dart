import 'package:get_it/get_it.dart';
import 'package:youscribe/core/infrastructure/connectivity_service.dart';
import 'package:youscribe/core/infrastructure/file_service.dart';
import 'package:youscribe/core/infrastructure/in_app_purchase_service.dart';
import 'package:youscribe/core/infrastructure/service.dart';
import 'package:youscribe/infrastructure/connectivity_service/connectivity_service_impl.dart';
import 'package:youscribe/infrastructure/file_access/file_service_impl.dart';
import 'package:youscribe/infrastructure/service/billing_service.dart';
import 'package:youscribe/infrastructure/service/in_app_purchase_impl.dart';
import 'package:youscribe/infrastructure/service/service_impl.dart';

extension InfrastructureLocatorHelper on GetIt {
  void registerInfrastructureServices() {
    registerLazySingleton<FileService>(FileServiceImpl.new);
    registerLazySingleton<ConnectivityService>(ConnectivityServiceImpl.new);
    registerLazySingleton<Service>(ServiceImpl.new);
    registerLazySingleton<InAppPurchaseService>(InAppPurchaseServiceImpl.new);
    registerLazySingleton<BillingService>(BillingService.new);
  }
}
