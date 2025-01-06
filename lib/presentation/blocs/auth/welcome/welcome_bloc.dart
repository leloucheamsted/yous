import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/use_cases/configurations/get_user_settings_use_case.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState>
    with Debuggable, Loggable {
  WelcomeBloc() : super(const WelcomeInitialState(defaultImgs)) {
    on<InitWelcomeScreenEvent>(_initialize);
  }

  final GetUserSettingsUseCase _getUserSettingsUseCase =
      locator<GetUserSettingsUseCase>();

  static const defaultImgs = [
    "onboarding_africa1.jpg",
    "onboarding_africa2.jpg",
    "onboarding_africa3.jpg",
    "onboarding_africa4.jpg"
  ];

  @override
  String get debugName => 'WelcomeBloc';

  Future<void> _initialize(
      InitWelcomeScreenEvent event, Emitter<WelcomeState> emit) async {
    logInfo("Initializing welcome screen...");
    final result = await _getUserSettingsUseCase(null);
    final List<String> imgs = [];

    if (result.isErr) {
      logError("Error while initializing welcome screen", error: result.err);
      emit(const WelcomeInitialState(defaultImgs));
      return;
    }

    final settings = result.ok!;
    if (settings.countryConfiguration == null) {
      logWarning("Country configuration is null in the welcome bloc");
      emit(const WelcomeInitialState(defaultImgs));
      return;
    }

    String imageName = "onboarding_";

    if (settings.countryConfiguration!.countryCode!.toLowerCase() == "fr") {
      imageName += "france";
    } else if (settings.countryConfiguration!.countryCode!.toLowerCase() ==
        "ma") {
      imageName += "maroc";
    } else {
      return;
    }

    for (int i = 1; i <= 4; i++) {
      imgs.add("$imageName$i.jpg");
    }

    emit(WelcomeInitialState(imgs));
  }
}
