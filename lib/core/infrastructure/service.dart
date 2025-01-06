import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:youscribe_analytics/youscribe_analytics.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

abstract class Service extends BaseRepository
    with Debuggable, Loggable, Trackable {
  @override
  String get debugName => 'AppService';

  void showErrorMessageAndRequestReport(
      {required String title,
      required String message,
      required String supportEmailHeader});
  Future<bool> requestAppRating(bool byPassOpenCount);
}
