import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

abstract class BackgroundService extends BaseRepository
    with Debuggable, Loggable {
  @override
  String get debugName => 'BackgroundService';

  Future<void> launchBackgroundSyncs();

  Future<void> syncReadingStats();
  Future<void> syncBookmarks();
  Future<void> cleanBookDirectory(int userId);
  Future<void> syncFavoriteProducts();
  Future<void> syncLastReadProducts();
  Future<void> syncOfflineProducts();
  Future<void> syncConfigurations();
  Future<void> checkIfUserIsSubscribedOnServers();
  Future<void> saveUserSelections();
  Future<void> syncProductList();
}
