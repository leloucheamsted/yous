import 'dart:io';

import 'package:youscribe/core/infrastructure/connectivity_service.dart';

class ConnectivityServiceImpl implements ConnectivityService {
  //TODO: Change the way internet connection is checked.
  //This method is too slow.
  @override
  Future<bool> get isInternetAvailable async {
    try {
      //TODO: is Google.com not better ?
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    } catch (e) {
      return true;
    }
  }
}
