import 'package:isar/isar.dart';
import 'package:youscribe/core/entities/current_user_account_entity.dart';
import 'package:youscribe/core/entities/simple_library_entity.dart';
import 'package:youscribe/data/data_sources/base_local_data_source.dart';
import 'package:youscribe/data/data_sources/user_acount_data_sources/user_account_local_data_source.dart';

class UserAccountLocalDataSourceImpl
    extends BaseLocalDataSource<CurrentUserAccountEntity>
    implements UserAccountLocalDataSource {
  UserAccountLocalDataSourceImpl(super.isar);

  @override
  Future<List<SimpleLibraryEntity>?> retrieveUserSelections() async {
    final settings =
        await currentCollection.filter().idGreaterThan(-1).findFirst();
    if (settings != null) {
      return settings.userSelections;
    }

    return [];
  }

  @override
  Future<void> delete() {
    return isar.writeTxn(() {
      return currentCollection.clear();
    });
  }

  @override
  Future<String?> getFirebaseToken() async {
    final usr = await currentCollection.filter().idGreaterThan(-1).findFirst();
    if (usr != null) {
      return usr.firebaseToken;
    }

    return '';
  }

  @override
  Future<CurrentUserAccountEntity?> retrieve() {
    return currentCollection.filter().idGreaterThan(-1).findFirst();
  }

  @override
  Future<void> save(CurrentUserAccountEntity currentUserAccount) {
    return isar.writeTxn(() async {
      await currentCollection.clear();
      await currentCollection.put(currentUserAccount);
    });
  }

  @override
  Future<void> saveAuthToken(String authToken) {
    return isar.writeTxn(() async {
      final usr =
          await currentCollection.filter().idGreaterThan(-1).findFirst();
      if (usr != null) {
        usr.token = authToken;
        await currentCollection.put(usr);
      } else {
        final newSettings =
            CurrentUserAccountEntity.fromParams(localId: 1, token: authToken);
        await currentCollection.put(newSettings);
      }
    });
  }

  @override
  Future<void> saveFirebaseToken(String firebaseToken) {
    return isar.writeTxn(() async {
      final usr =
          await currentCollection.filter().idGreaterThan(-1).findFirst();
      if (usr != null) {
        usr.firebaseToken = firebaseToken;
        await currentCollection.put(usr);
      } else {
        final newSettings = CurrentUserAccountEntity.fromParams(
            localId: 1, firebaseToken: firebaseToken);
        await currentCollection.put(newSettings);
      }
    });
  }

  @override
  Future<bool> userExists() async {
    return await currentCollection.filter().idGreaterThan(-1).findFirst() !=
        null;
  }

  @override
  Future<void> saveUserSelections(List<SimpleLibraryEntity> selections) {
    return isar.writeTxn(() async {
      final usr =
          await currentCollection.filter().idGreaterThan(-1).findFirst();
      if (usr != null) {
        usr.userSelections = selections;
        await currentCollection.put(usr);
      } else {
        final newSettings = CurrentUserAccountEntity.fromParams(
            localId: 1, userSelections: selections);
        await currentCollection.put(newSettings);
      }
    });
  }
}
