part of 'author_bloc.dart';

@immutable
sealed class AuthorState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AuthorInitialState extends AuthorState {}

final class AuthorStateLoadedState extends AuthorState {
  AuthorStateLoadedState(
      {required this.products,
      this.isFollowing = false,
      this.isBusy = false,
      this.displayName = ""});

  AuthorStateLoadedState copyWith(
      {List<ProductEntity>? products,
      bool? isFollowing,
      bool? hasNext,
      bool? isBusy,
      String? displayName}) {
    return AuthorStateLoadedState(
        products: products ?? this.products,
        isFollowing: isFollowing ?? this.isFollowing,
        isBusy: isBusy ?? this.isBusy,
        displayName: displayName ?? this.displayName);
  }

  final List<ProductEntity> products;
  final bool isFollowing;
  final String displayName;
  final bool isBusy;
  @override
  List<Object> get props => [products, isFollowing, displayName, isBusy];
}

final class AuthorErrorState extends AuthorState {
  AuthorErrorState(this.previousState, this.errorType);

  AuthorState previousState;
  ErrorType errorType;

  @override
  List<Object> get props => [];
}
