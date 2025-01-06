import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/config/app_settings.dart';
import 'package:youscribe/core/authentication/authentication_manager.dart';
import 'package:youscribe/core/helpers/Exceptions/api_request_exceptions.dart';
import 'package:youscribe/core/use_cases/user/delete_account_use_case.dart';
import 'package:youscribe_analytics/youscribe_analytics.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

part 'help_state.dart';

class HelpCubit extends Cubit<HelpState> with Debuggable, Loggable, Trackable {
  HelpCubit() : super(HelpInitialState(false));
  final appSettings = locator<AppSettings>();
  final auth = locator<AuthenticationManager>();

  final DeleteAccountUseCase deleteAccountUseCase =
      locator<DeleteAccountUseCase>();

  @override
  String get debugName => 'HelpCubit';

  Future<void> mailToSupportYouscribe(String clientInfo) async {
    try {
      await tracker.trackUserInitiatedContactSupport();
      final Email sendEmail = Email(
        subject: clientInfo,
        recipients: [appSettings.supportEmail],
      );

      await FlutterEmailSender.send(sendEmail);
    } catch (e) {
      logError("Error occurred while mailing to Youscribe.",
          error: Exception(e));
    }
  }

  Future<void> launchURL(String uri) async {
    final Uri url = Uri.parse(uri);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> deleteAccount() async {
    try {
      emit(HelpInitialState(true));
      await deleteAccountUseCase(null);
      await auth.logOut();
    } on APIRequestException catch (e) {
      emit(HelpExceptionErrorState());

      logError("API error while deleting the user's account.",
          error: Exception(e));
    } catch (e) {
      emit(HelpExceptionErrorState());
      logError("Unknown error while deleting the user's account.",
          error: Exception(e));
    } finally {
      emit(HelpInitialState(false));
    }
  }
}
