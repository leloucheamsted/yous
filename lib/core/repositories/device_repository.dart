import 'dart:async';

import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:youscribe/core/models/requests/account_device_local_model.dart';
import 'package:youscribe/data/data_sources/device_data_sources/device_remote_data_source.dart';

abstract class DeviceRepository extends BaseRepository {
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
