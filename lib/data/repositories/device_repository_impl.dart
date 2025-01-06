import 'dart:async';

import 'package:youscribe/core/models/requests/account_device_local_model.dart';
import 'package:youscribe/core/repositories/device_repository.dart';
import 'package:youscribe/data/data_sources/device_data_sources/device_remote_data_source.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  DeviceRepositoryImpl({
    required DeviceRemoteDataSource deviceDataSource,
  }) : _deviceDataSource = deviceDataSource;

  final DeviceRemoteDataSource _deviceDataSource;
  @override
  Future<void> createOrUpdateDeviceAsync(
      LocalDeviceTypeName deviceTypeName,
      String deviceId,
      String os,
      String osVersion,
      String label,
      String modelName,
      bool isFirstTimeInstalled) {
    return _deviceDataSource.createOrUpdateDeviceAsync(deviceTypeName, deviceId,
        os, osVersion, label, modelName, isFirstTimeInstalled);
  }

  @override
  FutureOr<List<AccountDeviceLocalModel>> getDevices() {
    return _deviceDataSource.getDevices();
  }
}
