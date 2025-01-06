part of 'publisher_bloc.dart';

@immutable
sealed class PublisherState extends Equatable {
  @override
  List<Object> get props => [];
}

final class PublisherInitialState extends PublisherState {}

final class PublisherStateLoadedState extends PublisherState {
  PublisherStateLoadedState(
      {required this.products,
      this.isFollowing = false,
      this.image = "",
      this.isBusy = false,
      this.biography = "",
      this.displayName = ""});

  PublisherStateLoadedState copyWith(
      {List<ProductEntity>? products,
      bool? isFollowing,
      bool? hasNext,
      String? image,
      bool? isBusy,
      String? biography,
      String? displayName}) {
    return PublisherStateLoadedState(
        products: products ?? this.products,
        image: image ?? this.image,
        isBusy: isBusy ?? this.isBusy,
        biography: biography ?? this.biography,
        isFollowing: isFollowing ?? this.isFollowing,
        displayName: displayName ?? this.displayName);
  }

  final List<ProductEntity> products;
  final bool isFollowing;
  final String displayName;
  final String image;
  final bool isBusy;
  final String biography;
  @override
  List<Object> get props =>
      [products, isFollowing, displayName, image, isBusy, biography];
}

final class PublisherErrorState extends PublisherState {
  PublisherErrorState(this.previousState, this.errorType);

  PublisherState previousState;
  ErrorType errorType;

  @override
  List<Object> get props => [];
}
