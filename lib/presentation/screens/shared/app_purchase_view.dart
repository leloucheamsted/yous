import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:youscribe/presentation/blocs/app_purchase/app_purchase_cubit.dart';
import 'package:youscribe/presentation/blocs/token/token_bloc.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/utilities/youscribe_premium.dart';

// ignore: must_be_immutable
class AppPurchasView extends StatelessWidget {
  AppPurchasView(
      {required this.cubit,
      required this.child,
      this.isTokenScreen,
      super.key});
  AppPurchaseCubit cubit;
  Widget child;
  bool? isTokenScreen;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<AppPurchaseCubit, AppPurchaseState>(
          bloc: cubit,
          builder: (context, state) {
            final currentCubit = context.read<AppPurchaseCubit>();

            if (state is InternetErrorPurchaseState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Dialogs.displayInternetNeededAlert(context: context);
              });
            }
            if (state is UnknowExceptionErrorState) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                await Dialogs.showErrorMessageAndRequestReportAlert(
                    title: '',
                    message: AppLocalizations.of(context)!
                        .unknownErrorRetryLaterMessage,
                    context: context);
              });
            }
            if (state is AppPurchaseCompleteState) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                await Dialogs.displayCustomAlert(
                    isOneButton: true,
                    content: AppLocalizations.of(context)!
                        .subscriptionCompletionMessage,
                    context: context);
              });
              cubit.resetState();
              if (state.isTokenScreen) {
                context.read<TokenBloc>().refresh();
              }
              Provider.of<YouScribePremium>(context)
                  .loadUserStatePremiumSubscription();
            }
            if (state is ShowSmsPurchaseState) {
              final countryConfig = state.model;

              WidgetsBinding.instance.addPostFrameCallback((_) async {
                await Dialogs.displaySmsSubscriptionAlert(
                    redirectToSMSApp: currentCubit.redirectToSMSApp,
                    config: countryConfig,
                    context: context);
              });
              cubit.resetState();
            }
            if (state is NoSMSAppErrorState) {
              Navigator.pop(context);
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                await Dialogs.displayCustomAlert(
                    isOneButton: true,
                    content:
                        AppLocalizations.of(context)!.sMSAppNotFoundOnDevice,
                    context: context);
              });
              cubit.resetState();
            }
            if (state is ShowMaktabatiPurchaseState) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                final result = await Dialogs.displayCustomAlert(
                    title: AppLocalizations.of(context)!.subscriptionNeeded,
                    rightButtonText: AppLocalizations.of(context)!.faq,
                    content: AppLocalizations.of(context)!
                        .maktabatiSubscriptionNeededMessage,
                    context: context);
                if (result) {
                  await cubit.maktabatiUrlPurchase();
                }
              });
            }
            if (state is ShowInAppPurchasePopupState) {
              final price = state.price;
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                await Dialogs.displayInAppSubscriptionAlert(
                    redirectToSMSApp: currentCubit.redirectToSMSApp,
                    termsOfServices: () => cubit.termsOfServices(),
                    cancel: () => cubit.cancelPurchase(),
                    startFreeTrial: () {
                      cubit.cancelPurchase();
                      return cubit.startFreeTrial(isTokenScreen ?? false);
                    },
                    termsPrivacyPolicy: () => cubit.termsPrivacyPolicy(),
                    price: price,
                    isBusy: state.isBusy,
                    context: context);
              });
              cubit.resetState();
            }
            return child;
          }),
    );
  }
}
