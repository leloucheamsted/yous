// ignore_for_file: must_be_immutable

part of 'app_purchase_cubit.dart';

sealed class AppPurchaseState extends Equatable {
  const AppPurchaseState();

  @override
  List<Object> get props => [];
}

final class AppPurchaseInitialState extends AppPurchaseState {}

final class InternetErrorPurchaseState extends AppPurchaseState {}

final class PurchaseErrorPurchaseState extends AppPurchaseState {}

final class NoSMSAppErrorState extends AppPurchaseState {}

final class UnknowExceptionErrorState extends AppPurchaseState {}

final class AppPurchaseCompleteState extends AppPurchaseState {
  AppPurchaseCompleteState({this.isTokenScreen = false});

  bool isTokenScreen;
  @override
  List<Object> get props => [isTokenScreen];
}

final class ShowMaktabatiPurchaseState extends AppPurchaseState {}

final class ShowInAppPurchasePopupState extends AppPurchaseState {
  ShowInAppPurchasePopupState({this.price = "", this.isBusy = false});
  String price;
  bool isBusy;

  ShowInAppPurchasePopupState copyWith({String? price, bool? isBusy}) {
    return ShowInAppPurchasePopupState(price: this.price, isBusy: this.isBusy);
  }

  @override
  List<Object> get props => [price];
}

final class ShowSmsPurchaseState extends AppPurchaseState {
  ShowSmsPurchaseState(this.model);
  CountryConfigPopupEntity model;

  @override
  List<Object> get props => [model];
}
