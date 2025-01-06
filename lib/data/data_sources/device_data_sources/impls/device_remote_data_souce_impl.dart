import 'dart:async';

import 'package:youscribe/core/models/requests/account_device_local_model.dart';
import 'package:youscribe/data/data_sources/base_remote_data_source.dart';
import 'package:youscribe/data/data_sources/device_data_sources/device_remote_data_source.dart';

class DeviceRemoteDataSourceImpl extends BaseRemoteDataSource
    implements DeviceRemoteDataSource {
  DeviceRemoteDataSourceImpl({required super.dio, required super.appSettings});

  @override
  Future<void> createOrUpdateDeviceAsync(
      LocalDeviceTypeName deviceTypeName,
      String deviceId,
      String os,
      String osVersion,
      String label,
      String modelName,
      bool isFirstTimeInstalled) async {
    final url = "${appSettings.mainYSAPIUrl}/api/v1/accounts/devices";
    final body = {
      'Os': os,
      'OsVersion': osVersion,
      'DeviceId': deviceId,
      'DeviceTypeName': deviceTypeName.toString(),
      'Label': label,
      'ModelName': modelName,
      'FirstLaunchEver': isFirstTimeInstalled
    };
    await put(url, body);
  }

  @override
  FutureOr<List<AccountDeviceLocalModel>> getDevices() async {
    final url = "${appSettings.mainYSAPIUrl}/api/v1/accounts/devices";
    final response = await get(url);
    if (response.data == null) {
      return [];
    }
    final responseDynamic = response.data as List<dynamic>;
    final List<AccountDeviceLocalModel> result = responseDynamic
        .map((e) => AccountDeviceLocalModel.fromJson(e as Map<String, Object>))
        .toList();

    return result;
  }
}
