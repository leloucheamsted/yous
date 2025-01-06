import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:youscribe/core/entities/current_user_account_entity.dart';

class Session extends Entity {
  Session({
    this.currentUserAccountEntity,
  });

  final CurrentUserAccountEntity? currentUserAccountEntity;
}
