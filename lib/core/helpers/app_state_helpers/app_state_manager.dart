import 'package:rxdart/subjects.dart';
import 'package:youscribe/core/helpers/app_state_helpers/app_states.dart';

abstract class AppStateManager {
  static final stateController = BehaviorSubject<AppStates>()
    ..add(AppStates.active);
}
