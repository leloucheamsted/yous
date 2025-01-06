// ignore_for_file: must_be_immutable

part of 'product_bloc.dart';

@immutable
sealed class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

final class ProductInitialState extends ProductState {}

final class ProductLoadedState extends ProductState {
  ProductLoadedState(
      {required this.product,
      this.suggestions = const [],
      this.collections = const [],
      this.productSize = 0,
      this.isAudio = false,
      this.canShowCollections = false,
      this.isRefreshedData = false,
      this.canFollowTheme = false,
      this.isFollowingAuthor = false,
      this.isFollowingEditor = false,
      this.isOfflineProduct = false,
      this.shouldSetPriceInfo = false,
      this.requestSync = false,
      this.priceInfo = "",
      this.isPreloadedData = false,
      this.isFollowingTheme = false,
      this.isBusy = false});

  ProductLoadedState copyWith(
      {required ProductEntity product,
      List<BaseEntity>? suggestions,
      List<BaseEntity>? collections,
      double? productSize,
      bool? isFollowing,
      bool? isAudio,
      bool? canShowCollections,
      bool? isFollowingEditor,
      bool? isFollowingAuthor,
      bool? isFollowingTheme,
      bool? canFollowTheme,
      bool? shouldSetPriceInfo,
      bool? isRefreshedData,
      String? priceInfo,
      bool? isBusy}) {
    return ProductLoadedState(
        product: product,
        isRefreshedData: this.isRefreshedData,
        suggestions: suggestions ?? this.suggestions,
        collections: collections ?? this.collections,
        productSize: productSize ?? this.productSize,
        isAudio: isAudio ?? this.isAudio,
        canFollowTheme: canFollowTheme ?? this.canFollowTheme,
        isFollowingAuthor: isFollowingAuthor ?? this.isFollowingAuthor,
        isFollowingEditor: isFollowingEditor ?? this.isFollowingEditor,
        isFollowingTheme: isFollowingTheme ?? this.isFollowingTheme,
        shouldSetPriceInfo: shouldSetPriceInfo ?? this.shouldSetPriceInfo,
        priceInfo: priceInfo ?? this.priceInfo,
        isBusy: isBusy ?? this.isBusy,
        canShowCollections: canShowCollections ?? this.canShowCollections);
  }

  final List<BaseEntity> suggestions;
  final List<BaseEntity> collections;
  final ProductEntity product;
  final double productSize;
  bool get isFollowing =>
      isFollowingAuthor || isFollowingEditor || isFollowingTheme;
  final bool isAudio;
  final bool shouldSetPriceInfo;
  final bool canShowCollections;
  final bool isFollowingEditor;
  final bool isFollowingAuthor;
  final bool isFollowingTheme;
  final bool canFollowTheme;
  final bool isOfflineProduct;
  final bool requestSync;
  final bool isPreloadedData;
  final bool isRefreshedData;
  final String priceInfo;
  final bool isBusy;

  @override
  List<Object> get props => [
        suggestions,
        collections,
        productSize,
        isAudio,
        canShowCollections,
        isFollowingEditor,
        isFollowingAuthor,
        isFollowingTheme,
        canFollowTheme,
        isPreloadedData,
        shouldSetPriceInfo,
        product.isOffline ?? false,
        product.isFavorite ?? false,
        product.isPremium ?? false,
        priceInfo,
        isBusy
      ];
}

final class ProductAddedSelectionState extends ProductState {
  ProductAddedSelectionState(this.selections, this.previousState);
  ProductState previousState;
  List<SimpleLibraryEntity> selections;

  @override
  List<Object> get props => [selections];
}

final class ProductSuccessSelectionAddState extends ProductState {
  ProductSuccessSelectionAddState(this.previousState, {required this.name});
  ProductState previousState;
  final String name;

  @override
  List<Object> get props => [];
}

final class RequestSyncState extends ProductState {
  RequestSyncState(this.previousState);
  ProductState previousState;

  @override
  List<Object> get props => [];
}

final class ProductErrorState extends ProductState {
  ProductErrorState(this.previousState, this.errorType,
      [this.showErrorMessage = true]);

  ProductState previousState;
  ErrorType errorType;
  bool showErrorMessage;

  @override
  List<Object> get props => [];
}
