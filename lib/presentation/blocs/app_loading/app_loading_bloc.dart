import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/use_cases/authentication/loading_init_use_case.dart';
import 'package:youscribe/core/use_cases/authentication/user_setup_use_case.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'app_loading_event.dart';
part 'app_loading_state.dart';

class AppLoadingBloc extends Bloc<AppLoadingEvent, AppLoadingState>
    with Debuggable, Loggable {
  AppLoadingBloc() : super(AppLoadingInitial()) {
    on<AppLoadingInitialEvent>(_initApp);
  }

  final LoadingInitUseCase _loadingInitUseCase = locator<LoadingInitUseCase>();
  final UserSetupUseCase _userSetupUseCase = locator<UserSetupUseCase>();

  @override
  String get debugName => 'AppLoadingBloc';

  Future<void> _initApp(
      AppLoadingInitialEvent event, Emitter<AppLoadingState> emitter) async {
    logInfo("App loading...");
    final result = await _loadingInitUseCase(null);
    if (result.isErr) {
      logError("App loading error: ${result.err?.message}", error: result.err);
    }

    final currentUser = await Auth.instance.offlineLogin();
    if (currentUser.isErr) {
      logError("Offline auth error: ${currentUser.err}",
          error: currentUser.err);
    }

    if (currentUser.isOk && currentUser.ok != null) {
      final res = await _userSetupUseCase(
          const UserSetupUseCaseParams(isAuthenticated: true));
      if (res.isErr) {
        logError("User setup error: ${res.err}", error: res.err);
      }
    }
  }
}
