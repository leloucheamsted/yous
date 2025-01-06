import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:youscribe/core/extensions/build_context_extension.dart';
import 'package:youscribe/presentation/blocs/bloc_errors.dart';
import 'package:youscribe/presentation/blocs/notifications/notification_bloc.dart';
import 'package:youscribe/presentation/blocs/notifications/notification_item/notification_item_cubit.dart';
import 'package:youscribe/presentation/screens/account/components/notification_view_item.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/presentation/screens/shared/empty_view.dart';
import 'package:youscribe/styles/widget_styles.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({required this.option, super.key});
  final NotificationOption option;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
      final bloc = context.read<NotificationBloc>();
      if (state is NotificationErrorState) {
        if (state.errorType == ErrorType.serverError) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await Dialogs.displayGeneralAPIErrorAlert(context: context);
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.showErrorSnackBar(
                AppLocalizations.of(context)!.errorOccuredGeneralTitle);
          });
        }
        bloc.add(const DisplayedModalEvent());
        state = state.previousState;
      }
      if (state is NotificationInitialState) {
        return _loadInitView();
      }

      final loadedState = state as NotificationLoadedState;
      return Stack(children: [
        DecoratedBox(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.1,
                1,
              ],
              colors: [
                YouScribeColors.primaryAppColor,
                YouScribeColors.accentColor,
              ],
            )),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    AppLocalizations.of(context)!.newReleaseAlert,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: YouScribeColors.whiteColor,
                        fontSize: WidgetStyles.title2Size),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    option == NotificationOption.authorsOption
                        ? AppLocalizations.of(context)!
                            .stopAuthorNotificationDescription
                        : AppLocalizations.of(context)!
                            .stopEditorNotificationDescription,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: YouScribeColors.whiteColor,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.clip),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...List.generate(loadedState.followed.length, (index) {
                          final followed = loadedState.followed[index];
                          final notificationItemCubit =
                              NotificationItemCubit(followed);
                          return BlocProvider.value(
                              value: notificationItemCubit,
                              child: NotificationViewItem(
                                cubit: notificationItemCubit,
                                follow: followed,
                                notificationChecked: bloc.notificationChecked,
                              ));
                        })
                      ],
                    ),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            bloc.add(NotificationDoneEvent(option));
                            context.pop(context);
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                YouScribeColors.primaryAppColor,
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                YouScribeColors.whiteColor,
                              )),
                          child: Text(
                            AppLocalizations.of(context)!.done,
                          ))
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )),
        SizedBox(
            child: loadedState.followed.isEmpty && !loadedState.isBusy
                ? const Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EmptyView(
                        message: "",
                        color: YouScribeColors.whiteColor,
                      ),
                    ],
                  ))
                : null),
        SizedBox(
          child: loadedState.isBusy
              ? const Center(
                  child: CircularProgressIndicator(
                    color: YouScribeColors.whiteColor,
                  ),
                )
              : null,
        ),
      ]);
    }));
  }

  Widget _loadInitView() {
    return const Stack(children: [
      DecoratedBox(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
            0.1,
            1,
          ],
          colors: [
            YouScribeColors.primaryAppColor,
            YouScribeColors.accentColor,
          ],
        )),
        child: Center(
          child: CircularProgressIndicator(
            color: YouScribeColors.whiteColor,
          ),
        ),
      )
    ]);
  }
}
