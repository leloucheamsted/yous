import 'package:youscribe/core/entities/current_user_account_entity.dart';
import 'package:youscribe/core/entities/simple_library_entity.dart';

abstract class UserAccountLocalDataSource {
  Future<CurrentUserAccountEntity?> retrieve();
  Future<void> save(CurrentUserAccountEntity currentUserAccount);
  Future<void> delete();
  Future<void> saveFirebaseToken(String firebaseToken);
  Future<void> saveAuthToken(String authToken);
  Future<String?> getFirebaseToken();
  Future<bool> userExists();
  Future<List<SimpleLibraryEntity>?> retrieveUserSelections();
  Future<void> saveUserSelections(List<SimpleLibraryEntity> selections);
}
