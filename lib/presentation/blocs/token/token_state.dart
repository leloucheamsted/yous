part of 'token_bloc.dart';

sealed class TokenState extends Equatable {
  @override
  List<Object> get props => [];
}

final class TokenInitialState extends TokenState {}

final class TokenLoadedState extends TokenState {
  TokenLoadedState(
      {required this.hasAvailableToken,
      required this.availableTokensCount,
      required this.tokenProducts,
      required this.usedTokensCount,
      required this.nextTokenDate,
      required this.hasUsedTokens,
      required this.hasTokenSubscription,
      required this.hasNextToken,
      required this.hasToken});

  final bool hasTokenSubscription;
  final int availableTokensCount;
  final List<TokenProductEntity> tokenProducts;
  final int usedTokensCount;
  final bool hasUsedTokens;
  final bool hasNextToken;
  final bool hasAvailableToken;
  final bool hasToken;
  final DateTime? nextTokenDate;
  @override
  List<Object> get props => [
        hasAvailableToken,
        availableTokensCount,
        tokenProducts,
        usedTokensCount,
        hasUsedTokens,
        hasAvailableToken,
        nextTokenDate!
      ];
}

final class TokenErrorState extends TokenState {
  TokenErrorState(this.previousState, {required this.errorType});
  final ErrorType errorType;
  final TokenState previousState;

  @override
  List<Object> get props => [errorType, previousState];
}
