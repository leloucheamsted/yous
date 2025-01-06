import 'dart:async';

import 'package:youscribe/core/models/requests/account_device_local_model.dart';

abstract class DeviceRemoteDataSource {
  Future<void> createOrUpdateDeviceAsync(
      LocalDeviceTypeName deviceTypeName,
      String deviceId,
      String os,
      String osVersion,
      String label,
      String modelName,
      bool isFirstTimeInstalled);
  FutureOr<List<AccountDeviceLocalModel>> getDevices();
}

enum LocalDeviceTypeName {
  phone,
  tablet,
  tV,
  computer,
}
